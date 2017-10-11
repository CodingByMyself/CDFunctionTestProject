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
    
    
    self.tableViewBBS.estimatedRowHeight = 100.0;
    self.tableViewBBS.rowHeight = 80.0;
    
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    UITextView *textView = [[UITextView alloc] init];
//    textView.text = @"我是测试文本，你长按复制一下看有没有选项,textView我是测试文本，你长按复制一下看有没有选项我是测试文本，你长按复制一下看有没有选项";
//    textView.font = [UIFont systemFontOfSize:15.0];
//    textView.textColor = [UIColor blackColor];
//    textView.editable = NO;
//    textView.backgroundColor = [UIColor yellowColor];
//    
//    [self.view addSubview:textView];
//    
//    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(100.0);
//        make.left.equalTo(self.view);
//        make.right.equalTo(self.view);
//        make.height.equalTo(@(textView.contentSize.height));
//    }];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [textView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@(textView.contentSize.height));
//        }];
//    });
    
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
//    CDTestAutoHeightCell *autoHeightCell = [[CDTestAutoHeightCell alloc] initWithRestorationIdentifier:@"CDTestAutoHeightCell" onTableView:tableView selectionStyle:UITableViewCellSelectionStyleNone];
    
    CDTestAutoHeightCell *autoCell = [tableView dequeueReusableCellWithIdentifier:@"CDTestAutoHeightCell"];
    
    [self configureCell:autoCell atIndexPath:indexPath];
    
    return autoCell;
    
//    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%zi  -  %zi",[indexPath section] , [indexPath row]);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //普通的计算高度，不进行缓存
//    return [tableView fd_heightForCellWithIdentifier:@"CDTestAutoHeightCell" configuration:^(id cell) {
//        [self configureCell:cell atIndexPath:indexPath];
//    }];
    
    //根据数据源里你的自定key进行缓存高度
    NSString *key;
    if (indexPath.row == 0) {
        key = [@"gsfahrhatehrsyjyjs接到合等你接到合法金发放回家挨发货黄金佛山掉防洪费法金发放回家挨发货黄金佛山掉防接到合等你接到合法金发放回家挨发货黄金佛山掉防洪费法金发放回家挨发货黄金佛山掉防洪ddsdgesfgqegwgegwewwedxbdfbsrwegqwfwegrdhgdfghwrgewrthweargegtttt" stringByAppendingString:@"等你接到合法金发放回http://blog.csdn.net/saw471/article/details/52704154掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家等你接到合法金发放回家挨发货黄金佛山掉防洪费等你vbfbregqwfqwgwehrejytkutylrturetgqewfaefgsrhtruhtrjtjerthwegq3tr24t34yhe5rhyertjhtrjrytryrt5eyhw4efqwefqwfcasdvdxbvfgntrjtykuytltyukrjuertgeqgaseghdjrytkty,fgmnfgndfrhbsrwhyrhesdrjndtjyfrjhtegqwerwqrf山掉防洪费over"];
        
    } else {
        key = [@"等你接到合等你接到合法金发放回家挨发货黄金佛山掉防洪费法金发放回家挨发货黄金佛山掉防洪费tttt" stringByAppendingString:@"等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛佛山掉防洪费over"];
    }
    
    return [tableView fd_heightForCellWithIdentifier:@"CDTestAutoHeightCell" cacheByKey:[key nim_MD5String] configuration:^(id cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
    
//
//    //根据indexPath进行缓存高度
//    return [tableView fd_heightForCellWithIdentifier:@"CDTestAutoHeightCell" cacheByIndexPath:indexPath configuration:^(id cell) {
//        [self configureCell:cell atIndexPath:indexPath];
//    }];
//    
//    return 45.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark 
- (void)configureCell:(CDTestAutoHeightCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    //使用Masonry进行布局的话，这里要设置为NO
    cell.fd_enforceFrameLayout = NO;
    
    if (indexPath.row == 0) {
        [cell setTitle:@"gsfahrhatehrsyjyjs接到合等你接到合法金发放回家挨发货黄金佛山掉防洪费法金发放回家挨发货黄金佛山掉防接到合等你接到合法金发放回家挨发货黄金佛山掉防洪费法金发放回家挨发货黄金佛山掉防洪ddsdgesfgqegwgegwewwedxbdfbsrwegqwfwegrdhgdfghwrgewrthweargegtttt" content:@"等你接到合法金发放回http://blog.csdn.net/saw471/article/details/52704154 掉防洪费等你接到合法金发放回家挨发货黄金佛山掉http://blog.csdn.net/saw471/article/details/52704154防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家等你接到合法金发放回家挨发货黄金佛山掉防洪费等你vbfbregqwfqwgwehrejytkutylrturetgqewfaefgsrhtruhtrjtjerthwegq3tr24t34yhe5rhyertjhtrjrytryrt5eyhw4efqwefqwfcasdvdxbvfgntrjtykuytltyukrjuertgeqgaseghdjrytkty,fgmnfgndfrhbsrwhyrhesdrjndtjyfrjhtegqwerwqrf山掉防洪费over"];
    } else {
        [cell setTitle:@"等你接到合等你接到合法金发放回家挨发货黄金佛山掉防洪费法金发放回家挨发货黄金佛山掉防洪费tttt" content:@"等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛山掉防洪费等你接到合法金发放回家挨发货黄金佛佛山掉防洪费over"];
    }
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
        
//        要在这里进行cell的注册
        [_tableViewBBS registerClass:[CDTestAutoHeightCell class] forCellReuseIdentifier:@"CDTestAutoHeightCell"];
        
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
