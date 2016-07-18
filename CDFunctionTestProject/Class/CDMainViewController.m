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
    
    
    _functionList = @[@"CollectionView 的扩展方法",@"TableView 自定义分组显示",@"CollectionView 菜单功能",@"SDAutoLayout 功能验证",@"View 相关的动画功能",@"iOS 字体大全"];
    _classList = @[
                   [[CDCollectionViewController alloc] init] ,
                   [[CDTestCustomGroupController alloc] init] ,
                   [[CDTestMenuViewController alloc] init] ,
                   [[CDTestAutoLayoutViewController alloc] init],
                   [[CDTestAnimationViewController alloc] init],
                   [[CDTestFontViewController alloc] init]
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
    //    cell.textLabel.text = [NSString stringWithFormat:@" %zi、 %@", ([indexPath row] + 1), _functionList[indexPath.row]];
    
    NSString *text = [NSString stringWithFormat:@" %zi、 %@", ([indexPath row] + 1), _functionList[indexPath.row]];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
    if ([indexPath row] == 0) {
        [str addAttribute:NSFontAttributeName value:DefineFontHelveticaNeue(FontBaseSize) range:[text rangeOfString:text]];
    } else if ([indexPath row]%2) {
        [str addAttribute:NSFontAttributeName value:DefineFontLaoSangamMN(FontBaseSize) range:[text rangeOfString:text]];
    } else {
        [str addAttribute:NSFontAttributeName value:DefineFontSystem(FontBaseSize) range:[text rangeOfString:text]];
    }
    cell.textLabel.attributedText = str;
    
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

@end
