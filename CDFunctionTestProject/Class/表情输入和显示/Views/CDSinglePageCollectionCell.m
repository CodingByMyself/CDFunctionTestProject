//
//  CDSinglePageCollectionCell.m
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/3/9.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import "CDSinglePageCollectionCell.h"


@interface CDFaceViewCollectionCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *imageViewEmoj;

@end

@implementation CDFaceViewCollectionCell

- (void)setEmojImage:(UIImage *)image
{
    self.imageViewEmoj.image = image;
}

#pragma mark - getter Method
- (UIImageView *)imageViewEmoj
{
    if (_imageViewEmoj == nil) {
        _imageViewEmoj = [[UIImageView alloc] init];
        _imageViewEmoj.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageViewEmoj];
        [_imageViewEmoj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(6.0);
            make.right.equalTo(self).offset(-6.0);
            make.top.equalTo(self).offset(6.0);
            make.bottom.equalTo(self).offset(-6.0);
        }];
    }
    return _imageViewEmoj;
}

@end






@interface CDSinglePageCollectionCell() <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *collectionViewSingle;
@property (nonatomic,strong) NSArray *expressionList;
@end


@implementation CDSinglePageCollectionCell

- (void)setup
{
    self.collectionViewSingle.delegate = self;
    self.collectionViewSingle.dataSource = self;
    self.collectionViewSingle.pagingEnabled = NO;
    
    [self.collectionViewSingle reloadData];
}

- (void)setEmojList:(NSArray *)list
{
    self.expressionList = [NSArray arrayWithArray:list];
    
    [self.collectionViewSingle reloadData];
}


#pragma mark - UICollection View Delegate
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"CDFaceViewCollectionCell";
    [collectionView registerClass:[CDFaceViewCollectionCell class] forCellWithReuseIdentifier:CellIdentifier];
    CDFaceViewCollectionCell * cell = (CDFaceViewCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    [cell setEmojImage:[UIImage imageNamed:self.expressionList[indexPath.row]]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"section = %zi , item = %zi   clicked !",[indexPath section],[indexPath row]);
    
    if (indexPath.row + 1 == self.expressionList.count) {
        // 删除按钮
        if ([self.delegate respondsToSelector:@selector(didClickedDeleteButton)]) {
            [self.delegate didClickedDeleteButton];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(didSelectedEmojString:)]) {
            [self.delegate didSelectedEmojString:self.expressionList[indexPath.row]];
        }
    }
    
}

#pragma mark  Item Size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size;
    if (collectionView.bounds.size.width > 320) {
        size = CGSizeMake(collectionView.bounds.size.width/10, collectionView.bounds.size.height/4);
    } else {
        size = CGSizeMake(collectionView.bounds.size.width/8, collectionView.bounds.size.height/4);
    }
    return size;
}

#pragma mark  Item Number  And  Section Number
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.expressionList.count;
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

#pragma mark - Getter Method
- (UICollectionView *)collectionViewSingle
{
    if (_collectionViewSingle == nil) {
        //  初始化装载控件
        UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _collectionViewSingle.collectionViewLayout = flowLayout;
        _collectionViewSingle = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionViewSingle.backgroundColor = [UIColor clearColor];
        _collectionViewSingle.directionalLockEnabled = YES;
        //        _collectionViewFaceList.alwaysBounceVertical = NO; // 不允许垂直方向
//        _collectionViewSingle.alwaysBounceHorizontal = NO; // 不允许水平方向
//        _collectionViewSingle.showsVerticalScrollIndicator = NO;
//        _collectionViewSingle.showsHorizontalScrollIndicator = NO;
        [self addSubview:_collectionViewSingle];
        [_collectionViewSingle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self);
        }];
        
    }
    return _collectionViewSingle;
}

@end
