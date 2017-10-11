//
//  CDBannerItemCell.m
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/2/20.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import "CDBannerItemCell.h"
#import "YYAnimatedImageView.h"
#import "CDLibHeader.h"


@interface CDBannerItemCell () <UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scalingImageView;
@end


@implementation CDBannerItemCell
@synthesize imageViewBanner = _imageViewBanner;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}

- (CGRect)getFitFrame
{
    // 基本尺寸参数
    CGSize boundsSize = CGSizeMake(ScreenWidth-2.0, ScreenHeight);
    CGFloat boundsWidth = boundsSize.width;
    CGFloat boundsHeight = boundsSize.height;
    
    CGSize imageSize = self.imageViewBanner.image.size;
    CGFloat imageWidth = imageSize.width;
    CGFloat imageHeight = imageSize.height;
    
    
//    CGRect imageFrame;
//    if (imageHeight < boundsHeight && imageWidth < boundsWidth) {
//        imageFrame = CGRectMake((boundsWidth - imageWidth)/2, 0, imageWidth, imageHeight);
//        self.scalingImageView.contentSize = CGSizeMake(boundsWidth , boundsHeight);
//        
//    }else{
//        imageFrame = CGRectMake(0, 0, boundsWidth, imageHeight * boundsWidth / imageWidth);
//        self.scalingImageView.contentSize = CGSizeMake(0, imageFrame.size.height);
//    }
    
    CGFloat scaleValue = imageWidth/imageHeight;
    CGRect imageFrame = CGRectMake(0, 0, boundsWidth, boundsWidth/scaleValue);
    self.scalingImageView.contentSize = imageFrame.size;
    
    
    // 内容尺寸
    // y值
    if (imageFrame.size.height < boundsHeight) {
//        imageFrame.origin.y = floorf((boundsHeight - imageFrame.size.height) / 2.0);
        imageFrame.origin.y = (boundsHeight - imageFrame.size.height) / 2.0;
    } else {
        imageFrame.origin.y = 0;
    }
    
    return imageFrame;
}

- (void)setup
{
    [self.imageViewBanner removeFromSuperview];
    
    if (self.enableZoom) {
        [self.scalingImageView addSubview:self.imageViewBanner];
        [self.scalingImageView setZoomScale:1.0 animated:YES];
        
        if (self.imageViewBanner.tag == 1) {
            self.scalingImageView.scrollEnabled = YES;
            self.imageViewBanner.frame = [self getFitFrame];
            self.scalingImageView.maximumZoomScale = 3.0;
        } else {
            self.scalingImageView.scrollEnabled = NO;
            self.imageViewBanner.bounds = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
            self.imageViewBanner.center = CGPointMake(ScreenWidth/2.0, ScreenHeight/2.0);
            self.scalingImageView.maximumZoomScale = 1.0;
        }
        
        self.scalingImageView.contentSize = self.imageViewBanner.frame.size;
        self.scalingImageView.delegate = self;
        
    } else {
        [self.scalingImageView removeFromSuperview];
        [self addSubview:self.imageViewBanner];
        [_imageViewBanner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
}

#pragma mark - UIScrollView Delegate Method
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageViewBanner;
}

// 调整图片在UIScrollView缩放后居中显示
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    self.imageViewBanner.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                    scrollView.contentSize.height * 0.5 + offsetY);
    
}


#pragma mark - Setter Method
- (void)setEnableZoom:(BOOL)enableZoom
{
    _enableZoom = enableZoom;
    [self setup];
}

#pragma mark - Getter Method
- (UIImageView *)imageViewBanner
{
    if (_imageViewBanner == nil) {
        _imageViewBanner = [[YYAnimatedImageView alloc] init];
        _imageViewBanner.tag = 0;
        _imageViewBanner.clipsToBounds = YES;
        _imageViewBanner.contentMode = UIViewContentModeScaleAspectFit;
        [self.scalingImageView addSubview:_imageViewBanner];
//        [_imageViewBanner mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(self.scalingImageView);
//            make.centerX.equalTo(self.scalingImageView);
//            make.height.equalTo(@(ScreenWidth));
//            make.width.equalTo(@(ScreenWidth));
//        }];
    }
    return _imageViewBanner;
}

- (UIScrollView *)scalingImageView
{
    if (_scalingImageView == nil) {
        _scalingImageView = [[UIScrollView alloc] init];
        _scalingImageView.clipsToBounds = YES;
        _scalingImageView.backgroundColor = [UIColor clearColor];
//        _scalingImageView.bounces = NO;
        _scalingImageView.alwaysBounceHorizontal = NO;
        _scalingImageView.alwaysBounceVertical = YES;
        _scalingImageView.directionalLockEnabled = YES;
        
//        _scalingImageView.bouncesZoom = YES;
//        _scalingImageView.zoomScale = 1.5;
        _scalingImageView.minimumZoomScale = 1.0 ;
        _scalingImageView.maximumZoomScale = 3.0;
        _scalingImageView.showsVerticalScrollIndicator = NO;
        _scalingImageView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scalingImageView];
        [_scalingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.centerX.equalTo(self);
            make.height.equalTo(@(ScreenHeight));
            make.width.equalTo(@(ScreenWidth-2.0));
        }];
    }
    return _scalingImageView;
}

@end
