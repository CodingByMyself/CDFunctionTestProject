//
//  CDRefreshConst.h
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/6/14.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#ifndef CDRefreshConst_h
#define CDRefreshConst_h





#import <UIKit/UIKit.h>
#import <objc/message.h>

// 弱引用
#define CDWeakSelf __weak typeof(self) weakSelf = self;

// 日志输出
#ifdef DEBUG
#define CDRefreshLog(...) NSLog(__VA_ARGS__)
#else
#define CDRefreshLog(...)
#endif

// 过期提醒
#define CDRefreshDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

// 运行时objc_msgSend
#define CDRefreshMsgSend(...) ((void (*)(void *, SEL, UIView *))objc_msgSend)(__VA_ARGS__)
#define CDRefreshMsgTarget(target) (__bridge void *)(target)

// RGB颜色
#define CDRefreshColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 文字颜色
#define CDRefreshLabelTextColor CDRefreshColor(90, 90, 90)

// 字体大小
#define CDRefreshLabelFont [UIFont boldSystemFontOfSize:14]

// 常量
UIKIT_EXTERN const CGFloat CDRefreshLabelLeftInset;
UIKIT_EXTERN const CGFloat CDRefreshHeaderHeight;
UIKIT_EXTERN const CGFloat CDRefreshFooterHeight;
UIKIT_EXTERN const CGFloat CDRefreshFastAnimationDuration;
UIKIT_EXTERN const CGFloat CDRefreshSlowAnimationDuration;

UIKIT_EXTERN NSString *const CDRefreshKeyPathContentOffset;
UIKIT_EXTERN NSString *const CDRefreshKeyPathContentSize;
UIKIT_EXTERN NSString *const CDRefreshKeyPathContentInset;
UIKIT_EXTERN NSString *const CDRefreshKeyPathPanState;

UIKIT_EXTERN NSString *const CDRefreshHeaderLastUpdatedTimeKey;

UIKIT_EXTERN NSString *const CDRefreshHeaderIdleText;
UIKIT_EXTERN NSString *const CDRefreshHeaderPullingText;
UIKIT_EXTERN NSString *const CDRefreshHeaderRefreshingText;

UIKIT_EXTERN NSString *const CDRefreshAutoFooterIdleText;
UIKIT_EXTERN NSString *const CDRefreshAutoFooterRefreshingText;
UIKIT_EXTERN NSString *const CDRefreshAutoFooterNoMoreDataText;

UIKIT_EXTERN NSString *const CDRefreshBackFooterIdleText;
UIKIT_EXTERN NSString *const CDRefreshBackFooterPullingText;
UIKIT_EXTERN NSString *const CDRefreshBackFooterRefreshingText;
UIKIT_EXTERN NSString *const CDRefreshBackFooterNoMoreDataText;

UIKIT_EXTERN NSString *const CDRefreshHeaderLastTimeText;
UIKIT_EXTERN NSString *const CDRefreshHeaderDateTodayText;
UIKIT_EXTERN NSString *const CDRefreshHeaderNoneLastDateText;

// 状态检查
#define CDRefreshCheckState \
CDRefreshState oldState = self.state; \
if (state == oldState) return; \
[super setState:state];







#endif /* CDRefreshConst_h */
