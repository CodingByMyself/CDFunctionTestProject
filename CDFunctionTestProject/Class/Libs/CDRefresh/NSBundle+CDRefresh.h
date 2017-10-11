//
//  NSBundle+CDRefresh.h
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/6/14.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (CDRefresh)

+ (instancetype)mj_refreshBundle;
+ (UIImage *)mj_arrowImage;
+ (NSString *)mj_localizedStringForKey:(NSString *)key value:(NSString *)value;
+ (NSString *)mj_localizedStringForKey:(NSString *)key;

@end
