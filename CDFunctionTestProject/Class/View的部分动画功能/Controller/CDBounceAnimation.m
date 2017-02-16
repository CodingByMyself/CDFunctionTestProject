//
//  CDBounceAnimation.m
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/2/16.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import "CDBounceAnimation.h"

@interface CDBounceView : UIView {
    UILabel *_labelPunchCardTimeDescrip;
}
@property (nonatomic,strong) UIView *viewAlert;
@property (nonatomic,strong) UIView *viewContent;
@property (nonatomic,strong) UIButton *buttonSure;
@end
@implementation CDBounceView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.backgroundColor = DefineColorRGB(0, 0, 0, 0.6);
    self.viewAlert.clipsToBounds = YES;
    self.viewAlert.layer.cornerRadius = 4.0f;
    
    [self.buttonSure addTarget:self action:@selector(buttonClickedEventOnSuccessedAlertView:) forControlEvents:UIControlEventTouchUpInside];
    self.buttonSure.tag = 2;
    
    self.viewContent.backgroundColor = [UIColor clearColor];
    
}

#pragma mark Public Method
- (void)showAlertView
{
    [self startBounceAnimationWithScale:0.7 rate:0];
}

- (void)closeALertView
{
    [UIView animateWithDuration:0.2 animations: ^{
        CGAffineTransform scaleUpAnimationOut = CGAffineTransformMakeScale(0.01, 1.0);
        self.viewAlert.transform = scaleUpAnimationOut;
        self.alpha = 0;
    } completion: ^(BOOL finished) {
        self.viewAlert.transform = CGAffineTransformIdentity;
        [self removeFromSuperview];
        self.alpha = 1.0;
    }];
}

- (void)setPunchCardTime:(NSString *)timeString
{
    _labelPunchCardTimeDescrip.text = timeString;
}

#pragma mark Private Method
- (void)startBounceAnimationWithScale:(CGFloat)scale rate:(NSInteger)rate
{
    [UIView animateWithDuration:0.1 animations: ^{
        CGAffineTransform scaleUpAnimationOut = CGAffineTransformMakeScale(scale, scale);
        self.viewAlert.transform = scaleUpAnimationOut;
    } completion: ^(BOOL finished) {
        if (rate == -1) {
            self.viewAlert.transform = CGAffineTransformIdentity;
        } else {
            CGFloat newScale = (rate%2 == 0) ? (1.12 - rate/2*0.12) : (0.7 + rate/2*0.4);
            CGFloat newRate = (newScale == 1) ? -1 : (rate + 1);
            [self startBounceAnimationWithScale:newScale rate:newRate];
        }
    }];
}

#pragma mark Action
- (void)buttonClickedEventOnSuccessedAlertView:(UIButton *)button
{
    [self closeALertView];
}

#pragma mark Getter Method
- (UIView *)viewAlert
{
    if (_viewAlert == nil) {
        // 弹出框视图
        _viewAlert = [[UIView alloc] init];
        _viewAlert.backgroundColor = [UIColor whiteColor];
        [self addSubview:_viewAlert];
        [_viewAlert mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_viewAlert.superview.mas_centerX);
            make.centerY.equalTo(_viewAlert.superview.mas_centerY);
            make.left.equalTo(_viewAlert.superview).offset(20.0/320*DefineScreenWidth);
            make.right.equalTo(_viewAlert.superview).offset(-20.0/320*DefineScreenWidth);
            make.height.equalTo(@(200));
        }];
    }
    return _viewAlert;
}

- (UIButton *)buttonSure
{
    if (_buttonSure == nil) {
        // 弹框内的确定按钮
        _buttonSure = [[UIButton alloc] init];
        _buttonSure.clipsToBounds = YES;
        _buttonSure.backgroundColor = DefineColorRGB(23, 159, 224, 1.0);
        [_buttonSure setTitle:@"确定" forState:UIControlStateNormal];
        _buttonSure.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        [self.viewAlert addSubview:_buttonSure];
        [_buttonSure mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_buttonSure.superview);
            make.right.equalTo(_buttonSure.superview);
            make.bottom.equalTo(_buttonSure.superview);
            make.height.equalTo(@50.0);
        }];
    }
    return _buttonSure;
}

