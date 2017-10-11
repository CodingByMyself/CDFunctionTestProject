//
//  CDBannerCarouselView.m
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/2/20.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import "CDBannerCarouselView.h"
#import "CDBannerItemCell.h"
#import "TAPageControl.h"

NSInteger const NumberOfItemsInSection = 10000;

@interface CDBannerCarouselView () <UICollectionViewDelegate,UICollectionViewDataSource,TAPageControlDelegate>
{
    NSInteger _currentIndex;
    
    UIImage *_placeholderImage;
    NSInteger _numberOfBanners;
    
    NSTimer *_timerAutoScorll;
}
@property (nonatomic,weak) id<CDBannerCarouselViewDelegate> delegate;
@property (nonatomic,strong) UICollectionView *collectionViewBanner;
@property (nonatomic,strong) TAPageControl *pageControl;
@end

@implementation CDBannerCarouselView

#pragma mark - Init Method
- (instancetype)initBannerViewDefaultPlaceholderImage:(UIImage *)placeholderImage WithDelegate:(id<CDBannerCarouselViewDelegate>)delegate
{
    self = [super init];
    if (self) {
        _placeholderImage = [placeholderImage isKindOfClass:[UIImage class]] ? placeholderImage :[UIImage imageNamed:@"placeholder"]; // 设置默认占位符
        self.delegate = delegate;
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.backgroundColor = [UIColor yellowColor];
    _currentIndex = 0;
    self.autoScrollTimeInterval = 3.0; // 没1秒过后自动翻页
    self.bannerContentMode = UIViewContentModeScaleToFill;
    self.collectionViewBanner.delegate = self;
    self.collectionViewBanner.dataSource = self;
    [self reload];
    
    // 设置分页控件的默认位置
    CGFloat width = _pageControl.dotSize.width*_numberOfBanners + _pageControl.spacingBetweenDots*((_numberOfBanners>0?_numberOfBanners:1)-1);
    [self.pageControl mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self);
        make.height.equalTo(@20.0);
        make.width.equalTo(@(width));
    }];
    self.pageControl.delegate = self;
    
    // 开启自动翻页
    [_timerAutoScorll invalidate];
    _timerAutoScorll = nil;
    _timerAutoScorll = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(timeStepAutoScorll:) userInfo:nil repeats:YES];
}

