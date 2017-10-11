//
//  CDAddBBSViewController.m
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/5/5.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import "CDAddBBSViewController.h"
#import "CDAddInputTextCell.h"
#import "CDPictureSelectedCell.h"

@interface CDAddBBSViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableViewAdd;
@end

@implementation CDAddBBSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableViewAdd.delegate = self;
    self.tableViewAdd.dataSource = self;
    
}

#pragma mark - TableView Delegate Method
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            CDAddInputTextCell *textCell = [[CDAddInputTextCell alloc] initWithRestorationIdentifier:@"CDAddInputTextCellID" onTableView:tableView selectionStyle:UITableViewCellSelectionStyleNone];
            
            return textCell;
        }
            break;
        case 1:
        {
            CDPictureSelectedCell *pictrueCell = [[CDPictureSelectedCell alloc] initWithRestorationIdentifier:@"CDPictureSelectedCellID" onTableView:tableView selectionStyle:UITableViewCellSelectionStyleNone];
            
//            pictrueCell.backgroundColor = [UIColor yellowColor];
            
            return pictrueCell;
        }
            break;
        case 2:
        {
            
        }
            break;
        default:
            break;
    }
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%zi  -  %zi",[indexPath section] , [indexPath row]);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        return 0.01;
    } else {
        return 15.0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 200.0;
    } else if (indexPath.section == 1) {
        CGFloat fitHeight = [CDPictureSelectedCell heightOfCell];
        return fitHeight;
    } else {
        return 60.0;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 1;
    } else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - Getter Method
- (UITableView *)tableViewAdd
{
    if (_tableViewAdd == nil) {
        _tableViewAdd = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        
        _tableViewAdd.sectionFooterHeight = 0;
        _tableViewAdd.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 0.1f)];
        _tableViewAdd.tableFooterView = [UIView new];
        
        _tableViewAdd.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //        [_tableViewBBS setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        [self.view addSubview:_tableViewAdd];
        [_tableViewAdd mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(64.0);
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }];
    }
    return _tableViewAdd;
}


@end
