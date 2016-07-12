//
//  CDTestCustomGroupController.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/7.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDTestCustomGroupController.h"
#import "CExpandHeader.h"

#import "CDTestTableCell.h"
#import "CDBaseTableViewCell+CDGroupCellCategory.h"



CGFloat const HeaderViewTopHeight = 200.0;
CGFloat const HeaderViewOtherHeight = 10.0;

CGFloat const FooterViewBottomHeight = 50.0;
CGFloat const FooterViewOtherHeight = 4.0;

@interface CDTestCustomGroupController () <UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableViewGroup;
    CExpandHeader *_header;
    UIView *_customView;  //  可以显示一个自定的view作为扩展的header显示内容
}
@end

@implementation CDTestCustomGroupController

#pragma mark - view
- (void)viewWillLayoutSubviews
{
    _tableViewGroup.frame = self.view.bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"自定义分组显示";
    
    /**
     * 初始化 tableView
     */
    _tableViewGroup = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableViewGroup.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableViewGroup.delegate = self;
    _tableViewGroup.dataSource = self;
    [self.view addSubview:_tableViewGroup];
    
    [self initTableViewExpandHeader];
}

- (void)initTableViewExpandHeader
{
    _customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, HeaderViewTopHeight)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:_customView.bounds];
    [imageView setImage:[UIImage imageNamed:@"header_view_image_bg.jpg"]];
    //关键步骤 设置可变化背景view属性
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight| UIViewAutoresizingFlexibleWidth;
    imageView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_customView addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:_customView.bounds];
    [label setText:@"这是一个自定义头部view"];
    label.textAlignment = NSTextAlignmentCenter;
    [label setTextColor:[UIColor blackColor]];
    [_customView addSubview:label];
    
    _header = [CExpandHeader expandWithScrollView:_tableViewGroup expandView:_customView];
}

#pragma mark  Retrun  Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CDTestTableCell *cell = [[CDTestTableCell alloc] initWithRestorationIdentifier:@"CDTestTableCell" onTableView:tableView];
    
    cell.baseLabelTitle.text = [NSString stringWithFormat:@"row%zi in section%zi",[indexPath row],[indexPath section]];
    
    [cell updateLayoutAndLayerWithTableView:tableView indexPath:indexPath];  //  分类的扩展方法
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark  Retrun  CGFloat
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HeaderViewOtherHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == [tableView numberOfSections] - 1) {
        return FooterViewBottomHeight;
    } else {
        return FooterViewOtherHeight;
    }
}

#pragma mark Retrun NSInteger
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return 1;
        }
            break;
        case 1:
        {
            return 3;
        }
            break;
        case 2:
        {
            return 4;
        }
            break;
        case 3:
        {
            return 5;
        }
            break;
        default:
            return 0;
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}


@end
