//
//  CDRefreshBackStateFooter.h
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/6/14.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import "CDRefreshBackFooter.h"

@interface CDRefreshBackStateFooter : CDRefreshBackFooter

/** 文字距离圈圈、箭头的距离 */
@property (assign, nonatomic) CGFloat labelLeftInset;
/** 显示刷新状态的label */
@property (weak, nonatomic, readonly) UILabel *stateLabel;
/** 设置state状态下的文字 */
- (void)setTitle:(NSString *)title forState:(CDRefreshState)state;

/** 获取state状态下的title */
- (NSString *)titleForState:(CDRefreshState)state;

@end
