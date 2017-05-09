//
//  CDPictureSelectedCell.m
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/5/5.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import "CDPictureSelectedCell.h"
#import "RECDCollectionViewLinkFlowLayout.h"

#define ITEM_COUNT 4

@interface PictureCollectionCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView *imageViewPicture;
@end
@implementation PictureCollectionCell


#pragma mark Getter Method
- (UIImageView *)imageViewPicture
{
    if (_imageViewPicture == nil) {
        _imageViewPicture = [[UIImageView alloc] init];
        _imageViewPicture.clipsToBounds = YES;
        _imageViewPicture.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imageViewPicture];
        [_imageViewPicture mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return _imageViewPicture;
}

@end



#pragma mark - ——————【CDPictureSelectedCell】——————
@interface CDPictureSelectedCell() <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *collectionViewPicture;
@end


@implementation CDPictureSelectedCell

- (void)setup
{
    self.collectionViewPicture.delegate = self;
    self.collectionViewPicture.dataSource = self;
}

#pragma mark - Public Method
+ (CGFloat)heightOfCell
{
    CDPictureSelectedCell *pictureCell = [[CDPictureSelectedCell alloc] init];
    
    UICollectionViewFlowLayout *flow = (UICollectionViewFlowLayout *)pictureCell.collectionViewPicture.collectionViewLayout;
    
    CGFloat fitWidth = (DefineScreenWidth - flow.sectionInset.left - flow.sectionInset.right)/3.0 - flow.minimumInteritemSpacing;
    
    NSInteger mul = ITEM_COUNT%3 + ITEM_COUNT/3;
    
    CGFloat height = fitWidth*mul + flow.minimumLineSpacing*(mul-1);
    
    return height + flow.sectionInset.top + flow.sectionInset.bottom;
}

#pragma mark - Setter Method
- (void)setPictures:(NSArray *)pictures
{
    [self.collectionViewPicture reloadData];
}

#pragma mark - UICollection View Delegate
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"CDCityCollectionCell";
    [collectionView registerClass:[PictureCollectionCell class] forCellWithReuseIdentifier:CellIdentifier];
    PictureCollectionCell * cell = (PictureCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    if (indexPath.row + 1 == [collectionView numberOfItemsInSection:indexPath.section]) {
        cell.imageViewPicture.image = [UIImage imageNamed:@"follow_add_icon"];
    } else {
        cell.imageViewPicture.image = [UIImage imageNamed:@"placeholder"];
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section = %zi , item = %zi   clicked !",[indexPath section],[indexPath row]);
}

#pragma mark  Item Size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewFlowLayout *flow = (UICollectionViewFlowLayout *)collectionViewLayout;
    
    CGFloat fitWidth = (DefineScreenWidth - flow.sectionInset.left - flow.sectionInset.right)/3.0 - flow.minimumInteritemSpacing;
    
    CGSize size = CGSizeMake(fitWidth, fitWidth);

    return size;
}

#pragma mark  Item Number  And  Section Number
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return ITEM_COUNT;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//#pragma mark  Item  Spacing
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 1;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 1;
//}

#pragma mark - Getter Method
- (UICollectionView *)collectionViewPicture
{
    if (_collectionViewPicture == nil) {
        //  初始化装载控件
        UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumLineSpacing = 6.0;
        flowLayout.minimumInteritemSpacing = 6.0;
        flowLayout.sectionInset = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
//        RECDCollectionViewLinkFlowLayout *flowLayout= [[RECDCollectionViewLinkFlowLayout alloc] initWithKeywordsInterval:4.0];
//        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
//        flowLayout.minimumLineSpacing = 4.0;
//        //        flowLayout.minimumInteritemSpacing = 10.0;
//        flowLayout.sectionInset = UIEdgeInsetsMake(15, 0, 15, 0);
        _collectionViewPicture = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionViewPicture.backgroundColor = [UIColor whiteColor];
        //        _colelctionViewMade.alwaysBounceVertical = NO; // 不允许垂直方向
        _collectionViewPicture.showsVerticalScrollIndicator = NO;
        _collectionViewPicture.showsHorizontalScrollIndicator = NO;
        [self addSubview:_collectionViewPicture];
        [_collectionViewPicture mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return _collectionViewPicture;
}

@end
