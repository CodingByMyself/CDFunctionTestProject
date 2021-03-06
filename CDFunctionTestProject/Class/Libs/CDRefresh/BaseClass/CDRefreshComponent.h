//
//  CDRefreshComponent.h
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/6/14.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDRefreshConst.h"

/** 刷新控件的状态 */
typedef NS_ENUM(NSInteger, CDRefreshState) {
    /** 普通闲置状态 */
    CDRefreshStateIdle = 1,
    /** 松开就可以进行刷新的状态 */
    CDRefreshStatePulling,
    /** 正在刷新中的状态 */
    CDRefreshStateRefreshing,
    /** 即将刷新的状态 */
    CDRefreshStateWillRefresh,
    /** 所有数据加载完毕，没有更多的数据了 */
    CDRefreshStateNoMoreData
};

/** 进入刷新状态的回调 */
typedef void (^CDRefreshComponentRefreshingBlock)();
/** 开始刷新后的回调(进入刷新状态后的回调) */
typedef void (^CDRefreshComponentbeginRefreshingCompletionBlock)();
/** 结束刷新后的回调 */
typedef void (^CDRefreshComponentEndRefreshingCompletionBlock)();




@interface CDRefreshComponent : UIView

{
    /** 记录scrollView刚开始的inset */
    UIEdgeInsets _scrollViewOriginalInset;
    /** 父控件 */
    __weak UIScrollView *_scrollView;
}
#pragma mark - 刷新回调
/** 正在刷新的回调 */
@property (copy, nonatomic) CDRefreshComponentRefreshingBlock refreshingBlock;
/** 设置回调对象和回调方法 */
- (void)setRefreshingTarget:(id)target refreshingAction:(SEL)action;

/** 回调对象 */
@property (weak, nonatomic) id refreshingTarget;
/** 回调方法 */
@property (assign, nonatomic) SEL refreshingAction;
/** 触发回调（交给子类去调用） */
- (void)executeRefreshingCallback;

#pragma mark - 刷新状态控制
/** 进入刷新状态 */
- (void)beginRefreshing;
- (void)beginRefreshingWithCompletionBlock:(void (^)())completionBlock;
/** 开始刷新后的回调(进入刷新状态后的回调) */
@property (copy, nonatomic) CDRefreshComponentbeginRefreshingCompletionBlock beginRefreshingCompletionBlock;
/** 结束刷新的回调 */
@property (copy, nonatomic) CDRefreshComponentEndRefreshingCompletionBlock endRefreshingCompletionBlock;
/** 结束刷新状态 */
- (void)endRefreshing;
- (void)endRefreshingWithCompletionBlock:(void (^)())completionBlock;
/** 是否正在刷新 */
- (BOOL)isRefreshing;
/** 刷新状态 一般交给子类内部实现 */
@property (assign, nonatomic) CDRefreshState state;

#pragma mark - 交给子类去访问
/** 记录scrollView刚开始的inset */
@property (assign, nonatomic, readonly) UIEdgeInsets scrollViewOriginalInset;
/** 父控件 */
@property (weak, nonatomic, readonly) UIScrollView *scrollView;

#pragma mark - 交给子类们去实现
/** 初始化 */
- (void)prepare NS_REQUIRES_SUPER;
/** 摆放子控件frame */
- (void)placeSubviews NS_REQUIRES_SUPER;
/** 当scrollView的contentOffset发生改变的时候调用 */
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;
/** 当scrollView的contentSize发生改变的时候调用 */
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;
/** 当scrollView的拖拽状态发生改变的时候调用 */
- (void)scrollViewPanStateDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;


#pragma mark - 其他
/** 拉拽的百分比(交给子类重写) */
@property (assign, nonatomic) CGFloat pullingPercent;
/** 根据拖拽比例自动切换透明度 */
@property (assign, nonatomic, getter=isAutoChangeAlpha) BOOL autoChangeAlpha CDRefreshDeprecated("请使用automaticallyChangeAlpha属性");
/** 根据拖拽比例自动切换透明度 */
@property (assign, nonatomic, getter=isAutomaticallyChangeAlpha) BOOL automaticallyChangeAlpha;

@end



@interface UILabel(CDRefresh)
+ (instancetype)mj_label;
- (CGFloat)mj_textWith;
@end

