//
//  CDBannerCarouselView.h
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/2/20.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CDBannerCarouselView;


@protocol CDBannerCarouselViewDelegate <NSObject>
@required
- (NSInteger)numberOfBannerItemOnBannerView:(CDBannerCarouselView *)bannerView;
- (UIImage *)bannerView:(CDBannerCarouselView *)bannerView itemImageAtIndex:(NSInteger)index;
@end

@interface CDBannerCarouselView : UIView

// default is UIViewContentModeScaleToFill
@property(nonatomic,assign) UIViewContentMode bannerContentMode;

#pragma mark - Init Method
- (instancetype)initBannerViewDefaultPlaceholderImage:(UIImage *)placeholderImage WithDelegate:(id<CDBannerCarouselViewDelegate>)delegate;
- (void)reload;

@end
