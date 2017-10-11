//
//  CDRefreshBackStateFooter.m
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/6/14.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import "CDRefreshBackStateFooter.h"
#import "NSBundle+CDRefresh.h"


@interface CDRefreshBackStateFooter()
{
    /** 显示刷新状态的label */
    __unsafe_unretained UILabel *_stateLabel;
}
/** 所有状态对应的文字 */
@property (strong, nonatomic) NSMutableDictionary *stateTitles;
@end


@implementation CDRefreshBackStateFooter

#pragma mark - 懒加载
- (NSMutableDictionary *)stateTitles
{
    if (!_stateTitles) {
        self.stateTitles = [NSMutableDictionary dictionary];
    }
    return _stateTitles;
}

- (UILabel *)stateLabel
{
    if (!_stateLabel) {
        [self addSubview:_stateLabel = [UILabel mj_label]];
    }
    return _stateLabel;
}

#pragma mark - 公共方法
- (void)setTitle:(NSString *)title forState:(CDRefreshState)state
{
    if (title == nil) return;
    self.stateTitles[@(state)] = title;
    self.stateLabel.text = self.stateTitles[@(self.state)];
}

- (NSString *)titleForState:(CDRefreshState)state {
    return self.stateTitles[@(state)];
}

#pragma mark - 重写父类的方法
- (void)prepare
{
    [super prepare];
    
    // 初始化间距
    self.labelLeftInset = CDRefreshLabelLeftInset;
    
    // 初始化文字
    [self setTitle:[NSBundle mj_localizedStringForKey:CDRefreshBackFooterIdleText] forState:CDRefreshStateIdle];
    [self setTitle:[NSBundle mj_localizedStringForKey:CDRefreshBackFooterPullingText] forState:CDRefreshStatePulling];
    [self setTitle:[NSBundle mj_localizedStringForKey:CDRefreshBackFooterRefreshingText] forState:CDRefreshStateRefreshing];
    [self setTitle:[NSBundle mj_localizedStringForKey:CDRefreshBackFooterNoMoreDataText] forState:CDRefreshStateNoMoreData];
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    if (self.stateLabel.constraints.count) return;
    
    // 状态标签
    self.stateLabel.frame = self.bounds;
}

- (void)setState:(CDRefreshState)state
{
    CDRefreshCheckState
    
    // 设置状态文字
    self.stateLabel.text = self.stateTitles[@(state)];
}

@end
