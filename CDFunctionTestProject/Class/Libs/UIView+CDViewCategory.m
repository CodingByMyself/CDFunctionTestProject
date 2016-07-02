//
//  UIView+CDViewCategory.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/6/25.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "UIView+CDViewCategory.h"

@implementation UIView (CDViewCategory)


- (CGFloat)cd_height
{
    return self.bounds.size.height;
}

- (CGFloat)cd_width
{
    return self.bounds.size.width;
}

- (CGFloat)cd_x
{
    return self.frame.origin.x;
}

- (CGFloat)cd_y
{
    return self.frame.origin.y;
}

- (void)setCd_height:(CGFloat)cd_height
{
    CGRect oldFrame = self.frame;
    self.frame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y, oldFrame.size.width, cd_height);
}

- (void)setCd_width:(CGFloat)cd_width
{
    CGRect oldFrame = self.frame;
    self.frame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y, cd_width, oldFrame.size.height);
}

- (void)setCd_x:(CGFloat)cd_x
{
    CGRect oldFrame = self.frame;
    self.frame = CGRectMake(cd_x, oldFrame.origin.y, oldFrame.size.width, oldFrame.size.height);
}

- (void)setCd_y:(CGFloat)cd_y
{
    CGRect oldFrame = self.frame;
    self.frame = CGRectMake(oldFrame.origin.x, cd_y, oldFrame.size.width, oldFrame.size.height);
}

#pragma mark
- (void)removeAllSubviews
{
    NSArray *subs = [self subviews];
    for (UIView *sub in subs) {
        [sub removeFromSuperview];
    }
}


@end
