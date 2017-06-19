//
//  CTPRefreshHeader.m
//  EOA
//
//  Created by Cindy on 2017/6/14.
//
//

#import "CTPRefreshHeader.h"
#import "UIView+CDRefreshExtension.h"


@interface CTPRefreshHeader()
@property (strong, nonatomic) UILabel *labelDescrip;
@property (strong, nonatomic) UIImageView *logo;
@property (strong, nonatomic) UIActivityIndicatorView *loading;
@end



@implementation CTPRefreshHeader


- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 60.0;
    
    // 添加label
    self.labelDescrip.textColor = DefineColorHEX(0xcacaca);
    
    
    // logo
    self.logo.image = [UIImage imageNamed:@"refresh_eim_logo"];
    
    // loading
    self.loading.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    self.loading.alpha = 0.8;
}

#pragma mark - Getter Method
- (UIImageView *)logo
{
    if (_logo == nil) {
        _logo = [[UIImageView alloc] init];
        _logo.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_logo];
        [_logo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self).offset(-10.0);
            make.centerX.equalTo(self);
            make.width.equalTo(@60.0);
            make.height.equalTo(@20.0);
        }];
    }
    return _logo;
}

- (UILabel *)labelDescrip
{
    if (_labelDescrip == nil) {
        _labelDescrip = [[UILabel alloc] init];
        _labelDescrip.textColor = DefineColorHEX(0xb3b3b3);
        _labelDescrip.font = [UIFont systemFontOfSize:12];
        _labelDescrip.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_labelDescrip];
        [_labelDescrip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.logo.mas_bottom).offset(6.0);
            make.centerX.equalTo(self.logo);
            make.width.equalTo(@100.0);
        }];
    }
    return _labelDescrip;
}

- (UIActivityIndicatorView *)loading
{
    if (_loading == nil) {
        _loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:_loading];
        [_loading mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.logo.mas_right).offset(8.0);
            make.centerY.equalTo(self);
        }];
    }
    return _loading;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
//    self.label.frame = self.bounds;
//    
//    self.logo.bounds = CGRectMake(0, 0, self.bounds.size.width, 100);
//    self.logo.center = CGPointMake(self.mj_w * 0.5, - self.logo.mj_h + 20);
//    
//    self.loading.center = CGPointMake(self.mj_w - 30, self.mj_h * 0.5);
    
    CGFloat width = [self.labelDescrip textRectForBounds:CGRectMake(0, 0, DefineScreenWidth, 60.0) limitedToNumberOfLines:1].size.width;
    [self.labelDescrip mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(width+10.0));
    }];
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(CDRefreshState)state
{
    CDRefreshCheckState;
    
    switch (state) {
        case CDRefreshStateIdle:
        {
            [self.loading stopAnimating];
            self.labelDescrip.text = @"下拉刷新";
            [self.logo mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self).offset(0);
            }];
        }
            break;
        case CDRefreshStatePulling:
        {
            [self.loading stopAnimating];
            self.labelDescrip.text = @"松开刷新";
            [self.logo mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self).offset(0);
            }];
        }
            break;
        case CDRefreshStateRefreshing:
        {
            self.labelDescrip.text = @"正在刷新";
            [self.loading startAnimating];
            [self.logo mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self).offset(-10.0);
            }];
        }
            break;
        default:
            break;
    }
    
//    [UIView animateWithDuration:0.15 animations:^{
//        [self layoutIfNeeded];
//    }];
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    // 1.0 0.5 0.0
    // 0.5 0.0 0.5
//    CGFloat red = 1.0 - pullingPercent * 0.5;
//    CGFloat green = 0.5 - 0.5 * pullingPercent;
//    CGFloat blue = 0.5 * pullingPercent;
//    self.labelDescrip.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}




@end
