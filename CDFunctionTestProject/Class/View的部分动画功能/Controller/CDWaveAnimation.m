//
//  CDWaveAnimation.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/18.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDWaveAnimation.h"

NSString *const kPulseAnimation = @"kPulseAnimation";
NSInteger const AniamtionViewNum = 4;
CGFloat const AniamtionDuration = 5.0f;


@interface CDWaveAnimation ()
{
    UIButton *_button;
    
    UIView *_viewTarget;
    UIView *_viewAnimation[AniamtionViewNum];
    BOOL _stopAnimation;
    NSInteger _index;
    NSTimer *_timerRefresh;
}
@end

@implementation CDWaveAnimation

#pragma mark -
- (void)startCustomAniamtionWithBody:(BOOL)body
{
    _stopAnimation = YES;
    //  初始化目标view
    _viewTarget = [[UIView alloc] init];
    _viewTarget.backgroundColor = DefineColorRGB(64.0, 185.0, 216.0, 1.0);
    [self.view addSubview:_viewTarget];
    [_viewTarget mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_viewTarget.superview).offset(0);
        make.height.equalTo(@(100.0));
        make.width.equalTo(@(100.0));
        make.centerX.equalTo(@(0));
    }];
    [self.view layoutIfNeeded];
    _viewTarget.layer.cornerRadius = _viewTarget.bounds.size.width/2.0;
    
    //  初始化波浪效果的view
    for (NSInteger i = 0; i < AniamtionViewNum ; i ++) {
        _viewAnimation[i] = [[UIView alloc] init];
        [self.view addSubview:_viewAnimation[i]];
        [_viewAnimation[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_viewTarget.superview).offset(0);
            make.height.equalTo(@(100.0));
            make.width.equalTo(@(100.0));
            make.centerX.equalTo(@(0));
        }];
        [self.view layoutIfNeeded];
        
        CGFloat radius = _viewAnimation[i].bounds.size.width/2.0;
        if (body) {
            [_viewAnimation[i] jm_setCornerRadius:radius withBorderColor:DefineColorRGB(64.0, 185.0, 216.0, 1.0) borderWidth:1.0 backgroundColor:[UIColor clearColor] backgroundImage:nil contentMode:UIViewContentModeScaleToFill];
        } else {
            _viewAnimation[i].alpha = 0.4;
            [_viewAnimation[i] jm_setCornerRadius:radius withBackgroundColor:DefineColorRGB(64.0, 185.0, 216.0, 1.0)];
        }
    }
    //  将目标view显示到最上层
    [self.view bringSubviewToFront:_viewTarget];
    
    //  开始循环动画
    [_timerRefresh invalidate];
    _timerRefresh = [NSTimer scheduledTimerWithTimeInterval:AniamtionDuration/AniamtionViewNum target:self selector:@selector(refreshOutCircleRadius:) userInfo:[NSNumber numberWithBool:body] repeats:YES];
    [_timerRefresh fire];
}

- (void)refreshOutCircleRadius:(NSTimer *)timer
{
    BOOL body = [[timer userInfo] boolValue];
    [UIView animateWithDuration:AniamtionDuration animations: ^{
        CGAffineTransform scaleUpAnimationOut = CGAffineTransformMakeScale(4.0, 4.0);
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


#pragma mark - view
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"波动画演示";
    self.view.backgroundColor = DefineColorRGB(18.0, 17.0, 35.0, 1.0);
    
//    [self initAnimationView];
    [self startCustomAniamtionWithBody:YES];
}



#pragma mark -
- (void)initAnimationView
{
    _button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100.0, 100.0)];
    _button.backgroundColor = DefineColorRGB(64.0, 185.0, 216.0, 1.0);
    _button.center = CGPointMake(self.view.center.x, self.view.center.y/3.2*5);
    _button.layer.cornerRadius = _button.bounds.size.width / 2;
    [_button addTarget:self action:@selector(modifyAnimationStatus:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    
    CGFloat dur = 3.0;
    [self waveAnimationLayerWithView:_button diameter:12*100 duration:dur+0.6];
    [self waveAnimationLayerWithView:_button diameter:9*100 duration:dur+0.6];
    [self waveAnimationLayerWithView:_button diameter:7*100 duration:dur+0.6];
    [self waveAnimationLayerWithView:_button diameter:5*100 duration:dur+0.6];
}

- (void)modifyAnimationStatus:(UIButton *)button {
    BOOL isAnimating = NO;
    NSArray *layerArr = [NSArray arrayWithArray:button.superview.layer.sublayers];
    
    for (CALayer *layer in layerArr) {
        if ([layer.animationKeys containsObject:kPulseAnimation]) {
            isAnimating = YES;
            [layer removeAllAnimations];
            [layer removeFromSuperlayer];
        }
    }
    
    if (!isAnimating) {
        CGFloat dur = 3.0;
        [self waveAnimationLayerWithView:_button diameter:12*100 duration:dur+0.6];
        [self waveAnimationLayerWithView:_button diameter:9*100 duration:dur+0.6];
        [self waveAnimationLayerWithView:_button diameter:7*100 duration:dur+0.6];
        [self waveAnimationLayerWithView:_button diameter:5*100 duration:dur+0.6];
    }
}

- (CALayer *)waveAnimationLayerWithView:(UIView *)view diameter:(CGFloat)diameter duration:(CGFloat)duration {
    CALayer *waveLayer = [CALayer layer];
    waveLayer.bounds = CGRectMake(0, 0, diameter, diameter);    //diameter 扩散的大小
    waveLayer.cornerRadius = diameter / 2; //设置圆角变为圆形
    waveLayer.position = view.center;
    waveLayer.backgroundColor = [DefineColorRGB(64.0, 185.0, 216.0, 1.0) CGColor];
    [view.superview.layer insertSublayer:waveLayer below:view.layer];//把扩散层放到播放按钮下面
    
    CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = duration;
    animationGroup.repeatCount = 0; //重复无限次
    animationGroup.removedOnCompletion = YES;
    
    CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animationGroup.timingFunction = defaultCurve;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    scaleAnimation.fromValue = @0.1; //开始的大小
    scaleAnimation.toValue = @1.0; //最后的大小
    scaleAnimation.duration = duration;
    scaleAnimation.removedOnCompletion = YES;
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @0.4; //开始的大小
    opacityAnimation.toValue = @0.0; //最后的大小
    opacityAnimation.duration = duration;
    opacityAnimation.removedOnCompletion = YES;
    
    animationGroup.animations = @[scaleAnimation, opacityAnimation];
    [waveLayer addAnimation:animationGroup forKey:kPulseAnimation];
    
    return waveLayer;
}

@end