- (UIView *)viewContent
{
    if (_viewContent == nil) {
        // 弹框内的提示内容
        _viewContent = [[UIView alloc] init];
        _viewContent.clipsToBounds = YES;
        [self.viewAlert addSubview:_viewContent];
        [_viewContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_viewContent.superview);
            make.right.equalTo(_viewContent.superview);
            make.top.equalTo(_viewContent.superview);
            make.bottom.equalTo(self.buttonSure.mas_top);
        }];
        
        // close
        UIButton *buttonClose = [[UIButton alloc] init];
        [buttonClose addTarget:self action:@selector(buttonClickedEventOnSuccessedAlertView:) forControlEvents:UIControlEventTouchUpInside];
        buttonClose.tag = 1;
        [buttonClose setImage:[UIImage imageNamed:@"punch_close_alert"] forState:UIControlStateNormal];
        [_viewContent addSubview:buttonClose];
        [buttonClose mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(buttonClose.superview);
            make.top.equalTo(buttonClose.superview);
            make.height.equalTo(@40.0);
            make.width.equalTo(@40.0);
        }];
        
        // descrip
        _labelPunchCardTimeDescrip = [[UILabel alloc] init];
        _labelPunchCardTimeDescrip.text = @"时间：2016-10-17 08:55:05";
        _labelPunchCardTimeDescrip.font = [UIFont systemFontOfSize:15.0];
        _labelPunchCardTimeDescrip.textColor  =[UIColor lightGrayColor];
        [_viewContent addSubview:_labelPunchCardTimeDescrip];
        CGSize txtSize = [_labelPunchCardTimeDescrip textRectForBounds:CGRectMake(0, 0, DefineScreenWidth, 25.0) limitedToNumberOfLines:0].size;
        [_labelPunchCardTimeDescrip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.width.equalTo(@(txtSize.width));
            make.top.equalTo(_labelPunchCardTimeDescrip.superview.mas_centerY).offset(10.0);
            make.centerX.equalTo(_labelPunchCardTimeDescrip.superview.mas_centerX).offset(32.0);
        }];
        
        // title
        UILabel *labelTitle = [[UILabel alloc] init];
        labelTitle.text = @"您已打卡成功!";
        labelTitle.font = [UIFont boldSystemFontOfSize:20.0];
        labelTitle.textColor = [UIColor blackColor];
        [_viewContent addSubview:labelTitle];
        [labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.left.equalTo(_labelPunchCardTimeDescrip);
            make.bottom.equalTo(labelTitle.superview.mas_centerY).offset(0);
        }];
        
        // icon
        UIImageView *imageTipView = [[UIImageView alloc] init];
        imageTipView.image = [UIImage imageNamed:@"punch_ok"];
        imageTipView.contentMode = UIViewContentModeScaleAspectFit;
        [_viewContent addSubview:imageTipView];
        [imageTipView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_labelPunchCardTimeDescrip.mas_left).offset(-10.0);
            make.top.equalTo(labelTitle).offset(2.0);
            make.bottom.equalTo(_labelPunchCardTimeDescrip.mas_bottom).offset(-2.0);
            make.width.equalTo(imageTipView.mas_height);
        }];
    }
    return _viewContent;
}

@end

#pragma mark
@interface CDBounceAnimation ()

@end

@implementation CDBounceAnimation

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"弹跳动画";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"开始弹跳动画" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClickedEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@50.0);
        make.centerY.equalTo(self.view);
    }];
}

- (void)buttonClickedEvent:(UIButton *)button
{
    CDBounceView *bounceView = [[CDBounceView alloc] init];
    [[[UIApplication sharedApplication] keyWindow] addSubview:bounceView];
    [bounceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bounceView.superview);
    }];
    [bounceView showAlertView];
}

@end
