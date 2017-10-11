//
//  CDBaseObject.h
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/20.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDBaseObject : NSObject


#pragma mark Public method

/**
 *  为继承自CDBaseObject的模型的提供一个具体内容描述的接口
 *
 *  @return 返回一个封装好的字典对象
 */
- (NSDictionary *)cd_ModelDescription;



/**
 *  打印模型类的所有属性
 *
 *  @param urlStr 请求URL
 *  @param key    要获取的值的key
 *  @param dict   要替换名字的属性，可以为nil
 */
+ (void)cd_dictionaryToLogJsonData:(NSData *)urlStr andKey:(NSString *)key andKeyReplaceDictionary:(NSDictionary *)dict;


@end
