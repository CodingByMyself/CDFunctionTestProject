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
CGFloat const AniamtionScaleValue = 3.5;


@interface CDViewAnimation ()
{
    UIView *_viewAnimation[AniamtionViewNum];
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
- (void)stratWaveAnimationWithBody:(BOOL)body
{
    [self stopWaveAnimation];
    [self.superview layoutIfNeeded];
    [self layoutIfNeeded];
    self.layer.cornerRadius = self.bounds.size.width/2.0;
    
    _stopAnimation = YES;
    
    //  初始化波浪效果的view
    for (NSInteger i = 0; i < AniamtionViewNum ; i ++) {
        _viewAnimation[i] = [[UIView alloc] init];
        _viewAnimation[_index].transform = CGAffineTransformIdentity;
        _viewAnimation[i].clipsToBounds = YES;
        [self.superview addSubview:_viewAnimation[i]];
        [_viewAnimation[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
        }];
        [_viewAnimation[i] layoutIfNeeded];
        [self.superview layoutIfNeeded];
        
        //  设置波浪的效果
        CGFloat radius = _viewAnimation[i].bounds.size.width/2.0;
        if (body) {
            [_viewAnimation[i] jm_setCornerRadius:radius withBorderColor:DefineColorRGB(64.0, 185.0, 216.0, 1.0) borderWidth:1.0 backgroundColor:[UIColor clearColor] backgroundImage:nil contentMode:UIViewContentModeScaleToFill];
        } else {
            _viewAnimation[i].alpha = 0.4;
            [_viewAnimation[i] jm_setCornerRadius:radius withBackgroundColor:DefineColorRGB(64.0, 185.0, 216.0, 1.0)];
        }
    }
    
    //  开始循环动画
    [_timerRefresh invalidate];
    _timerRefresh = [NSTimer scheduledTimerWithTimeInterval:AniamtionDuration/(AniamtionViewNum - 1) target:self selector:@selector(refreshOutCircleRadius:) userInfo:[NSNumber numberWithBool:body] repeats:YES];
    [_timerRefresh fire];
    
}

- (void)stopWaveAnimation
{
    [_timerRefresh invalidate];
    _stopAnimation = YES;
    for (NSInteger i = 0; i < AniamtionViewNum ; i ++) {
        [_viewAnimation[i] removeFromSuperview];
    }
}

- (void)refreshOutCircleRadius:(NSTimer *)timer
{
    BOOL body = [[timer userInfo] boolValue];
    [UIView animateWithDuration:AniamtionDuration animations: ^{
        CGAffineTransform scaleUpAnimationOut = CGAffineTransformMakeScale(AniamtionScaleValue, AniamtionScaleValue);
        _viewAnimation[_index].transform = scaleUpAnimationOut;
        _viewAnimation[_index].alpha = 0.0;
    } completion: ^(BOOL finished) {
        _viewAnimation[_index].transform = CGAffineTransformIdentity;
        if (body) {
            _viewAnimation[_index].alpha = 1.0;
        } else {
            _viewAnimation[_index].alpha = 0.4;
        }
        
        if (_stopAnimation == NO) {
            [_timerRefresh invalidate];
        }
    }];
    
    if (++_index >= AniamtionViewNum) {
        _index = 0;
    }
}


@end
