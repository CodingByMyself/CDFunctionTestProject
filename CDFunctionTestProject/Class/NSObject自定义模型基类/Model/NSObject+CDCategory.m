//
//  NSObject+CDCategory.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/20.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "NSObject+CDCategory.h"
#import <objc/runtime.h>

@implementation NSObject (CDCategory)

#pragma mark - 将json数据中的key对应到OC模型中属性定义
// 定义一个关联的key
static char replaceDictionaryKey;
- (void)cd_dictionaryToLogJsonData:(NSData *)jsonData andKey:(NSString *)key andKeyReplaceDictionary:(NSDictionary *)dict
{
    if (!jsonData || jsonData.length == 0 || !jsonData) {
        return;
    }
    objc_setAssociatedObject(self, &replaceDictionaryKey, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    NSLog(@"Loading......");
    NSDictionary *temDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    [self findTheValue:key andDict:temDict];
}

- (void)findTheValue:(NSString *)str andDict:(NSDictionary *)dict
{
    NSArray *ak = dict.allKeys;
    for (NSString *keyName in ak) {
        if ([keyName isEqualToString:str]) {
            // 如果找到了相应的key，去除key对应的value
            id tem = dict[keyName];
            // 获取关联值
            NSDictionary *temDict = objc_getAssociatedObject(self, &replaceDictionaryKey);
            if ([tem isKindOfClass:[NSDictionary class]]) {
                [self handleDict:tem andKeyreplaces:temDict];
                [self findTheValue:str andDict:tem];  // 继续递归，遍历下一层，如果是字典的话
            } else if ([tem isKindOfClass:[NSArray class]] && [tem count] >= 1) {
                [self handleDict:tem[0] andKeyreplaces:temDict];
                [self findTheValue:str andDict:tem[0]]; // 如果是数组，只取第0个数据，并且传值继续递归
            } else {
                NSLog(@"Format is not correct");
            }
            objc_setAssociatedObject(self, &replaceDictionaryKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            break;  //  本层循环结束
        } else {
            id tem = dict[keyName];
            if ([tem isKindOfClass:[NSDictionary class]]) {
                [self findTheValue:str andDict:tem];  // 递归，遍历下一层，如果是字典的话
            } else if ([tem isKindOfClass:[NSArray class]] && [tem count] >= 1) {
                [self findTheValue:str andDict:tem[0]]; // 如果是数组，只取第0个数据，并且传值递归
            } else {
                // 其他
            }
        }
    }
}

- (void)handleDict:(NSDictionary *)dict andKeyreplaces:(NSDictionary *)kDict
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
