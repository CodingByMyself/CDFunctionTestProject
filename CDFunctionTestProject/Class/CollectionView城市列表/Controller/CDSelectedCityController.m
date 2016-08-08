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


CGFloat const ItemDefaultHeight = 36.0;
CGFloat const ToolBarViewWidth = 25.0;
@interface CDSelectedCityController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>
{
    UICollectionView *_collectionViewTest;
    
    UITableView *_toolbarTable;
    NSArray *_toolbarList;
    NSDictionary *_citysGroupDictionary;
}
@property (nonatomic,strong) NSArray *allCityList;
@property (nonatomic,strong) NSArray *itemShowCityList;
@end

@implementation CDSelectedCityController

- (instancetype)initWithCityModelArray:(NSArray *)cityList andItemSupperKey:(NSArray *)flagArray
{
    self = [super init];
    if (self) {
        self.allCityList = cityList;
        self.itemShowCityList = flagArray;
    }
    return self;
}

#pragma mark - data handle
- (void)showAllData
{
    NSMutableArray *tempSectionArray = [NSMutableArray new];
    NSMutableDictionary *tempCityGroupDictionary = [NSMutableDictionary new];
    for (CDCityModel *city in self.allCityList) {
        //  section array
        if ([tempSectionArray containsObject:city.supperKey] == NO && [self.itemShowCityList containsObject:city.supperKey] == NO) {
            [tempSectionArray addObject:city.supperKey];
        }
        
        //  item array
        NSMutableArray *group;
        if ([[tempCityGroupDictionary objectForKey:city.supperKey] isKindOfClass:[NSArray class]]) {
            group = [NSMutableArray arrayWithArray:[tempCityGroupDictionary objectForKey:city.supperKey]];
        } else {
            group = [NSMutableArray new];
        }
        [group addObject:city];
        [tempCityGroupDictionary setObject:group forKey:city.supperKey];
    }
    
    //  更新数据源
    NSMutableArray *temp = [NSMutableArray arrayWithArray:self.itemShowCityList];
    [temp addObjectsFromArray:[tempSectionArray sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"" ascending:YES]]]];
    _toolbarList = [NSArray arrayWithArray:temp];
    _citysGroupDictionary = [NSDictionary dictionaryWithDictionary:tempCityGroupDictionary];
    [_collectionViewTest reloadData];
    [_toolbarTable reloadData];
}

#pragma mark - view
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    self.title = @"选择城市";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initView];
    
    [self showAllData];
    
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
    _toolbarTable = [[UITableView alloc] init];
    _toolbarTable.delegate = self;
    _toolbarTable.dataSource = self;
    _toolbarTable.scrollEnabled = NO;
    [_toolbarTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _toolbarTable.backgroundColor = DefineColorRGB(0, 0, 0, 0.05);
    _toolbarTable.layer.cornerRadius = 5.0;
    [self.view addSubview:_toolbarTable];    [_toolbarTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(70.0);
        make.bottom.equalTo(self.view).offset(-5.0);
        make.right.equalTo(self.view).offset(-1.0);
        make.width.equalTo(@(ToolBarViewWidth));
    }];
}

#pragma mark - UICollection View Delegate
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"CDCityCollectionCell";
    [_collectionViewTest registerClass:[CDCityCollectionCell class] forCellWithReuseIdentifier:CellIdentifier];
    CDCityCollectionCell * cell = (CDCityCollectionCell *)[_collectionViewTest dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CDCityModel *cityModel = [[_citysGroupDictionary objectForKey:_toolbarList[indexPath.section]] objectAtIndex:indexPath.row];
    NSString *cityName = cityModel.name;
    if ([self.itemShowCityList containsObject:_toolbarList[indexPath.section]]) {
        [cell initWithCityName:cityName atIndexPath:indexPath showBorder:YES];
    } else {
        [cell initWithCityName:cityName atIndexPath:indexPath showBorder:NO];
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section = %zi , item = %zi   clicked !",[indexPath section],[indexPath row]);
    CDCityModel *selectedCityModel = [[_citysGroupDictionary objectForKey:_toolbarList[indexPath.section]] objectAtIndex:indexPath.row];
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(didSelectedCity:onController:)]) {
            [_delegate didSelectedCity:selectedCityModel onController:self];
        } else {
            MTDetailLog(@"代理对象并没有实现相关的代理协议！");
        }
    } else {
        MTDetailLog(@"没有设置代理！");
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark  Header  View   or   Footer   View
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:UICollectionElementKindSectionHeaderID];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:UICollectionElementKindSectionFooterID];
    
    CDCollectionViewFlowLayout *collectionViewFlowLayout = (CDCollectionViewFlowLayout *)collectionViewLayout;
    // 设置header或footer的size, 如不设置默认是CGSizeZero
    CGSize size = CGSizeMake(DefineScreenWidth, 20.0);
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
            label = [[UILabel alloc] initWithFrame:CGRectInset(reusableView.bounds, 5.0, 0.0)];
            label.tag = 100;
            label.backgroundColor = [UIColor groupTableViewBackgroundColor];
            label.textColor = [UIColor darkGrayColor];
            label.font = [UIFont systemFontOfSize:13.0];
            [reusableView addSubview:label];
        }
        label.text = [NSString stringWithFormat:@"  %@ ",_toolbarList[[indexPath section]]];
        
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
    
    if ([self.itemShowCityList containsObject:_toolbarList[indexPath.section]]) {
        size = CGSizeMake((DefineScreenWidth- (ToolBarViewWidth + 2.0) - 2.0)/3.0, ItemDefaultHeight + 12.0);
    } else {
        size = CGSizeMake(DefineScreenWidth - (ToolBarViewWidth + 2.0), ItemDefaultHeight);
    }
    
    return size;
}

#pragma mark  Item Number  And  Section Number
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[_citysGroupDictionary objectForKey:_toolbarList[section]] count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [_toolbarList count];
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
        label.numberOfLines = 0;
        label.font = DefineFontLaoSangamMN(12.0);
        label.textColor = [UIColor orangeColor];
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
    
    if ([self.itemShowCityList containsObject:_toolbarList[indexPath.row]]) {
        label.font = [UIFont boldSystemFontOfSize:9.0];
    } else {
        label.font = DefineFontLaoSangamMN(14.0);
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [_collectionViewTest scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.row] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
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
