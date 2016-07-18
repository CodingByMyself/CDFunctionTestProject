//
//  CDFlipAnimation.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/18.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDFlipAnimation.h"
#import "CDViewAnimation.h"

@interface CDFlipAnimation ()
{
    CDViewAnimation *_flipAnimationBgView;
    UIView *_viewOne;
    UIView *_viewTwo;
}
@end

@implementation CDFlipAnimation

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"翻转动画演示";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //    UIBarButtonItem *flipButton=[[UIBarButtonItem alloc]
    //                                 initWithTitle:@"翻转"
    //                                 style:UIBarButtonItemStyleBordered
    //                                 target:self
    //                                 action:@selector(startFlipAnimation)];
    //    self.navigationItem.rightBarButtonItem=flipButton;
    
    [self initView];  // 初始化动画相关的view
    
}

- (void)initView
{
    // 动画背景
    _flipAnimationBgView = [CDViewAnimation new];
    [self.view addSubview:_flipAnimationBgView];
    _flipAnimationBgView.sd_layout .topSpaceToView(_flipAnimationBgView.superview,20.0) .leftSpaceToView(_flipAnimationBgView.superview,20.0) .rightSpaceToView(_flipAnimationBgView.superview,20.0) .heightIs(100.0);
    _flipAnimationBgView.clipsToBounds = YES;
    _flipAnimationBgView.layer.cornerRadius = 5.0f;
    // 视图三
    _viewOne = [UIView new];
    _viewOne.backgroundColor=[UIColor redColor];
    [_flipAnimationBgView addSubview:_viewOne];
    _viewOne.sd_layout.topSpaceToView(_flipAnimationBgView,0) .leftSpaceToView(_flipAnimationBgView,0) .rightSpaceToView(_flipAnimationBgView,0) .bottomSpaceToView(_flipAnimationBgView,0);
    //  视图二
    _viewTwo = [UIView new];
    _viewTwo.backgroundColor=[UIColor yellowColor];
    [_flipAnimationBgView addSubview:_viewTwo];
    _viewTwo.sd_layout .topSpaceToView(_flipAnimationBgView,0) .leftSpaceToView(_flipAnimationBgView,0) .rightSpaceToView(_flipAnimationBgView,0) .bottomSpaceToView(_flipAnimationBgView,0);
    
    UIButton *button = [UIButton new];
    [_flipAnimationBgView addSubview:button];
    [button setTitle:@"点我可以翻转哦" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(startFlipAnimation) forControlEvents:UIControlEventTouchUpInside];
    button.sd_layout.leftSpaceToView(_flipAnimationBgView,0) .rightSpaceToView(_flipAnimationBgView,0) .centerYIs(_flipAnimationBgView.centerY_sd) .heightIs(50.0);
}

- (void)startFlipAnimation
{
    [_flipAnimationBgView startFlipAnimation:0.8 onSubviewOne:_viewOne subviewTwo:_viewTwo];
}

@end
