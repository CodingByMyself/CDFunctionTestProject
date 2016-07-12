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
    
    
    _functionList = @[@"CollectionView的扩展方法",@"TableView自定义分组显示",@"CollectionView菜单功能",@"SDAutoLayout功能验证",@"View相关的动画功能"];
    _classList = @[
                   [[CDCollectionViewController alloc] init] ,
                   [[CDTestCustomGroupController alloc] init] ,
                   [[CDTestMenuViewController alloc] init] ,
                   [[CDTestAutoLayoutViewController alloc] init],
                   [[CDTestAnimationViewController alloc] init]
                   ];
    
    
    _table = [[UITableView alloc] initWithFrame:self.view.bounds];
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}

#pragma mark - UITableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellID"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@" %zi、 %@", ([indexPath row] + 1), _functionList[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([_classList count] > [indexPath row]) {
        [self.navigationController pushViewController:_classList[indexPath.row] animated:YES];
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


#pragma mark
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
