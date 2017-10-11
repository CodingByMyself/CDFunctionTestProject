//
//  CDViewAnimation.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/18.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDViewAnimation.h"


NSInteger const AniamtionViewNum = 6;
CGFloat const AniamtionDuration = 6.0;
CGFloat const AniamtionScaleValue = 3.0;


@interface CDViewAnimation ()
{
//    UIView *_viewAnimation[AniamtionViewNum];
    UIView *_lastViewAnimation;
    BOOL _stopAnimation;
    NSInteger _index;
    NSTimer *_timerRefresh;
}
@end

@implementation CDViewAnimation

#pragma mark - 翻转动画
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


#pragma mark - 波浪动画
- (void)stratWaveAnimationWithOriginSize:(CGSize)size
{
    [self stopWaveAnimation];
    _stopAnimation = YES;
    self.layer.cornerRadius = self.bounds.size.width/2.0;
    
    //  开始循环动画
    [_timerRefresh invalidate];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSNumber numberWithFloat:size.height] forKey:@"height"];
    [dict setObject:[NSNumber numberWithFloat:size.width] forKey:@"width"];
    
    _timerRefresh = [NSTimer scheduledTimerWithTimeInterval:AniamtionDuration/6 target:self selector:@selector(refresh:) userInfo:dict repeats:YES];
    [_timerRefresh fire];
    
}

- (void)stopWaveAnimation
{
    [_timerRefresh invalidate];
    _stopAnimation = YES;
    [_lastViewAnimation removeFromSuperview];
}

- (void)refresh:(NSTimer *)timer
{
    CGFloat width = [[[timer userInfo] objectForKey:@"width"] floatValue];
    CGFloat height = [[[timer userInfo] objectForKey:@"height"] floatValue];
    NSLog(@"(%f , %f)",width,height);
    //  初始化波浪效果的view
    __block UIView *viewAnimation = [[UIView alloc] init];
    viewAnimation.transform = CGAffineTransformIdentity;
    viewAnimation.clipsToBounds = YES;
    viewAnimation.alpha = 0.2;
    viewAnimation.backgroundColor = [UIColor whiteColor];
    viewAnimation.bounds = CGRectMake(0, 0, width, height);
    viewAnimation.center = CGPointMake(self.cd_x+self.cd_width/2.0,self.cd_y+self.cd_height/2.0);
    [self.superview addSubview:viewAnimation];
    _lastViewAnimation = viewAnimation;
    [self.superview bringSubviewToFront:self];
    
    //  设置波浪的效果
    viewAnimation.layer.cornerRadius = width/2.0;
    
    // 开始动画
    [UIView animateWithDuration:AniamtionDuration animations: ^{
        CGAffineTransform scaleUpAnimationOut = CGAffineTransformMakeScale(AniamtionScaleValue, AniamtionScaleValue);
        viewAnimation.transform = scaleUpAnimationOut;
        
        viewAnimation.alpha = 0;
    } completion: ^(BOOL finished) {
        viewAnimation.transform = CGAffineTransformIdentity;
        [viewAnimation removeFromSuperview];
        if (_stopAnimation == NO) {
            [_timerRefresh invalidate];
        }
    }];
}


@end
