//
//  CDSelectedCityController.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/8/5.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDSelectedCityController.h"
#import "CDCollectionViewFlowLayout.h"
#import "CDCityCollectionCell.h"


CGFloat const ItemDefaultHeight = 40.0;
@interface CDSelectedCityController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>
{
    UICollectionView *_collectionViewTest;
    
    UITableView *_toolbarTable;
    NSArray *_toolbarList;
}

@end

@implementation CDSelectedCityController

#pragma mark - view
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    self.title = @"侧面导航扩展";
    
    [self initView];
    
}

- (void)initView
{
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
        make.top.equalTo(self.view).offset(66.0);
        make.bottom.equalTo(self.view).offset(-2.0);
        make.right.equalTo(self.view).offset(-2.0);
        make.width.equalTo(@(18.0));
    }];
}

#pragma mark - UICollection View Delegate
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"CDCityCollectionCell";
    [_collectionViewTest registerClass:[CDCityCollectionCell class] forCellWithReuseIdentifier:CellIdentifier];
    CDCityCollectionCell * cell = (CDCityCollectionCell *)[_collectionViewTest dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *cityName = [NSString stringWithFormat:@"%zi%zi",[indexPath section],[indexPath row]];
    [cell initWithCityName:cityName atIndexPath:indexPath];
    
//    UILabel *labelDesr = [cell viewWithTag:100];
//    if (labelDesr == nil) {
//        labelDesr = [[UILabel alloc] initWithFrame:cell.bounds];
//        labelDesr.tag = 100;
//        labelDesr.textAlignment = NSTextAlignmentCenter;
//        labelDesr.textColor = [UIColor darkGrayColor];
//        labelDesr.font = [UIFont systemFontOfSize:14.0];
//        [cell addSubview:labelDesr];
//    } else {
//        labelDesr.frame = cell.bounds;
//    }
//    labelDesr.text = [NSString stringWithFormat:@"%zi%zi",[indexPath section],[indexPath row]];
    
//    cell.backgroundColor = [UIColor yellowColor];
    
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
    CGSize size = section == 0 ? CGSizeZero : CGSizeMake(DefineScreenWidth, 20.0);
    collectionViewFlowLayout.headerReferenceSize = size;
    collectionViewFlowLayout.footerReferenceSize = CGSizeZero;  //  不需要显示footer
    
    return size;
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:UICollectionElementKindSectionHeaderID forIndexPath:indexPath];
        reusableView.backgroundColor = [UIColor groupTableViewBackgroundColor];  //  设置header的背景颜色
        
        UILabel *label = [reusableView viewWithTag:100];
        if (label == nil) {
            label = [[UILabel alloc] initWithFrame:reusableView.bounds];
            label.tag = 100;
            label.textColor = [UIColor darkGrayColor];
            label.font = [UIFont systemFontOfSize:14.0];
            [reusableView addSubview:label];
        }
        label.text = [NSString stringWithFormat:@"  我是section%zi的头信息",[indexPath section]];
        
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:UICollectionElementKindSectionFooterID forIndexPath:indexPath];
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
            size = CGSizeMake((DefineScreenWidth - 3.0)/4.0, ItemDefaultHeight);
        }
            break;
        case 1:
        {
            size = CGSizeMake((DefineScreenWidth - 3.0)/4.0, ItemDefaultHeight);
        }
            break;
        case 2:
        {
            size = CGSizeMake((DefineScreenWidth - 3.0)/4.0, ItemDefaultHeight);
        }
            break;
        default:
            size = CGSizeMake(DefineScreenWidth, ItemDefaultHeight);
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
            return 1;
        }
            break;
        case 15:
        {
            return 1;
        }
            break;
        default:
            return 10;
            break;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 10;
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


#pragma mark - UITableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellID"];
    }
    
    UILabel *label = [cell viewWithTag:100];
    if (label == nil) {
        label = [[UILabel alloc] init];
        label.tag = 100;
        label.font = [UIFont boldSystemFontOfSize:13.0];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell);
            make.bottom.equalTo(cell);
            make.left.equalTo(cell);
            make.right.equalTo(cell);
        }];
    }
    label.text = _toolbarList[indexPath.row];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
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
