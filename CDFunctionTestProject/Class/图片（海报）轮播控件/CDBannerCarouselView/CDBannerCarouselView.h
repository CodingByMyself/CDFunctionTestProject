//
//  CDBannerCarouselView.h
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/2/20.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CDBannerCarouselView;



typedef enum {
    CDBannerCarouselViewPageContolAlimentCenter = 0,
    CDBannerCarouselViewPageContolAlimentRight
} CDBannerCarouselViewPageContolAliment;


@protocol CDBannerCarouselViewDelegate <NSObject>
@required
// 共有多少个索引项
- (NSInteger)numberOfBannerItemOnBannerView:(CDBannerCarouselView *)bannerView;
// 某个索引项需要显示的图片或广告
- (UIImage *)bannerView:(CDBannerCarouselView *)bannerView itemImageAtIndex:(NSInteger)index;
@optional
// banner已经滚动至某个索引项
- (void)bannerView:(CDBannerCarouselView *)bannerView didScrollToIndex:(NSInteger)index;
// banner已经点击选中了某个索引项
- (void)bannerView:(CDBannerCarouselView *)bannerView didSelectedIndex:(NSInteger)index;
@end


@interface CDBannerCarouselView : UIView

// default is UIViewContentModeScaleToFill
@property(nonatomic,assign) UIViewContentMode bannerContentMode;
// 分页控件的位置，默认是居中显示
@property(nonatomic,assign) CDBannerCarouselViewPageContolAliment pageControlAliment;

// 自动滚动翻页的时间间隔，默认是3s
// 注意:如果设置为0，则表示不允许自动翻页，只能手动翻页
@property(nonatomic,assign) CGFloat autoScrollTimeInterval; // 自动翻页时间间隔




#pragma mark - Init Method
- (instancetype)initBannerViewDefaultPlaceholderImage:(UIImage *)placeholderImage WithDelegate:(id<CDBannerCarouselViewDelegate>)delegate;

#pragma mark - Public Method
- (void)reload;
- (void)adjustWhenControllerViewWillAppera;

@end






