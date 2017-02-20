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


#pragma mark - Init Method
- (instancetype)initBannerViewWithDelegate:(id<CDBannerCarouselViewDelegate>)delegate;
- (void)reload;

@end
