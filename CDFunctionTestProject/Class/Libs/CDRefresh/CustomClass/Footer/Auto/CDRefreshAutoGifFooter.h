//
//  CDRefreshAutoGifFooter.h
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/6/14.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import "CDRefreshAutoStateFooter.h"

@interface CDRefreshAutoGifFooter : CDRefreshAutoStateFooter

@property (weak, nonatomic, readonly) UIImageView *gifView;

/** 设置state状态下的动画图片images 动画持续时间duration*/
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(CDRefreshState)state;
- (void)setImages:(NSArray *)images forState:(CDRefreshState)state;

@end
