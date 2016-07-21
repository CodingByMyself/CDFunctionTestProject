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

#pragma mark - 将模型转换成字典字符串输出
#pragma mark Public method
- (NSDictionary *)modelDescription
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
                [modelDict setObject:[valueObj modelDescription] forKey:key];
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
                [keyValueArray addObject:[array[i] modelDescription]];
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
                [keyValueDict setObject:[valueObj modelDescription] forKey:key];
            } else {
                [keyValueDict setObject:valueObj forKey:key];
            }
        }
    }
    return keyValueDict;
}

#pragma mark  overwrite
- (NSString *)baseDescription
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[self modelDescription] options:NSJSONWritingPrettyPrinted error:&parseError];
    NSLog(@"parseError -- > %@",parseError);
    NSString *descr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return descr;
}

@end
