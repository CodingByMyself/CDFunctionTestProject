//
//  CDTestCalendarViewController.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/8/4.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDTestCalendarViewController.h"
#import "CDCalendarView.h"
#import "CDTipsView.h"

@interface CDTestCalendarViewController () <UITableViewDelegate,UITableViewDataSource,CDMangocityCalendarViewDelegate>
{
    UITableView *_tableFunction;
    NSArray *_functionList;
    
    NSDate *_currentSelectedDate;
}
@property (nonatomic,strong) CDCalendarView *cdCalendarView;
@end

@implementation CDTestCalendarViewController

#pragma mark - Getter Method
- (CDCalendarView *)cdCalendarView
{
    if (_cdCalendarView == nil) {
        _cdCalendarView = [[CDCalendarView alloc] init];
        _cdCalendarView.delegate = self;
        //  如果不设置minDate和maxDate,则默认没有区间限制
        _cdCalendarView.minDate = [_cdCalendarView.dateHelper addToDate:_cdCalendarView.todayDate months:0];
        _cdCalendarView.maxDate = [_cdCalendarView.dateHelper addToDate:_cdCalendarView.todayDate months:2];
    }
    return _cdCalendarView;
}

#pragma mark - view
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"日历选择功能";
    
    _functionList = @[@"点击显示日历选择器(多选模式)",@"点击显示日历选择器(单选模式)"];
    _tableFunction = [[UITableView alloc] init];
    _tableFunction.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableFunction.delegate = self;
    _tableFunction.dataSource = self;
    [self.view addSubview:_tableFunction];
    [_tableFunction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    //  吐司功能初始化
    [[CDTipsView sharedTips] setTargetView:[[UIApplication sharedApplication] keyWindow]];
    [[CDTipsView sharedTips] setTipBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
    [[CDTipsView sharedTips] setTipsPostion:CDTipsViewShowPostionCenter];
}


#pragma mark - CDMangocityCalendarView Delegate
- (NSString *)mangocityCalendarView:(CDCalendarView *)calendar subTitleStringOnDay:(NSDate *)dayDate
{
    return [_cdCalendarView.dateHelper date:dayDate isEqualOrAfter:_cdCalendarView.minDate andEqualOrBefore:_cdCalendarView.maxDate] ? @"¥1024" : nil;
}

- (BOOL)mangocityCalendar:(CDCalendarView *)calendar shouldSelectDate:(NSDate *)dayDate
{
    return  [_cdCalendarView.dateHelper date:dayDate isEqualOrAfter:_cdCalendarView.minDate andEqualOrBefore:_cdCalendarView.maxDate] ? YES : NO;
}

- (void)mangocityCalendar:(CDCalendarView *)calendar didSelectDate:(NSDate *)dayDate
{
    if (_currentSelectedDate == dayDate) {
        _currentSelectedDate = nil;
        [_cdCalendarView.calendar deselectDate:dayDate];
        [[CDTipsView sharedTips] setTipString:[NSString stringWithFormat:@"取消 %@ 选中",[_cdCalendarView.dateHelper date:dayDate toStringByFormat:@"yyyy/MM/dd"]]];
    } else {
        _currentSelectedDate = dayDate;
        [[CDTipsView sharedTips] setTipString:[NSString stringWithFormat:@"%@ 被选中",[_cdCalendarView.dateHelper date:dayDate toStringByFormat:@"yyyy/MM/dd"]]];
    }
    
    [[CDTipsView sharedTips] show:YES];
    [[CDTipsView sharedTips] hiden:YES delayTime:0.5];
}

- (void)mangocityCalendar:(CDCalendarView *)calendar didDeselectDate:(NSDate *)dayDate
{
    [[CDTipsView sharedTips] show:YES];
    [[CDTipsView sharedTips] hiden:YES delayTime:0.5];
    [[CDTipsView sharedTips] setTipString:[NSString stringWithFormat:@"取消 %@ 选中",[_cdCalendarView.dateHelper date:dayDate toStringByFormat:@"yyyy/MM/dd"]]];
}

#pragma mark - UI Table View Data And Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellID"];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = _functionList[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([indexPath row] == 0) {
        self.cdCalendarView.allowsMultipleSelection = YES;
        [self.cdCalendarView setDeselectedDates:self.cdCalendarView.calendar.selectedDates]; //  移除之前所有选中的日期集合
        [self.cdCalendarView showCalendarWithTargetView:self.view];
    } else if ([indexPath row] == 1){
        self.cdCalendarView.allowsMultipleSelection = NO;
        [self.cdCalendarView setDeselectedDates:self.cdCalendarView.calendar.selectedDates]; //  移除之前所有选中的日期集合
        [self.cdCalendarView showCalendarWithTargetView:self.view];
    } else {
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_functionList count];
}



@end
