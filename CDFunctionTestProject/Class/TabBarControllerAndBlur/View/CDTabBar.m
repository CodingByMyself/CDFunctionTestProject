//
//  CDTabBar.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/25.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDTabBar.h"

@interface CDTabBar()
@property(nonatomic,strong)UIButton *plusBtn;
@end

@implementation CDTabBar
@dynamic delegate;

- (UIButton *)plusBtn
{
    if (_plusBtn == nil) {
        _plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [_plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [_plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [_plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [_plusBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_plusBtn];
    }
    return _plusBtn;
}
- (void)btnAction
{
    if ([self.delegate respondsToSelector:@selector(cdTabBarClickCenterPlusBtn:)]) {
        [self.delegate cdTabBarClickCenterPlusBtn:self];
    }
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    Class class = NSClassFromString(@"UITabBarButton");
    CGFloat width = self.width / 5;
    self.plusBtn.width = width;
    self.plusBtn.height = self.height;
    self.plusBtn.cd_y = 0;
    NSInteger index = 0;
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:class]) {
            if (index == 2) {
                self.plusBtn.cd_x = index * width;
                index ++;
            }
            view.cd_x = index * width;
            //            view.width = width;
            //            view.y = 0;
            //            view.height = self.height;
            index ++;
        }
    }
}


@end
