//
//  CDMainViewController.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/6/25.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDMainViewController.h"
#import "CDCollectionViewController.h"

@interface CDMainViewController () <UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_functionList;
    
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
    
    _functionList = @[@"collectionView 的扩展方法"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    
    cell.textLabel.text = _functionList[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CDCollectionViewController *collection = [[CDCollectionViewController alloc] init];
    [self.navigationController pushViewController:collection animated:YES];
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
