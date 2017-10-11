//
//  CDRippleAnimation.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/26.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDRippleAnimation.h"

@interface CDRippleAnimation()
{
    UIImageView *_imageView;
}
@end

@implementation CDRippleAnimation

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"涟漪动画演示";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addRippleAnimation:self.view];
    
    _imageView = [[UIImageView alloc] init];
    _imageView.image = [UIImage imageNamed:@"1.jpg"];
    [self.view addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100.0);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-50.0);
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _imageView.image = [UIImage imageNamed:@"4.jpg"];
        [self addRippleAnimation:_imageView];
    });
}

- (void)addRippleAnimation:(UIView *)view
{
    CATransition *transition = [CATransition animation];
    transition.duration = 1;
    transition.type = @"rippleEffect";
    [view.layer addAnimation:transition forKey:@"path"];
}

@end
