//
//  CDRefreshBackFooter.m
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/6/14.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import "CDRefreshBackFooter.h"
#import "UIScrollView+CDRefreshExtension.h"
#import "UIScrollView+CDRefresh.h"
#import "UIView+CDRefreshExtension.h"



@interface CDRefreshBackFooter()

@property (assign, nonatomic) NSInteger lastRefreshCount;
@property (assign, nonatomic) CGFloat lastBottomDelta;

@end



@implementation CDRefreshBackFooter

#pragma mark - 初始化
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    [self scrollViewContentSizeDidChange:nil];
}

#pragma mark - 实现父类的方法
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
    // 如果正在刷新，直接返回
    if (self.state == CDRefreshStateRefreshing) return;
    
    _scrollViewOriginalInset = self.scrollView.contentInset;
    
    // 当前的contentOffset
    CGFloat currentOffsetY = self.scrollView.mj_offsetY;
    // 尾部控件刚好出现的offsetY
    CGFloat happenOffsetY = [self happenOffsetY];
    // 如果是向下滚动到看不见尾部控件，直接返回
    if (currentOffsetY <= happenOffsetY) return;
    
    CGFloat pullingPercent = (currentOffsetY - happenOffsetY) / self.mj_h;
    
    // 如果已全部加载，仅设置pullingPercent，然后返回
    if (self.state == CDRefreshStateNoMoreData) {
        self.pullingPercent = pullingPercent;
        return;
    }
    
    if (self.scrollView.isDragging) {
        self.pullingPercent = pullingPercent;
        // 普通 和 即将刷新 的临界点
        CGFloat normal2pullingOffsetY = happenOffsetY + self.mj_h;
        
        if (self.state == CDRefreshStateIdle && currentOffsetY > normal2pullingOffsetY) {
            // 转为即将刷新状态
            self.state = CDRefreshStatePulling;
        } else if (self.state == CDRefreshStatePulling && currentOffsetY <= normal2pullingOffsetY) {
            // 转为普通状态
            self.state = CDRefreshStateIdle;
        }
    } else if (self.state == CDRefreshStatePulling) {// 即将刷新 && 手松开
        // 开始刷新
        [self beginRefreshing];
    } else if (pullingPercent < 1) {
        self.pullingPercent = pullingPercent;
    }
}

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
    // 内容的高度
    CGFloat contentHeight = self.scrollView.mj_contentH + self.ignoredScrollViewContentInsetBottom;
    // 表格的高度
    CGFloat scrollHeight = self.scrollView.mj_h - self.scrollViewOriginalInset.top - self.scrollViewOriginalInset.bottom + self.ignoredScrollViewContentInsetBottom;
    // 设置位置和尺寸
    self.mj_y = MAX(contentHeight, scrollHeight);
}

- (void)setState:(CDRefreshState)state
{
    CDRefreshCheckState
    
    // 根据状态来设置属性
    if (state == CDRefreshStateNoMoreData || state == CDRefreshStateIdle) {
        // 刷新完毕
        if (CDRefreshStateRefreshing == oldState) {
            [UIView animateWithDuration:CDRefreshSlowAnimationDuration animations:^{
                self.scrollView.mj_insetB -= self.lastBottomDelta;
                
                // 自动调整透明度
                if (self.isAutomaticallyChangeAlpha) self.alpha = 0.0;
            } completion:^(BOOL finished) {
                self.pullingPercent = 0.0;
                
                if (self.endRefreshingCompletionBlock) {
                    self.endRefreshingCompletionBlock();
                }
            }];
        }
        
        CGFloat deltaH = [self heightForContentBreakView];
        // 刚刷新完毕
        if (CDRefreshStateRefreshing == oldState && deltaH > 0 && self.scrollView.mj_totalDataCount != self.lastRefreshCount) {
            self.scrollView.mj_offsetY = self.scrollView.mj_offsetY;
        }
    } else if (state == CDRefreshStateRefreshing) {
        // 记录刷新前的数量
        self.lastRefreshCount = self.scrollView.mj_totalDataCount;
        
        [UIView animateWithDuration:CDRefreshFastAnimationDuration animations:^{
            CGFloat bottom = self.mj_h + self.scrollViewOriginalInset.bottom;
            CGFloat deltaH = [self heightForContentBreakView];
            if (deltaH < 0) { // 如果内容高度小于view的高度
                bottom -= deltaH;
            }
            self.lastBottomDelta = bottom - self.scrollView.mj_insetB;
            self.scrollView.mj_insetB = bottom;
            self.scrollView.mj_offsetY = [self happenOffsetY] + self.mj_h;
        } completion:^(BOOL finished) {
            [self executeRefreshingCallback];
        }];
    }
}

- (void)endRefreshing
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.state = CDRefreshStateIdle;
    });
}

- (void)endRefreshingWithNoMoreData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.state = CDRefreshStateNoMoreData;
    });
}
#pragma mark - 私有方法
#pragma mark 获得scrollView的内容 超出 view 的高度
- (CGFloat)heightForContentBreakView
{
    CGFloat h = self.scrollView.frame.size.height - self.scrollViewOriginalInset.bottom - self.scrollViewOriginalInset.top;
    return self.scrollView.contentSize.height - h;
}

#pragma mark 刚好看到上拉刷新控件时的contentOffset.y
- (CGFloat)happenOffsetY
{
    CGFloat deltaH = [self heightForContentBreakView];
    if (deltaH > 0) {
        return deltaH - self.scrollViewOriginalInset.top;
    } else {
        return - self.scrollViewOriginalInset.top;
    }
}

@end
