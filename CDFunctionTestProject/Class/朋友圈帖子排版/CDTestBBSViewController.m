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
    
    
    self.tableViewBBS.mj_header =  [CTPRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadHeaderData)];
    
    CDRefreshAutoNormalFooter *footer = [CDRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadFooterData)];
    [footer setTitle:@"上拉加载更多" forState:CDRefreshStateIdle];
    [footer setTitle:@"正在加载数据" forState:CDRefreshStateRefreshing];
    [footer setTitle:@"数据加载完毕" forState:CDRefreshStateNoMoreData];
    
    self.tableViewBBS.mj_footer = footer;
    
    
    // 如果确定数据已经加载完毕，则显示加载完成的提示文字
    [footer setState:CDRefreshStateNoMoreData];
    
}

- (void)navigationAdd:(UIButton *)button
{
    CDAddBBSViewController *addVC = [[CDAddBBSViewController alloc] init];
    [self.navigationController pushViewController:addVC animated:YES];
}


#pragma mark 
- (void)loadHeaderData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableViewBBS.mj_header endRefreshing];
    });
    
}

- (void)loadFooterData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableViewBBS.mj_footer endRefreshing];
    });
}

#pragma mark - TableView Delegate Method
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%zi  -  %zi",[indexPath section] , [indexPath row]);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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
//        [_tableViewBBS setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
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
