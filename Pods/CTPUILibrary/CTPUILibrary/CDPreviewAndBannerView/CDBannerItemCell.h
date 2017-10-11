//
//  CDBannerItemCell.h
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/2/20.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDBannerItemCell : UICollectionViewCell

@property (nonatomic,strong,readonly) UIImageView *imageViewBanner;
@property(nonatomic,assign) BOOL enableZoom; // 允许缩放

- (void)setup;

@end
