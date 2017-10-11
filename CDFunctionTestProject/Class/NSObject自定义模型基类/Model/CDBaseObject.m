//
//  CDBaseObject.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/20.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDBaseObject.h"
#import <objc/runtime.h>

@implementation CDBaseObject

#pragma mark - -  1、将模型转换成字典字符串输出 -
#pragma mark Public method
- (NSDictionary *)cd_ModelDescription
{
    //  获得属性列表
    u_int count;
    objc_property_t *properties  = class_copyPropertyList([self class], &count);
    NSMutableArray *propertiesList = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        const char* propertyName = property_getName(properties[i]);
        [propertiesList addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties);
    
    //  开始遍历属性
    NSMutableDictionary *modelDict = [[NSMutableDictionary alloc] init];
    for (NSString *key in propertiesList) {
        id valueObj = [self valueForKey:key];
        if (valueObj) {
            if ([valueObj isKindOfClass:[NSArray class]]) {
                [modelDict setObject:[self keyValueStringArray:valueObj] forKey:key];
            } else if ([valueObj isKindOfClass:[NSDictionary class]]) {
                [modelDict setObject:[self keyValueStringDictionary:valueObj] forKey:key];
            } else if ([valueObj isKindOfClass:[CDBaseObject class]]){
                [modelDict setObject:[valueObj cd_ModelDescription] forKey:key];
            } else {
                [modelDict setObject:valueObj forKey:key];
            }
        }
    }
    return [NSDictionary dictionaryWithDictionary:modelDict];
}

#pragma mark  Private method
- (NSArray *)keyValueStringArray:(NSArray *)array
{
    NSMutableArray *keyValueArray = [NSMutableArray new];
    for (NSInteger i = 0; i < [array count] ; i ++) {
        if (array[i]) {
            if ([array[i] isKindOfClass:[NSArray class]]) {
                [keyValueArray addObject:[self keyValueStringArray:array[i]]];
            } else if ([array[i] isKindOfClass:[NSDictionary class]]) {
                [keyValueArray addObject:[self keyValueStringDictionary:array[i]]];
            } else if ([array[i] isKindOfClass:[CDBaseObject class]]) {
                [keyValueArray addObject:[array[i] cd_ModelDescription]];
            } else {
                [keyValueArray addObject:array[i]];
            }
        }
    }
    
    return keyValueArray;
}

- (NSDictionary *)keyValueStringDictionary:(NSDictionary *)dict
{
    NSMutableDictionary *keyValueDict = [NSMutableDictionary new];
    NSArray *keyArray = [dict allKeys];
    for (NSString *key in keyArray) {
        id valueObj = [dict objectForKey:key];
        if (valueObj) {
            if ([valueObj isKindOfClass:[NSArray class]]) {
                [keyValueDict setObject:[self keyValueStringArray:valueObj] forKey:key];
            } else if ([valueObj isKindOfClass:[NSDictionary class]]) {
                [keyValueDict setObject:[self keyValueStringDictionary:valueObj] forKey:key];
            } else if ([valueObj isKindOfClass:[CDBaseObject class]]) {
                [keyValueDict setObject:[valueObj cd_ModelDescription] forKey:key];
            } else {
                [keyValueDict setObject:valueObj forKey:key];
            }
        }
    }
    return keyValueDict;
}

#pragma mark - - 2、将json数据中的key对应到OC模型中属性定义 -
#pragma mark Public method
static char replaceDictionaryKey; // 定义一个关联的key
+ (void)cd_dictionaryToLogJsonData:(NSData *)jsonData andKey:(NSString *)key andKeyReplaceDictionary:(NSDictionary *)dict
{
    if (!jsonData || jsonData.length == 0 || !jsonData) {
        return;
    }
    objc_setAssociatedObject([CDBaseObject class], &replaceDictionaryKey, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    NSLog(@"Loading......");
    NSDictionary *temDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    [self findTheValue:key andDict:temDict];
}

#pragma mark  Private method
+ (void)findTheValue:(NSString *)str andDict:(NSDictionary *)dict
{
    NSArray *ak = dict.allKeys;
    for (NSString *keyName in ak) {
        if ([keyName isEqualToString:str]) {
            // 如果找到了相应的key，去除key对应的value
            id tem = dict[keyName];
            // 获取关联值
            NSDictionary *temDict = objc_getAssociatedObject([CDBaseObject class], &replaceDictionaryKey);
            if ([tem isKindOfClass:[NSDictionary class]]) {
                [CDBaseObject handleDict:tem andKeyreplaces:temDict];
                [CDBaseObject findTheValue:str andDict:tem];  // 继续递归，遍历下一层，如果是字典的话
            } else if ([tem isKindOfClass:[NSArray class]] && [tem count] >= 1) {
                [CDBaseObject handleDict:tem[0] andKeyreplaces:temDict];
                [CDBaseObject findTheValue:str andDict:tem[0]]; // 如果是数组，只取第0个数据，并且传值继续递归
            } else {
                NSLog(@"Format is not correct");
            }
            objc_setAssociatedObject([CDBaseObject class], &replaceDictionaryKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            return;  //  本层循环结束
        } else {
            id tem = dict[keyName];
            if ([tem isKindOfClass:[NSDictionary class]]) {
                [CDBaseObject findTheValue:str andDict:tem];  // 递归，遍历下一层，如果是字典的话
            } else if ([tem isKindOfClass:[NSArray class]] && [tem count] >= 1) {
                [CDBaseObject findTheValue:str andDict:tem[0]]; // 如果是数组，只取第0个数据，并且传值递归
            } else {
                // 其他
            }
        }
    }
}

+ (void)handleDict:(NSDictionary *)dict andKeyreplaces:(NSDictionary *)kDict
{
    NSMutableString *mustr = [NSMutableString new];
    
    __block NSDictionary *temDict = kDict;
    // 确定相应值里面的元素，有哪些属性
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // 三元运算，先确定要替换值是否存在于请求返回的数据，然后确定temDict不为nil
        NSString *temKey = temDict ? (temDict[key] ? temDict[key] : key) : key;
        if ([obj isKindOfClass:[NSNumber class]]) {
            [mustr appendString:[NSString stringWithFormat:@"@property (strong, nonatomic) NSNumber *%@;\n", temKey]];
        } else if ([obj isKindOfClass:[NSArray class]]) {
            [mustr appendString:[NSString stringWithFormat:@"@property (strong, nonatomic) NSArray *%@;\n", temKey]];
        } else {
            [mustr appendString:[NSString stringWithFormat:@"@property (retain, nonatomic) NSString *%@;\n", temKey]];
        }
    }];
    
    NSLog(@"\n/**********   CDPrintKey(start)  ***********/\n%@/********** CDPrintKey(end)  ***********/\n \n ", mustr);
}

@end
