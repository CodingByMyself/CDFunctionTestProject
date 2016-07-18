//
//  CDWaveAnimation.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/18.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDWaveAnimation.h"
#import "CDViewAnimation.h"

@interface CDWaveAnimation ()
{
    UIButton *_button;
    
    CDViewAnimation *_viewTarget;
}
@end

@implementation CDWaveAnimation

#pragma mark -
- (void)initTargetView
{
    //  初始化目标view
    _viewTarget = [[CDViewAnimation alloc] init];
    _viewTarget.backgroundColor = DefineColorRGB(64.0, 185.0, 216.0, 1.0);
    _viewTarget.clipsToBounds = YES;
    [self.view addSubview:_viewTarget];
    [_viewTarget mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_viewTarget.superview).offset(-50.0);
        make.height.equalTo(@(120.0));
        make.width.equalTo(@(120.0));
        make.centerX.equalTo(@(0));
    }];
    [self.view layoutIfNeeded];
    [_viewTarget stratWaveAnimationWithBody:YES];
}

#pragma mark - view
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"波动画演示";
    self.view.backgroundColor = DefineColorRGB(18.0, 17.0, 35.0, 1.0);
    
//    [self initAnimationView];
    [self initTargetView];
}



#pragma mark -
//- (void)initAnimationView
//{
//    _button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100.0, 100.0)];
//    _button.backgroundColor = DefineColorRGB(64.0, 185.0, 216.0, 1.0);
//    _button.center = CGPointMake(self.view.center.x, self.view.center.y/3.2*5);
//    _button.layer.cornerRadius = _button.bounds.size.width / 2;
//    [_button addTarget:self action:@selector(modifyAnimationStatus:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_button];
//    
//    CGFloat dur = 3.0;
//    [self waveAnimationLayerWithView:_button diameter:12*100 duration:dur+0.6];
//    [self waveAnimationLayerWithView:_button diameter:9*100 duration:dur+0.6];
//    [self waveAnimationLayerWithView:_button diameter:7*100 duration:dur+0.6];
//    [self waveAnimationLayerWithView:_button diameter:5*100 duration:dur+0.6];
//}
//
//- (void)modifyAnimationStatus:(UIButton *)button {
//    BOOL isAnimating = NO;
//    NSArray *layerArr = [NSArray arrayWithArray:button.superview.layer.sublayers];
//    
//    for (CALayer *layer in layerArr) {
//        if ([layer.animationKeys containsObject:@"kPulseAnimation"]) {
//            isAnimating = YES;
//            [layer removeAllAnimations];
//            [layer removeFromSuperlayer];
//        }
//    }
//    
//    if (!isAnimating) {
//        CGFloat dur = 3.0;
//        [self waveAnimationLayerWithView:_button diameter:12*100 duration:dur+0.6];
//        [self waveAnimationLayerWithView:_button diameter:9*100 duration:dur+0.6];
//        [self waveAnimationLayerWithView:_button diameter:7*100 duration:dur+0.6];
//        [self waveAnimationLayerWithView:_button diameter:5*100 duration:dur+0.6];
//    }
//}
//
//- (CALayer *)waveAnimationLayerWithView:(UIView *)view diameter:(CGFloat)diameter duration:(CGFloat)duration {
//    CALayer *waveLayer = [CALayer layer];
//    waveLayer.bounds = CGRectMake(0, 0, diameter, diameter);    //diameter 扩散的大小
//    waveLayer.cornerRadius = diameter / 2; //设置圆角变为圆形
//    waveLayer.position = view.center;
//    waveLayer.backgroundColor = [DefineColorRGB(64.0, 185.0, 216.0, 1.0) CGColor];
//    [view.superview.layer insertSublayer:waveLayer below:view.layer];//把扩散层放到播放按钮下面
//    
//    CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
//    animationGroup.duration = duration;
//    animationGroup.repeatCount = 0; //重复无限次
//    animationGroup.removedOnCompletion = YES;
//    
//    CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//    animationGroup.timingFunction = defaultCurve;
//    
//    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
//    scaleAnimation.fromValue = @0.1; //开始的大小
//    scaleAnimation.toValue = @1.0; //最后的大小
//    scaleAnimation.duration = duration;
//    scaleAnimation.removedOnCompletion = YES;
//    
//    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
//    opacityAnimation.fromValue = @0.4; //开始的大小
//    opacityAnimation.toValue = @0.0; //最后的大小
//    opacityAnimation.duration = duration;
//    opacityAnimation.removedOnCompletion = YES;
//    
//    animationGroup.animations = @[scaleAnimation, opacityAnimation];
//    [waveLayer addAnimation:animationGroup forKey:@"kPulseAnimation"];
//    
//    return waveLayer;
//}

@end
