//
//  CDTestBannerViewVC.m
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/2/20.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import "CDTestBannerViewVC.h"
#import "CDBannerCarouselView.h"

@interface CDTestBannerViewVC () <CDBannerCarouselViewDelegate>
@property (nonatomic,strong) CDBannerCarouselView *bannerView;
@end

@implementation CDTestBannerViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"测试轮播";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.bannerView.backgroundColor = [UIColor yellowColor];
    [self.bannerView reload];
}

#pragma mark - CDBannerView Delegate
- (NSInteger)numberOfBannerItemOnBannerView:(CDBannerCarouselView *)bannerView
{
    return 7;
}

- (UIImage *)bannerView:(CDBannerCarouselView *)bannerView itemImageAtIndex:(NSInteger)index
{
    return [UIImage imageNamed:[[NSString alloc] initWithFormat:@"h%zi.jpg",(index%3)+1]];
}

#pragma mark 
- (CDBannerCarouselView *)bannerView
{
    if (_bannerView == nil) {
        _bannerView = [[CDBannerCarouselView alloc] initBannerViewDefaultPlaceholderImage:nil WithDelegate:self];
        [self.view addSubview:_bannerView];
        [_bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.centerY.equalTo(self.view);
            make.height.equalTo(@200);
        }];
    }
    return _bannerView;
}

@end