- (void)timeStepAutoScorll:(NSTimer *)timer
{
    NSInteger targetIndex = _currentIndex + 1;
    targetIndex = targetIndex < NumberOfItemsInSection ? targetIndex : 0;
    NSLog(@"timeStepAutoScorll targetIndex ---> %zi",targetIndex);
    if (targetIndex == 0) {
        [self.collectionViewBanner scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    } else {
        [self.collectionViewBanner scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}


- (void)destroy
{
    [_timerAutoScorll invalidate];
    _timerAutoScorll = nil;
    _placeholderImage = nil;
    self.collectionViewBanner.delegate = nil;
    self.collectionViewBanner.dataSource = nil;
    self.collectionViewBanner = nil;
    self.pageControl = nil;
}

#pragma mark - 生命周期相关的方法
//解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [self destroy];
    }
}

//解决当timer释放后 回调scrollViewDidScroll时访问野指针导致崩溃
- (void)dealloc
{
    [self destroy];
}



#pragma mark - Public Method
- (void)reload
{
    [self.collectionViewBanner reloadData];
    
    if ([_delegate respondsToSelector:@selector(numberOfBannerItemOnBannerView:)]) {
        _numberOfBanners = [_delegate numberOfBannerItemOnBannerView:self];
    } else {
        _numberOfBanners = 0;
    }
    self.pageControl.numberOfPages = _numberOfBanners;
    [self.pageControl sizeToFit];
    [self.pageControl updateLayout];
}

- (void)adjustWhenControllerViewWillAppera
{
    [self.pageControl sizeToFit];
    long targetIndex = _currentIndex;
    if (targetIndex < _numberOfBanners) {
        [self.collectionViewBanner scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

#pragma mark - UICollection View Delegate
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"CDBannerItemCellID";
    [self.collectionViewBanner registerClass:[CDBannerItemCell class] forCellWithReuseIdentifier:CellIdentifier];
    CDBannerItemCell * cell = (CDBannerItemCell *)[self.collectionViewBanner dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSInteger index = _numberOfBanners > 0 ? indexPath.row%_numberOfBanners : 0;
    UIImage *image;
    if ([_delegate respondsToSelector:@selector(bannerView:itemImageAtIndex:)]) {
        image = [_delegate bannerView:self itemImageAtIndex:index];
    }
    image = [image isKindOfClass:[UIImage class]] ? image : _placeholderImage;
    
    cell.imageViewBanner.image = image;
    cell.imageViewBanner.contentMode = self.bannerContentMode;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section = %zi , item = %zi   clicked !",[indexPath section],[indexPath row]);
    _currentIndex = indexPath.row;
    NSInteger index = _numberOfBanners > 0 ? indexPath.row % _numberOfBanners : 0;
    // 通知代理
    if ([_delegate respondsToSelector:@selector(bannerView:didSelectedIndex:)]) {
        [_delegate bannerView:self didSelectedIndex:index];
    }
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
        _numberOfBanners = [_delegate numberOfBannerItemOnBannerView:self];
    } else {
        _numberOfBanners = 0;
    }
    return NumberOfItemsInSection;
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
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self updateCurrentIndex];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating!!!");
    [_timerAutoScorll invalidate];
    _timerAutoScorll = nil;
    self.autoScrollTimeInterval = _autoScrollTimeInterval;
    
    [self updateCurrentIndex];
}

- (void)updateCurrentIndex
{
    double indexDouble = self.collectionViewBanner.contentOffset.x/self.collectionViewBanner.frame.size.width;
    NSInteger index = round(indexDouble);
    // 设置分页控件的当前页
    NSInteger currentPage = _numberOfBanners > 0 ? index%_numberOfBanners : 0;
    
    if (_currentIndex != index) {
        _currentIndex = index;
        // 通知代理
        if ([_delegate respondsToSelector:@selector(bannerView:didScrollToIndex:)]) {
            [_delegate bannerView:self didScrollToIndex:currentPage];
        }
    }
    self.pageControl.currentPage = currentPage;
}

#pragma mark - TAPageControl Delegate method
- (void)TAPageControl:(TAPageControl *)pageControl didSelectPageAtIndex:(NSInteger)index
{
    [self.collectionViewBanner scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

#pragma mark - Setter Method
- (void)setPageControlAliment:(CDBannerCarouselViewPageContolAliment)pageControlAliment
{
    _pageControlAliment = pageControlAliment;
    
    CGFloat width = _pageControl.dotSize.width*_numberOfBanners + _pageControl.spacingBetweenDots*(_numberOfBanners + 1);
    if (_pageControlAliment == CDBannerCarouselViewPageContolAlimentRight) {
        [self.pageControl mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15.0);
            make.bottom.equalTo(self);
            make.height.equalTo(@20.0);
            make.width.equalTo(@(width));
        }];
    } else {
        [self.pageControl mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self);
            make.height.equalTo(@20.0);
            make.width.equalTo(@(width));
        }];
    }
    
}

- (void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval
{
    _autoScrollTimeInterval = autoScrollTimeInterval;
    if (_autoScrollTimeInterval > 0) {
        [_timerAutoScorll invalidate];
        _timerAutoScorll = nil;
        _timerAutoScorll = [NSTimer scheduledTimerWithTimeInterval:_autoScrollTimeInterval target:self selector:@selector(timeStepAutoScorll:) userInfo:nil repeats:YES];
    } else {
        [_timerAutoScorll invalidate];
        _timerAutoScorll = nil;
    }
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

- (TAPageControl *)pageControl
{
    if (_pageControl == nil) {
        _pageControl = [[TAPageControl alloc] init];
//        _pageControl.backgroundColor = [UIColor greenColor];
        // Custom dot view with image
        _pageControl.dotImage = [UIImage imageNamed:@"dotInactive"];
        _pageControl.currentDotImage = [UIImage imageNamed:@"dotActive"];
        _pageControl.dotSize = CGSizeMake(12.0, 12.0);
        [self addSubview:_pageControl];
        [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self);
            make.height.equalTo(@20);
            make.width.equalTo(@(80.0));
        }];
    }
//    [self layoutIfNeeded];
    return _pageControl;
}

@end
