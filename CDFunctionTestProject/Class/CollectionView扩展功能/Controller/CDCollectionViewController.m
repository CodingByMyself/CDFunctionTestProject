//
//  CDCollectionViewController.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/6/25.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDCollectionViewController.h"
#import "CDCollectionViewFlowLayout.h"


@interface CDCollectionViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>
{
    UICollectionView *_collectionViewTest;
    
    UITableView *_toolbarTable;
    NSArray *_toolbarList;
}

@end


@implementation CDCollectionViewController


#pragma mark - view
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    self.title = @"侧面导航扩展";
    
    
    //  初始化装载控件
    CDCollectionViewFlowLayout *flowLayout= [[CDCollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.isSuspend = YES;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _collectionViewTest.collectionViewLayout = flowLayout;
    _collectionViewTest = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionViewTest.backgroundColor = [UIColor whiteColor];
    _collectionViewTest.delegate = self;
    _collectionViewTest.dataSource = self;
    [self.view addSubview:_collectionViewTest];
    [_collectionViewTest mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];

    
    //  装载分类的工具条控件
    _toolbarList = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O"];
    _toolbarTable = [[UITableView alloc] init];
    _toolbarTable.delegate = self;
    _toolbarTable.dataSource = self;
    [_toolbarTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _toolbarTable.backgroundColor = DefineColorRGB(0, 0, 0, 0.3);
    _toolbarTable.layer.cornerRadius = 2.0;
    [self.view addSubview:_toolbarTable];    [_toolbarTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(30.0);
        make.bottom.equalTo(self.view).offset(-30.0);
        make.right.equalTo(self.view).offset(-5.0);
        make.width.equalTo(@(15));
    }];
    
    [self setAutomaticallyAdjustsScrollViewInsets:YES];
    
}

#pragma mark - UICollection View Delegate
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"MyCollectionCellID";
    [_collectionViewTest registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"MyCollectionCellID"];
    UICollectionViewCell * cell = (UICollectionViewCell *)[_collectionViewTest dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UILabel *labelDesr = [cell viewWithTag:100];
    if (labelDesr == nil) {
        labelDesr = [[UILabel alloc] initWithFrame:cell.bounds];
        labelDesr.tag = 100;
        labelDesr.textAlignment = NSTextAlignmentCenter;
        labelDesr.textColor = [UIColor darkGrayColor];
        labelDesr.font = [UIFont systemFontOfSize:14.0];
        [cell addSubview:labelDesr];
    } else {
        labelDesr.frame = cell.bounds;
    }
    labelDesr.text = [NSString stringWithFormat:@"%zi%zi",[indexPath section],[indexPath row]];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section = %zi , item = %zi   clicked !",[indexPath section],[indexPath row]);
}

#pragma mark  Header  View   or   Footer   View
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:UICollectionElementKindSectionHeaderID];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:UICollectionElementKindSectionFooterID];
    
    CDCollectionViewFlowLayout *collectionViewFlowLayout = (CDCollectionViewFlowLayout *)collectionViewLayout;
    // 设置header或footer的size, 如不设置默认是CGSizeZero
    CGSize size = section == 0 ? CGSizeZero : CGSizeMake(DefineScreenWidth, 35.0);
    collectionViewFlowLayout.headerReferenceSize = size;
    collectionViewFlowLayout.footerReferenceSize = CGSizeZero;  //  不需要显示footer
    
    return size;
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        reusableView = [self retrunCollectionView:collectionView headerViewAtIndexPath:indexPath];
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        reusableView = [self retrunCollectionView:collectionView headerViewAtIndexPath:indexPath];
    } else {
        NSLog(@"other kind");
    }
    return reusableView;
}

#pragma mark  Item Size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size;
    
    switch ([indexPath section]) {
        case 0:
        {
            size = CGSizeMake(DefineScreenWidth, 120.0);
        }
            break;
        case 1:
        {
            size = CGSizeMake((DefineScreenWidth - 3.0)/4.0, 50.0);
        }
            break;
        case 2:
        {
            size = CGSizeMake(DefineScreenWidth, 100.0);
        }
            break;
        case 3:
        {
            size = CGSizeMake(DefineScreenWidth, 50.0);
        }
            break;
        case 4:
        {
            size = CGSizeMake((DefineScreenWidth - 3.0)/4.0, (DefineScreenWidth - 3.0)/4.0);
        }
            break;
        default:
            size = CGSizeZero;
            break;
    }
    
    return size;
}

#pragma mark  Item Number  And  Section Number
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return 1;
        }
            break;
        case 1:
        {
            return 8;
        }
            break;
        case 2:
        {
            return 1;
        }
            break;
        case 3:
        {
            return 6;
        }
            break;
        case 4:
        {
            return 4;
        }
            break;
        default:
            return 0;
            break;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 5;
}

#pragma mark  Item  Spacing
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

#pragma mark -  Item   Cell    Method
- (UICollectionReusableView *)retrunCollectionView:(UICollectionView *)collectionView headerViewAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:UICollectionElementKindSectionHeaderID forIndexPath:indexPath];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];  //  设置header的背景颜色
    
    UILabel *label = [headerView viewWithTag:100];
    if (label == nil) {
        label = [[UILabel alloc] initWithFrame:headerView.bounds];
        label.tag = 100;
        label.textColor = [UIColor darkGrayColor];
        label.font = [UIFont systemFontOfSize:14.0];
        [headerView addSubview:label];
    }
    label.text = [NSString stringWithFormat:@"  我是section%zi的头信息",[indexPath section]];
    
    return  headerView;
}

- (UICollectionReusableView *)retrunCollectionView:(UICollectionView *)collectionView footerViewAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:UICollectionElementKindSectionFooterID forIndexPath:indexPath];
    
    return  footerView;
}


#pragma mark - UITableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellID"];
    }
    
    cell.textLabel.text = _toolbarList[indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:12.0];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_toolbarList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return tableView.cd_height/[_toolbarList count];
}


@end
