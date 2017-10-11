//
//  CDMenuCollectionCell.h
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/8.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDMenuView.h"


@interface CDMenuCollectionCell : UICollectionViewCell

@property (nonatomic,readonly) UIImageView *imageViewIcon;
@property (nonatomic,readonly) UILabel *labelTitle;



#pragma mark - public method
- (void)displayMenuItemData:(NSDictionary *)item onMode:(CDMenuShowMode)showMode;

@end
