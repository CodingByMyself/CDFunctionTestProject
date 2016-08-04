//
//  CDTestCalendarViewController.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/8/4.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDTestCalendarViewController.h"
#import "CDCalendarView.h"

@interface CDTestCalendarViewController () <UITableViewDelegate,UITableViewDataSource,CDMangocityCalendarViewDelegate>
{
    UITableView *_tableFunction;
    NSArray *_functionList;
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
        _cdCalendarView.allowsMultipleSelection = YES;
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
    
    _functionList = @[@"点击显示日历选择器"];
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

- (void)mangocityCalendar:(CDCalendarView *)calendar didTouchDay:(NSDate *)dayDate
{
    MTDetailLog(@"MangocityCalendar %@ 被选中",[_cdCalendarView.dateHelper date:dayDate toStringByFormat:@"yyyy/MM/dd"]);
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
        [self.cdCalendarView showCalendarWithTargetView:self.view];
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
