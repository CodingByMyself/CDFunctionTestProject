//
//  CDFaceView.m
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/3/9.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import "CDFaceView.h"
#import "CDSinglePageCollectionCell.h"

@interface CDFaceView () <UICollectionViewDelegate,UICollectionViewDataSource>
{
    id <CDFaceViewDelegate> _itemDelegate;
}
@property (nonatomic,strong) UICollectionView *collectionViewFaceList;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) NSArray *expressionList;
@end


@implementation CDFaceView

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
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    NSInteger line_num = DefineScreenWidth > 320 ? 10 : 8;
    
    NSInteger pageNumber = 3;
    
    for (NSInteger j = 0; j < pageNumber; j ++) {
        NSMutableArray *subTemp = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < line_num*4; i ++) {
            NSString *expression;
            if (i + 1 == line_num*4) {
                // 删除按钮
                expression = @"delete_emotion_icon";
            } else {
                // 表情按钮
                NSInteger index = j*(line_num*4 - 1) + i;
                if (index + 1 < 10) {
                    expression = [NSString stringWithFormat:@"00%zi",index+1];
                } else if (index + 1 < 100) {
                    expression = [NSString stringWithFormat:@"0%zi",index+1];
                } else {
                    expression = [NSString stringWithFormat:@"%zi",index+1];
                }
            }
            
            [subTemp addObject:expression];
        }
        [temp addObject:subTemp];
    }
    
    self.expressionList = [NSArray arrayWithArray:temp];
    
    self.collectionViewFaceList.delegate = self;
    self.collectionViewFaceList.dataSource = self;
    self.collectionViewFaceList.pagingEnabled = YES;
    
    [self.collectionViewFaceList reloadData];
    
    self.pageControl.currentPage = 0;
}

#pragma mark - Public Method
- (void)setTheFaceViewDelegate:(id <CDFaceViewDelegate>)delegate
{
    _itemDelegate = delegate;
}

- (void)reloadFaceView
{
    [self.collectionViewFaceList reloadData];
}

#pragma mark - UICollection View Delegate
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"CDSinglePageCollectionCell";
    [collectionView registerClass:[CDSinglePageCollectionCell class] forCellWithReuseIdentifier:CellIdentifier];
    CDSinglePageCollectionCell * cell = (CDSinglePageCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    [cell setup];
    cell.delegate = _itemDelegate;
    [cell setEmojList:self.expressionList[indexPath.row]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section = %zi , item = %zi   clicked !",[indexPath section],[indexPath row]);
}

#pragma mark  Item Size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size;
    size = CGSizeMake(collectionView.bounds.size.width, collectionView.bounds.size.height);
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

#pragma mark UIScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating!!!");
    [self updateCurrentIndex];
}

- (void)updateCurrentIndex
{
    double indexDouble = self.collectionViewFaceList.contentOffset.x/self.collectionViewFaceList.frame.size.width;
    NSInteger index = round(indexDouble);
    if (index < self.pageControl.numberOfPages) {
        self.pageControl.currentPage = index;
    }
}

#pragma mark - Getter Method
- (UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = 3;
        _pageControl.currentPage = 0;
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        [self addSubview:_pageControl];
        [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.top.equalTo(self.collectionViewFaceList.mas_bottom);
            make.bottom.equalTo(self);
        }];
    }
    return _pageControl;
}

- (UICollectionView *)collectionViewFaceList
{
    if (_collectionViewFaceList == nil) {
        //  初始化装载控件
        UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _collectionViewFaceList.collectionViewLayout = flowLayout;
        _collectionViewFaceList = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionViewFaceList.backgroundColor = [UIColor clearColor];
        _collectionViewFaceList.directionalLockEnabled = YES;
//        _collectionViewFaceList.alwaysBounceVertical = NO; // 不允许垂直方向
        _collectionViewFaceList.alwaysBounceHorizontal = NO; // 不允许水平方向
        _collectionViewFaceList.showsVerticalScrollIndicator = NO;
        _collectionViewFaceList.showsHorizontalScrollIndicator = NO;
        [self addSubview:_collectionViewFaceList];
        [_collectionViewFaceList mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(0);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self).offset(-20.0);
        }];
        
    }
    return _collectionViewFaceList;
}

@end
