//
//  CDTestBBSViewController.m
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/5/5.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import "CDTestBBSViewController.h"
#import "CDAddBBSViewController.h"

#import "CDRefresh.h"
#import "CTPRefreshHeader.h"



#import "CDTestAutoHeightCell.h"
#import "UITableView+FDTemplateLayoutCell.h"



@interface CDTestBBSViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableViewBBS;
@property (nonatomic,strong) NSArray *datas;
@end

@implementation CDTestBBSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.tableViewBBS.delegate = self;
    self.tableViewBBS.dataSource = self;
    
    // 左侧进入个人中心按钮
    UIButton *rightButton = [[UIButton alloc] init];
    rightButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    UIImage *imageMyself = [UIImage imageNamed:@"follow_add_icon"];
    [rightButton setImage:imageMyself forState:UIControlStateNormal];
    rightButton.frame =  CGRectMake(0, 0, 20.0, 20.0);
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
    [rightButton addTarget:self action:@selector(navigationAdd:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];// 监听按钮点击
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:rightButton]];

    
}

- (void)navigationAdd:(UIButton *)button
{
    CDAddBBSViewController *addVC = [[CDAddBBSViewController alloc] init];
    [self.navigationController pushViewController:addVC animated:YES];
}


#pragma mark - TableView Delegate Method
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CDBaseTableViewCell *cell = [[CDBaseTableViewCell alloc] initWithRestorationIdentifier:@"CDBaseTableViewCell" onTableView:tableView selectionStyle:UITableViewCellSelectionStyleNone];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"准备录音";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"准备录视频";
    } else {
        cell.textLabel.text = @"";
    }
    
    cell.textLabel.textColor = [UIColor darkGrayColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%zi  -  %zi",[indexPath section] , [indexPath row]);
    if (indexPath.row == 0) {
        // 录音
        
    } else if (indexPath.row == 1) {
        // 录视频
        
    } else {
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

#pragma mark - Getter Method
- (UITableView *)tableViewBBS
{
    if (_tableViewBBS == nil) {
        _tableViewBBS = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        
        _tableViewBBS.sectionFooterHeight = 0;
        _tableViewBBS.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 0.1f)];
        _tableViewBBS.tableFooterView = [UIView new];
        
        _tableViewBBS.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_tableViewBBS setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        
        [self.view addSubview:_tableViewBBS];
        [_tableViewBBS mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(64.0);
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }];
    }
    return _tableViewBBS;
}

@end
