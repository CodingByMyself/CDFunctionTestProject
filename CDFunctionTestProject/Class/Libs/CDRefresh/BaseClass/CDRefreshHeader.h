//
//  CDRefreshHeader.h
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/6/14.
//  Copyright © 2017年 Cindy. All rights reserved.
//  下拉刷新控件:负责监控用户下拉的状态

#import "CDRefreshComponent.h"

@interface CDRefreshHeader : CDRefreshComponent

/** 创建header */
+ (instancetype)headerWithRefreshingBlock:(CDRefreshComponentRefreshingBlock)refreshingBlock;
/** 创建header */
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

/** 这个key用来存储上一次下拉刷新成功的时间 */
@property (copy, nonatomic) NSString *lastUpdatedTimeKey;
/** 上一次下拉刷新成功的时间 */
@property (strong, nonatomic, readonly) NSDate *lastUpdatedTime;

/** 忽略多少scrollView的contentInset的top */
@property (assign, nonatomic) CGFloat ignoredScrollViewContentInsetTop;


@end
