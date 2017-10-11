//
//  CDTestBlurViewController.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/21.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDTestBlurViewController.h"
#import "FXBlurView.h"


@interface CDTestBlurViewController ()

@end

@implementation CDTestBlurViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"模糊效果";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *bg = [[UIImageView alloc] init];
//    bg.backgroundColor = [UIColor yellowColor];
    bg.image = [UIImage imageNamed:@"IMG_2705.JPG"];
    bg.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    FXBlurView *fxView = [[FXBlurView alloc] init];
    fxView.dynamic = YES;
    fxView.blurRadius = 30.0;
    [self.view addSubview:fxView];
    [fxView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@(64.0));
    }];
    
    FXBlurView *fxView1 = [[FXBlurView alloc] init];
    fxView1.dynamic = YES;
    fxView1.blurRadius = 20.0;
    [self.view addSubview:fxView1];
    [fxView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view).offset(10);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@(64.0));
    }];
    
    FXBlurView *fxView2 = [[FXBlurView alloc] init];
    fxView2.dynamic = YES;
    fxView2.blurRadius = 20.0;
    [self.view addSubview:fxView2];
    [fxView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(0);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@(64.0));
    }];
}


@end
