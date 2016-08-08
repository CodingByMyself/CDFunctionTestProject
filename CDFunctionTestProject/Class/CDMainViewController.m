//
//  CDMainViewController.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/6/25.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDMainViewController.h"
#import "CDCollectionViewController.h"
#import "CDTestCustomGroupController.h"
#import "CDTestMenuViewController.h"
#import "CDTestAutoLayoutViewController.h"
#import "CDTestAnimationViewController.h"
#import "CDTestFontViewController.h"
#import "CDTestBaseModelViewController.h"

#import "CDConstSetup.h"
#import "CDTestBlurViewController.h"
#import "CDTestTabBarViewController.h"
#import "CDTestCellLongPressViewController.h"
#import "CDTestItemLongPressViewController.h"
#import "CDTestCalendarViewController.h"
#import "CDTestCitySelectedViewController.h"

@interface CDMainViewController () <UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_functionList;
    NSArray *_classList;
    UITableView *_table;
}
@end

@implementation CDMainViewController

- (void)buttonClicked:(UIButton *)button
{
    NSLog(@"%@",button.titleLabel.text);
}


#pragma mark - view
- (void)viewWillLayoutSubviews
{
    _table.frame = self.view.bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"功能列表";
    self.view.backgroundColor = [UIColor whiteColor];
    MTDetailLog(@"%@",ConstCDHTTPMethodGet);
    
    
    _functionList = @[@"CollectionView 的扩展方法",@"TableView 自定义分组显示",@"CollectionView 菜单功能",@"SDAutoLayout 功能验证",@"View 相关的动画功能",@"iOS 字体大全",@"NSObject模型扩展",@"View的模糊效果",@"Cell的长按拖动",@"Item的长按拖动",@"Calendar日历选择功能",@"CollectionView城市列表",@"TabBarController的功能"];
    
    
    _table = [[UITableView alloc] initWithFrame:self.view.bounds];
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}

- (void)viewWillAppear:(BOOL)animated
{
    _classList = @[
                   [[CDCollectionViewController alloc] init] ,
                   [[CDTestCustomGroupController alloc] init] ,
                   [[CDTestMenuViewController alloc] init] ,
                   [[CDTestAutoLayoutViewController alloc] init],
                   [[CDTestAnimationViewController alloc] init],
                   [[CDTestFontViewController alloc] init],
                   [[CDTestBaseModelViewController alloc] init],
                   [[CDTestBlurViewController alloc] init],
                   [[CDTestCellLongPressViewController alloc] init],
                   [[CDTestItemLongPressViewController alloc] init],
                   [[CDTestCalendarViewController alloc] init],
                   [[CDTestCitySelectedViewController alloc] init],
                   [[CDTestTabBarViewController alloc] init]
                   ];
    
    [_table reloadData];
}

#pragma mark - UITableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellID"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@" %zi、 %@", ([indexPath row] + 1), _functionList[indexPath.row]];
    //  设置字体显示
    if ([indexPath row] == 0) {
        cell.textLabel.font = DefineFontHelveticaNeue(FontBaseSize + 2.0);
    } else if ([indexPath row] == 1) {
        cell.textLabel.font = DefineFontSystem(FontBaseSize + 2.0);
    } else {
        cell.textLabel.font = DefineFontLaoSangamMN(FontBaseSize + 2.0);
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([_classList count] > [indexPath row]) {
        if ([_classList count] - 1 == [indexPath row]) {
            [self presentViewController:_classList[indexPath.row] animated:YES completion:nil];
        } else {
            [self.navigationController pushViewController:_classList[indexPath.row] animated:YES];
        }
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_functionList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return 55.0;
}

@end
