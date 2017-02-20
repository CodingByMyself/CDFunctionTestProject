//
//  CDBannerCarouselView.m
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/2/20.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import "CDBannerCarouselView.h"
#import "CDBannerItemCell.h"


@interface CDBannerCarouselView () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,weak) id<CDBannerCarouselViewDelegate> delegate;
@property (nonatomic,strong) UICollectionView *collectionViewBanner;
@end

@implementation CDBannerCarouselView

#pragma mark - Init Method
- (instancetype)initBannerViewWithDelegate:(id<CDBannerCarouselViewDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.backgroundColor = [UIColor yellowColor];
    self.collectionViewBanner.delegate = self;
    self.collectionViewBanner.dataSource = self;
}

- (void)reload
{
    [self.collectionViewBanner reloadData];
}

#pragma mark - UICollection View Delegate
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"CDBannerItemCellID";
    [self.collectionViewBanner registerClass:[CDBannerItemCell class] forCellWithReuseIdentifier:CellIdentifier];
    CDBannerItemCell * cell = (CDBannerItemCell *)[self.collectionViewBanner dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UIImage *image;
    if ([_delegate respondsToSelector:@selector(bannerView:itemImageAtIndex:)]) {
        image = [_delegate bannerView:self itemImageAtIndex:indexPath.row];
    }
    if ([image isKindOfClass:[UIImage class]] == NO) {
        image = [UIImage imageNamed:@""];
    }
    
    [cell setBannerImage:image];
    NSLog(@"image = %@\nsection = %zi , item = %zi   show  !",image,[indexPath section],[indexPath row]);
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section = %zi , item = %zi   clicked !",[indexPath section],[indexPath row]);
//    self.selectedIndex = indexPath.row;
}

#pragma mark  Item Size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(DefineScreenWidth, self.collectionViewBanner.bounds.size.height);
    return size;
}

#pragma mark  Item Number  And  Section Number
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([_delegate respondsToSelector:@selector(numberOfBannerItemOnBannerView:)]) {
        return [_delegate numberOfBannerItemOnBannerView:self];
    } else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark  Item  Spacing
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma mark UIScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    MTDetailLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
}

#pragma mark - Getter Method
- (UICollectionView *)collectionViewBanner
{
    if (_collectionViewBanner == nil) {
        //  初始化装载控件
        UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _collectionViewBanner.collectionViewLayout = flowLayout;
        _collectionViewBanner = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionViewBanner.backgroundColor = [UIColor clearColor];
        _collectionViewBanner.pagingEnabled = YES;
        _collectionViewBanner.alwaysBounceVertical = NO; // 不允许垂直方向
        _collectionViewBanner.showsVerticalScrollIndicator = NO;
        _collectionViewBanner.showsHorizontalScrollIndicator = NO;
        [self addSubview:_collectionViewBanner];
        [_collectionViewBanner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self);
        }];
        
    }
    return _collectionViewBanner;
}

@end
