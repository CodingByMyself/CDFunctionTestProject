//
//  CDCalendarView.h
//  CDFunctionTestProject
//
//  Created by Cindy on 16/8/4.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDDateHelper.h"
#import "FSCalendar.h"
@class CDCalendarView;

#pragma mark - 为芒果网专用日历而扩展的一系列代理协议方法
@protocol CDMangocityCalendarViewDelegate <NSObject>
/**
 *  相应日期对应的价格描述
 *
 *  @param calendar 日历控件
 *  @param dayDate  需要描述的日期
 *
 *  @return 当前对应的价格
 */
- (NSString *)mangocityCalendarView:(CDCalendarView *)calendar subTitleStringOnDay:(NSDate *)dayDate;

/**
 *  是否允许可选事件
 *
 *  @param calendar 日历控件
 *  @param dayDate  是否允许的日期
 *
 *  @return 允许可选的布尔值
 */
- (BOOL)mangocityCalendar:(CDCalendarView *)calendar shouldSelectDate:(NSDate *)dayDate;

/**
 *  日历中的某个日期被选中的回调事件
 *
 *  @param calendar 日历控件
 *  @param dayDate  被选中的日期
 */
- (void)mangocityCalendar:(CDCalendarView *)calendar didSelectDate:(NSDate *)dayDate;

/**
 *  日历中的某个日期被取消选中的回调事件
 *
 *  @param calendar 日历控件
 *  @param dayDate  被取消选中的日期
 */
- (void)mangocityCalendar:(CDCalendarView *)calendar didDeselectDate:(NSDate *)dayDate;


@end

#pragma mark - 基于FSCalendar框架而封装的芒果网专用日历控件 
@interface CDCalendarView : UIView

@property (nonatomic,strong,readonly) FSCalendar *calendar;
@property (nonatomic,weak) id <CDMangocityCalendarViewDelegate> delegate;

@property (nonatomic,assign) BOOL allowsMultipleSelection;  //  是否允许多选
@property (nonatomic, readonly) CDDateHelper *dateHelper;  //  日期帮助的工具类
@property (nonatomic,readonly) NSDate *todayDate;  //  今天的日期
@property (nonatomic,strong) NSDate *minDate;  //  可以显示的最小日期
@property (nonatomic,strong) NSDate *maxDate;  //  可以显示的最大日期


#pragma mark Public Method
- (void)showCalendarWithTargetView:(UIView *)targetView; // 在制定的view中显示日历
- (void)hiddenCalendar;  // 隐藏日历
- (void)setSelectedDates:(NSArray *)dateArray;  //  设置指定的日期系列被选中
- (void)setDeselectedDates:(NSArray *)dateArray; //  设置指定的日期系列被取消选中

@end









