//
//  UIView+CDViewCategory.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/6/25.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "UIView+CDViewCategory.h"

@implementation UIView (CDViewCategory)

#pragma mark - 自定义设置或获取view的frame属性
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

#pragma mark - 移除view中包含的所有子view
- (void)removeAllSubviews
{
    NSArray *subs = [self subviews];
    for (UIView *sub in subs) {
        [sub removeFromSuperview];
    }
}

#pragma mark  - 自定义绘制指定边框效果
@dynamic borderWhich;
- (void)setBorderWhich:(ZJViewBorder)borderWhich
{
    CGColorRef col = self.layer.borderColor;
    CGFloat borderWidth = self.layer.borderWidth;
    if (self.layer.borderWidth > 1000 || self.layer.borderWidth == 0) {
        borderWidth = 1;
    }

    if (borderWhich & ZJViewBorderBottom) {
        CALayer *border = [CALayer layer];
        border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, borderWidth);
        border.backgroundColor = col;
        [self.layer addSublayer:border];
    }
    if (borderWhich & ZJViewBorderLeft) {
        CALayer *border = [CALayer layer];
        border.frame = CGRectMake(0, 0, borderWidth, self.frame.size.height);
        border.backgroundColor = col;
        [self.layer addSublayer:border];
    }
    if (borderWhich & ZJViewBorderRight) {
        CALayer *border = [CALayer layer];
        border.frame = CGRectMake(self.frame.size.width - borderWidth, 0, borderWidth, self.frame.size.height);
        border.backgroundColor = col;
        [self.layer addSublayer:border];
    }
    if (borderWhich & ZJViewBorderTop) {
        CALayer *border = [CALayer layer];
        border.frame = CGRectMake(0, 0, self.frame.size.width, borderWidth);
        border.backgroundColor = col;
        [self.layer addSublayer:border];
    }
    
    self.layer.borderWidth = 0;
}

@end
