//
//  CDCalendarView.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/8/4.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDCalendarView.h"

@interface CDCalendarView() <FSCalendarDataSource, FSCalendarDelegate,UIGestureRecognizerDelegate>
{
    UITapGestureRecognizer *_tap;
    UIView *_targetView;
}

@end

CGFloat const CDCalendarViewHeight = 300.0;

@implementation CDCalendarView
@synthesize todayDate = _todayDate;
#pragma mark - init method
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenCalendar)];
    _tap.numberOfTapsRequired = 1;
    _tap.delegate = self;
    [self addGestureRecognizer:_tap];
    _dateHelper = [CDDateHelper new];
    
    //  初始化万年日历
    _calendar = [[FSCalendar alloc] init];
    _calendar.dataSource = self;
    _calendar.delegate = self;
    _calendar.scrollDirection = FSCalendarScrollDirectionVertical;
    _calendar.backgroundColor = [UIColor whiteColor];
    [self addSubview:_calendar];
    [_calendar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(@(CDCalendarViewHeight));
        make.bottom.equalTo(self).offset(CDCalendarViewHeight);
    }];
    [_calendar setLocale:[NSLocale localeWithLocaleIdentifier:@"zh-CN"]];  //  中文显示
    [_calendar setToday:[NSDate date]]; //  设置今天的日期
    _todayDate = _calendar.today;
    _calendar.clipsToBounds = NO;
    _calendar.layer.shadowColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0].CGColor;
    _calendar.layer.shadowOffset = CGSizeMake(0.0,-2.0);
    _calendar.layer.shadowOpacity = 1.0;
    _calendar.layer.shadowRadius = 2.0;
    
    /**** appearance ****/
    _calendar.appearance.adjustsFontSizeToFitContentSize = NO;
    //  显示年月的header
    _calendar.headerHeight = 30.0;
    _calendar.appearance.headerTitleColor = [UIColor blackColor];
    _calendar.appearance.headerTitleFont = [UIFont boldSystemFontOfSize:18.0];
    //  显示星期
    _calendar.appearance.weekdayTextColor = [UIColor darkTextColor];
    _calendar.appearance.weekdayFont = DefineFontLaoSangamMN(16.0);
    //  title文本
    _calendar.appearance.titleVerticalOffset = -1.0;
    _calendar.appearance.titleDefaultColor = [UIColor darkTextColor];
    _calendar.appearance.titleFont = DefineFontHelveticaNeue(18.0);
    //   描述文本
    _calendar.appearance.subtitleFont = DefineFontHelveticaNeue(9.0);
    _calendar.appearance.subtitleVerticalOffset = 0;
    _calendar.appearance.subtitleDefaultColor = [UIColor orangeColor];
    _calendar.appearance.subtitleSelectionColor = [UIColor whiteColor];
    //  被选中后的背景填充色
    _calendar.appearance.selectionColor = [UIColor orangeColor];
    [_calendar setShowsPlaceholders:YES];
    [_calendar reloadData];
}

- (NSDate *)todayDate
{
    return _calendar.today;
}

- (void)setAllowsMultipleSelection:(BOOL)allowsMultipleSelection
{
    _allowsMultipleSelection = allowsMultipleSelection;
    _calendar.allowsMultipleSelection = _allowsMultipleSelection;
}

#pragma mark - <FSCalendarDelegate>

//  该日期是否可选择
- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date
{
    if ([_delegate respondsToSelector:@selector(mangocityCalendar:shouldSelectDate:)]) {
        return [_delegate mangocityCalendar:self shouldSelectDate:date];
    } else {
        return YES;
    }
}

//  已经选中了某个日期
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date
{
    if ([_delegate respondsToSelector:@selector(mangocityCalendar:didSelectDate:)]) {
        [_delegate mangocityCalendar:self didSelectDate:date];
    }
}

//  已经取消某个日期的选中状态
- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date
{
    if ([_delegate respondsToSelector:@selector(mangocityCalendar:didDeselectDate:)]) {
        [_delegate mangocityCalendar:self didDeselectDate:date];
    }
}

#pragma mark  <FSCalendarDataSource>
- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
{
    return [self.minDate isKindOfClass:[NSDate class]] ? _minDate : [NSDate distantPast];
}


- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
{
    return [self.maxDate isKindOfClass:[NSDate class]] ? _maxDate : [NSDate distantFuture];
}

- (NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date
{
    if ([_delegate respondsToSelector:@selector(mangocityCalendarView:subTitleStringOnDay:)]) {
        return [_delegate mangocityCalendarView:self subTitleStringOnDay:date];
    } else {
        return nil;
    }
}

#pragma mark - UIGestureRecognizer Delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return (touch.view == self ?  YES : NO);
}


#pragma mark -  - Public Method - -
- (void)showCalendarWithTargetView:(UIView *)targetView
{
    [self removeFromSuperview];
    self.frame = targetView.bounds;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.15];
    
    [_calendar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(CDCalendarViewHeight);
    }];
    [_calendar reloadData];
    
    //  添加到目标view中显示
    _targetView = targetView;
    [_targetView addSubview:self];
    self.alpha = 0;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_targetView);
        make.left.equalTo(_targetView);
        make.right.equalTo(_targetView);
        make.bottom.equalTo(_targetView);
    }];
    [_targetView layoutIfNeeded];
    
    //  动画方式显示日历
    [_calendar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(0);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
        [_targetView layoutIfNeeded];
    }];
}

- (void)hiddenCalendar
{
    self.backgroundColor = [UIColor clearColor];
    [_calendar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(CDCalendarViewHeight);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)setSelectedDates:(NSArray *)dateArray
{
    for (NSDate *date in dateArray) {
        [_calendar selectDate:date];
    }
    [_calendar reloadData];
}

- (void)setDeselectedDates:(NSArray *)dateArray
{
    for (NSDate *date in dateArray) {
        [_calendar deselectDate:date];
    }
    [_calendar reloadData];
}

@end
