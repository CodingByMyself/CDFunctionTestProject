//
//  UIView+CDAnimation.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/12.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "UIView+CDAnimation.h"

@implementation UIView (CDAnimation)

- (void)startFlipAnimation:(CGFloat)animation onSubviewOne:(UIView *)subviewFirst subviewTwo:(UIView *)subviewSeconde
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:animation];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self cache:YES];
    
    //这里时查找视图里的子视图（这种情况查找，可能时因为父视图里面不只两个视图）
    NSInteger fist= [[self subviews] indexOfObject:subviewFirst];
    NSInteger seconde= [[self subviews] indexOfObject:subviewSeconde];
    
    [self exchangeSubviewAtIndex:fist withSubviewAtIndex:seconde];
    //当父视图里面只有两个视图的时候，可以直接使用下面这段.
    //[self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}


@end
