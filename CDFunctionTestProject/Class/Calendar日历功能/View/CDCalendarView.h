//
//  CDCalendarView.h
//  CDFunctionTestProject
//
//  Created by Cindy on 16/8/4.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDDateHelper.h"

@protocol CDMangocityCalendarViewDelegate;

@interface CDCalendarView : UIView

@property (nonatomic,weak) id <CDMangocityCalendarViewDelegate> delegate;

@property (nonatomic,assign) BOOL allowsMultipleSelection;  //  是否允许多选
@property (nonatomic, readonly) CDDateHelper *dateHelper;  //  日期帮助的工具类
@property (nonatomic,readonly) NSDate *todayDate;  //  今天的日期
@property (nonatomic,strong) NSDate *minDate;  //  可以显示的最小日期
@property (nonatomic,strong) NSDate *maxDate;  //  可以显示的最大日期


#pragma mark - public method
- (void)showCalendarWithTargetView:(UIView *)targetView;
- (void)hiddenCalendar;

@end


@protocol CDMangocityCalendarViewDelegate <NSObject>
/**
 *  相应日期对应的价格描述
 *
 *  @param calendar 日历控件
 *  @param dayDate  当前日期
 *
 *  @return 当前对应的价格
 */
- (NSString *)mangocityCalendarView:(CDCalendarView *)calendar subTitleStringOnDay:(NSDate *)dayDate;

/**
 *  是否允许可选事件
 *
 *  @param calendar 日历控件
 *  @param dayDate  天日期
 *
 *  @return 允许可选的布尔值
 */
- (BOOL)mangocityCalendar:(CDCalendarView *)calendar shouldSelectDate:(NSDate *)dayDate;

/**
 *  日历中的某个日期被选中的回调事件
 *
 *  @param calendar 日历控件
 *  @param dayDate  日期天
 */
- (void)mangocityCalendar:(CDCalendarView *)calendar didTouchDay:(NSDate *)dayDate;

@end







