//
//  CDBannerItemCell.m
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/2/20.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import "CDBannerItemCell.h"



@interface CDBannerItemCell ()

@end


@implementation CDBannerItemCell
@synthesize imageViewBanner = _imageViewBanner;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateItemViewLayout];
}

- (void)updateItemViewLayout
{
    
}

#pragma mark - Getter Method
- (UIImageView *)imageViewBanner
{
    if (_imageViewBanner == nil) {
        _imageViewBanner = [[UIImageView alloc] init];
        _imageViewBanner.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageViewBanner];
        [_imageViewBanner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.top.equalTo(self);
            make.bottom.equalTo(self);
        }];
    }
    return _imageViewBanner;
}

@end
