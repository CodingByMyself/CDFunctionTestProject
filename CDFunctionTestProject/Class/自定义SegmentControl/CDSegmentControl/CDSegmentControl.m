//
//  CDSegmentControl.m
//  KnowledgePool
//
//  Created by Cindy on 2017/2/20.
//  Copyright © 2017年 Comtop. All rights reserved.
//

#import "CDSegmentControl.h"



#pragma mark
@interface CDSegmentControl () <UICollectionViewDelegate,UICollectionViewDataSource,CDMenuItemDelegate>
@property (nonatomic,strong) UICollectionView *collectionViewMenu;
@end


@implementation CDSegmentControl

#pragma mark - Init Method
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.collectionViewMenu.delegate = self;
    self.collectionViewMenu.dataSource = self;
}

#pragma mark - UICollection View Delegate
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"CDMenuItemCellID";
    [self.collectionViewMenu registerClass:[CDMenuItem class] forCellWithReuseIdentifier:CellIdentifier];
    CDMenuItem * cell = (CDMenuItem *)[self.collectionViewMenu dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CDSegmentMenuModel *model = [self.segmentMenuList objectAtIndex:indexPath.row];
    [cell setModel:model];
    cell.delegate = self;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section = %zi , item = %zi   clicked !",[indexPath section],[indexPath row]);
    self.selectedIndex = indexPath.row;
}

#pragma mark  Item Size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CDSegmentMenuModel *model = [self.segmentMenuList objectAtIndex:indexPath.row];
    CGFloat width;
    if (model.layoutStyle == ONLY_TEXT) {
        UILabel *label = [[UILabel alloc] init];
        label.attributedText = self.titleFormatter ? self.titleFormatter(self, model.title, indexPath.row,(self.selectedIndex == indexPath.row)) : [[NSAttributedString alloc] initWithString:model.title attributes:@{NSForegroundColorAttributeName : model.selected ? [UIColor orangeColor]:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:15.0]}];
        CGSize titleSize = [label textRectForBounds:CGRectMake(0, 0, DefineScreenWidth, 100.0) limitedToNumberOfLines:1].size;
        width = titleSize.width + 20.0;
    } else if (model.layoutStyle == ONLY_IMAGE) {
        CGSize size = self.iconImageSize ? self.iconImageSize(self, model.icon, indexPath.row, (self.selectedIndex == indexPath.row)) : CGSizeMake(24.0, 24.0);
        width = size.width + 30.0;
    } else {
        // title
        UILabel *label = [[UILabel alloc] init];
        label.attributedText = self.titleFormatter ? self.titleFormatter(self, model.title, indexPath.row,(self.selectedIndex == indexPath.row)) : [[NSAttributedString alloc] initWithString:model.title attributes:@{NSForegroundColorAttributeName : model.selected ? [UIColor orangeColor]:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:15.0]}];
        CGSize titleSize = [label textRectForBounds:CGRectMake(0, 0, DefineScreenWidth, 100.0) limitedToNumberOfLines:1].size;
        CGFloat width1 = titleSize.width + 20.0;
        // icon
        CGSize size = self.iconImageSize ? self.iconImageSize(self, model.icon, indexPath.row, (self.selectedIndex == indexPath.row)) : CGSizeMake(24.0, 24.0);
        CGFloat width2 = size.width + 30.0;
        // 去最大值
        width = MAX(width1,width2);
    }
    
    
    CGSize size = CGSizeMake(width, self.collectionViewMenu.bounds.size.height);
    return size;
}

#pragma mark  Item Number  And  Section Number
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.segmentMenuList.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
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

#pragma mark - CDMenuItem Delegate method
- (CGSize)itemCell:(CDMenuItem *)item iconSizeAtSelected:(BOOL)selected
{
    NSIndexPath *indexpath = [self.collectionViewMenu indexPathForCell:item];
    CDSegmentMenuModel *model = [self.segmentMenuList objectAtIndex:indexpath.row];
    
    return  self.iconImageSize ? self.iconImageSize(self, model.icon, indexpath.row, selected) : CGSizeZero;
}

- (NSAttributedString *)itemCell:(CDMenuItem *)item titleFormatterAtSelected:(BOOL)selected
{
    NSIndexPath *indexpath = [self.collectionViewMenu indexPathForCell:item];
    CDSegmentMenuModel *model = [self.segmentMenuList objectAtIndex:indexpath.row];
    
    return self.titleFormatter ? self.titleFormatter(self, model.title, indexpath.row, selected) : nil;
}

#pragma mark - Setter method
- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    CDSegmentMenuModel *modelLast = [self.segmentMenuList objectAtIndex:_selectedIndex];
    modelLast.selected = NO;
    CDSegmentMenuModel *modelSelected = [self.segmentMenuList objectAtIndex:selectedIndex];
    modelSelected.selected = YES;
    
    // 更新索引位置及视图ui
    _selectedIndex = selectedIndex;
    [self sendActionsForControlEvents:UIControlEventEditingChanged];
    
    // 计算位置偏差，是否需要自动位移
    UICollectionViewCell *itemCell = [self.collectionViewMenu cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0]];
    CGPoint currentOffset = self.collectionViewMenu.contentOffset;
    if (((itemCell.frame.origin.x - currentOffset.x) >= self.collectionViewMenu.bounds.size.width/3.0*1.6) || ((itemCell.frame.origin.x - currentOffset.x) <= self.collectionViewMenu.bounds.size.width/3.0*1.4)) {
        // 计算x的理论
        CGFloat x = itemCell.frame.origin.x + itemCell.frame.size.width/2.0 - self.collectionViewMenu.bounds.size.width/2.0;
        
        // x的实际值
        if (x+self.collectionViewMenu.bounds.size.width > self.collectionViewMenu.contentSize.width) {
            x = self.collectionViewMenu.contentSize.width - self.collectionViewMenu.bounds.size.width;
        } else if (x < 0) {
            x = 0;
        }
        
        // 添加动画
        [UIView animateWithDuration:0.18 animations:^{
            [self.collectionViewMenu setContentOffset:CGPointMake(x, currentOffset.y)];
        }];
    }
    
    // 刷新ui
    [self.collectionViewMenu reloadData];
}

- (void)setSegmentMenuList:(NSArray<CDSegmentMenuModel *> *)segmentMenuList
{
    _segmentMenuList = segmentMenuList;
    [self.collectionViewMenu reloadData];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    [self.collectionViewMenu setBackgroundColor:backgroundColor];
}

#pragma mark - Getter Method
- (UICollectionView *)collectionViewMenu
{
    if (_collectionViewMenu == nil) {
        //  初始化装载控件
        UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _collectionViewMenu.collectionViewLayout = flowLayout;
        _collectionViewMenu = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionViewMenu.backgroundColor = [UIColor whiteColor];
        _collectionViewMenu.alwaysBounceVertical = NO; // 不允许垂直方向
        _collectionViewMenu.showsVerticalScrollIndicator = NO;
        _collectionViewMenu.showsHorizontalScrollIndicator = NO;
        [self addSubview:_collectionViewMenu];
        [_collectionViewMenu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self);
        }];
        
    }
    return _collectionViewMenu;
}

@end
