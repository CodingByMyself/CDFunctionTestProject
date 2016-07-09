//
//  CDMenuView.m
//  CDMenuView
//
//  Created by Cindy on 16/4/19.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDMenuView.h"
#import "CDMenuCollectionCell.h"

@interface CDMenuView() <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
}

@end


@implementation CDMenuView
@synthesize maxItemNumOnHorizontal = _maxItemNumOnHorizontal;


#pragma mark
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

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
    self.layer.shadowColor = MTColor(200.0, 200.0, 200.0, 1.0).CGColor;
    self.layer.shadowOffset = CGSizeMake(0.0,0.0);
    self.layer.shadowOpacity = 1.0f;
    self.layer.shadowRadius = 2.0f;
    //  初始化装载控件
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _collectionView.collectionViewLayout = flowLayout;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self addSubview:_collectionView];
}

- (void)layoutSubviews
{
    _collectionView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

#pragma mark - Setter Method
- (void)setShowMode:(CDMenuShowMode)showMode
{
    if (_showMode != showMode) {
        _showMode = showMode;
        [_collectionView reloadData];
    }
}

- (void)setItem:(NSArray *)item
{
    _item = item;
    [_collectionView reloadData];
}

- (void)setMaxItemNumOnHorizontal:(NSInteger)maxItemNumOnHorizontal
{
    if (maxItemNumOnHorizontal != _maxItemNumOnHorizontal) {
        _maxItemNumOnHorizontal = maxItemNumOnHorizontal;
        [_collectionView reloadData];
    }
}

- (void)setItemHeight:(CGFloat)itemHeight
{
    if (itemHeight != _itemHeight) {
        _itemHeight = itemHeight;
        [_collectionView reloadData];
    }
}

- (void)setSpacingOnHorizontal:(CGFloat)spacingOnHorizontal
{
    if (spacingOnHorizontal != _spacingOnHorizontal) {
        _spacingOnHorizontal = spacingOnHorizontal;
        [_collectionView reloadData];
    }
}

- (void)setSpacingOnVertical:(CGFloat)spacingOnVertical
{
    if (spacingOnVertical != _spacingOnVertical) {
        _spacingOnVertical = spacingOnVertical;
        [_collectionView reloadData];
    }
}

#pragma mark Getter Method
- (NSInteger)maxItemNumOnHorizontal
{
    if (_maxItemNumOnHorizontal < 1) {
        _maxItemNumOnHorizontal = 1;
    }
    return _maxItemNumOnHorizontal;
}

#pragma mark  - UICollectionView Delegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"MyCollectionCellID";
    [_collectionView registerClass:[CDMenuCollectionCell class] forCellWithReuseIdentifier:@"MyCollectionCellID"];
    CDMenuCollectionCell * cell = (CDMenuCollectionCell *)[_collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [cell displayMenuItemData:[_item objectAtIndex:[indexPath row]] onMode:_showMode];
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    NSLog(@"%zi",[indexPath row]);
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(cdMenuView:didSelectItemAtIndex:)]) {
        [_delegate cdMenuView:self didSelectItemAtIndex:[indexPath row]];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size ;
    if (([_item count]/self.maxItemNumOnHorizontal)*self.maxItemNumOnHorizontal > [indexPath row]) {
        size = CGSizeMake((collectionView.frame.size.width - self.spacingOnHorizontal*self.maxItemNumOnHorizontal)/self.maxItemNumOnHorizontal, self.itemHeight);
    } else {
        //  不足4个则均分
        NSInteger num = [_item count] % self.maxItemNumOnHorizontal;
        size = CGSizeMake((collectionView.frame.size.width - self.spacingOnHorizontal*(num - 1))/num, self.itemHeight);
    }
    return size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return self.spacingOnVertical;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return self.spacingOnHorizontal;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.item count];
}

@end
