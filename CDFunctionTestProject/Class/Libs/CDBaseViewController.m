//
//  CDBaseViewController.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/25.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDBaseViewController.h"
#import "FXBlurView.h"

@interface CDBaseViewController()
{
    FXBlurView *_viewNavigation;
    UIButton *_backItem;
}
@end

@implementation CDBaseViewController

- (void)back:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - view
- (void)viewWillLayoutSubviews
{
    [self.view bringSubviewToFront:_viewNavigation];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _viewNavigation = [[FXBlurView alloc] initWithFrame:CGRectMake(0, 0, DefineScreenWidth, CDNavigationBarHeight)];
    _viewNavigation.dynamic = YES;
    _viewNavigation.blurRadius = 20.0;
    [self.view addSubview:_viewNavigation];
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, _viewNavigation.cd_height - 1.0, _viewNavigation.cd_width, 1.0)];
    bg.backgroundColor = DefineColorRGB(180.0, 180.0, 180.0, 0.2);
    bg.layer.shadowColor = DefineColorRGB(180.0, 180.0, 180.0, 1.0).CGColor; //shadowColor阴影颜色
    bg.layer.shadowOffset = CGSizeMake(0.0f , 1.0); //shadowOffset阴影偏移x，y向(上/下)偏移(-/+)2
    bg.layer.shadowOpacity = 0.8;//阴影透明度，默认0
    bg.layer.shadowRadius = 1.0;//阴影半径
    [_viewNavigation addSubview:bg];


    _backItem = [[UIButton alloc] initWithFrame:CGRectMake(0, CDNavigationBarOffset, 60.0, CDNavigationBarHeight - CDNavigationBarOffset)];
    [_backItem setTitle:@"返回" forState:UIControlStateNormal];
    [_backItem setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    _backItem.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [_backItem addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [_viewNavigation addSubview:_backItem];
}

- (void)viewWillAppear:(BOOL)animated
{
    
}

@end
