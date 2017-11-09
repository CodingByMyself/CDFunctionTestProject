//
//  CDTestBannerViewVC.m
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/2/20.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import "CDTestBannerViewVC.h"
#import "CDBannerCarouselView.h"
#import "YYWebImageManager.h"

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
    
    
    [[YYWebImageManager sharedManager] requestImageWithURL:[NSURL URLWithString:@"http://eim2.szcomtop.com:6888/api/fs/view/Z3JvdXAxL00wMC8wMC9BQi9DZ3B1WmxtdVRNeUFJc0hKQUFER0NKTlZLZ0E1OTMwNTkz?size=s"] options:YYWebImageOptionRefreshImageCache progress:nil transform:nil completion:nil];
    
    [self.bannerView reload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.bannerView adjustWhenControllerViewWillAppera];
}

#pragma mark - CDBannerView Delegate
- (NSInteger)numberOfBannerItemOnBannerView:(CDBannerCarouselView *)bannerView
{
    return 3;
}

- (UIImage *)bannerView:(CDBannerCarouselView *)bannerView itemImageAtIndex:(NSInteger)index
{
    return [UIImage imageNamed:[[NSString alloc] initWithFormat:@"h%zi.jpg",(index%3)+1]];
}

// banner已经滚动至某个索引项
- (void)bannerView:(CDBannerCarouselView *)bannerView didScrollToIndex:(NSInteger)index
{
    NSLog(@"bannerView didScrollToIndex : %zi",index);
}

// banner已经点击选中了某个索引项
- (void)bannerView:(CDBannerCarouselView *)bannerView didSelectedIndex:(NSInteger)index
{
    NSLog(@"bannerView didSelectedIndex : %zi",index);
}

#pragma mark 
- (CDBannerCarouselView *)bannerView
{
    if (_bannerView == nil) {
        _bannerView = [[CDBannerCarouselView alloc] initBannerViewDefaultPlaceholderImage:nil WithDelegate:self];
        self.bannerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.bannerView.pageControlAliment = CDBannerCarouselViewPageContolAlimentRight;
        [self.view addSubview:_bannerView];
        [_bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.centerY.equalTo(self.view);
            make.height.equalTo(@150);
        }];
    }
    return _bannerView;
}

@end
