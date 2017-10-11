//
//  UIScrollView+CDRefreshExtension.m
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/6/14.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import "UIScrollView+CDRefreshExtension.h"
#import <objc/runtime.h>


@implementation UIScrollView (CDRefreshExtension)


- (void)setMj_insetT:(CGFloat)mj_insetT
{
    UIEdgeInsets inset = self.contentInset;
    inset.top = mj_insetT;
    self.contentInset = inset;
}

- (CGFloat)mj_insetT
{
    return self.contentInset.top;
}

- (void)setMj_insetB:(CGFloat)mj_insetB
{
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = mj_insetB;
    self.contentInset = inset;
}

- (CGFloat)mj_insetB
{
    return self.contentInset.bottom;
}

- (void)setMj_insetL:(CGFloat)mj_insetL
{
    UIEdgeInsets inset = self.contentInset;
    inset.left = mj_insetL;
    self.contentInset = inset;
}

- (CGFloat)mj_insetL
{
    return self.contentInset.left;
}

- (void)setMj_insetR:(CGFloat)mj_insetR
{
    UIEdgeInsets inset = self.contentInset;
    inset.right = mj_insetR;
    self.contentInset = inset;
}

- (CGFloat)mj_insetR
{
    return self.contentInset.right;
}

- (void)setMj_offsetX:(CGFloat)mj_offsetX
{
    CGPoint offset = self.contentOffset;
    offset.x = mj_offsetX;
    self.contentOffset = offset;
}

- (CGFloat)mj_offsetX
{
    return self.contentOffset.x;
}

- (void)setMj_offsetY:(CGFloat)mj_offsetY
{
    CGPoint offset = self.contentOffset;
    offset.y = mj_offsetY;
    self.contentOffset = offset;
}

- (CGFloat)mj_offsetY
{
    return self.contentOffset.y;
}

- (void)setMj_contentW:(CGFloat)mj_contentW
{
    CGSize size = self.contentSize;
    size.width = mj_contentW;
    self.contentSize = size;
}

- (CGFloat)mj_contentW
{
    return self.contentSize.width;
}

- (void)setMj_contentH:(CGFloat)mj_contentH
{
    CGSize size = self.contentSize;
    size.height = mj_contentH;
    self.contentSize = size;
}

- (CGFloat)mj_contentH
{
    return self.contentSize.height;
}




@end
