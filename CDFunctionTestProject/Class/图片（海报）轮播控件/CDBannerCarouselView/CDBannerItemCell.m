//
//  CDBannerItemCell.m
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/2/20.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import "CDBannerItemCell.h"



@interface CDBannerItemCell ()
@property (nonatomic,strong) UIImageView *imageViewBanner;
@end


@implementation CDBannerItemCell


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

#pragma mark - Private method
- (void)setBannerImage:(UIImage *)image
{
    self.imageViewBanner.image = image;
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
