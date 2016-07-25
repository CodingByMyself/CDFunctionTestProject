//
//  UIImage+CDColorCategory.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/25.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "UIImage+CDColorCategory.h"

@implementation UIImage (CDColorCategory)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext(); return image;
}

@end
