//
//  UIScrollView+CDRefresh.h
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/6/14.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDRefreshConst.h"
#import "CDRefreshHeader.h"
#import "CDRefreshFooter.h"


@interface UIScrollView (CDRefresh)

/** 下拉刷新控件 */
@property (strong, nonatomic) CDRefreshHeader *mj_header;
@property (strong, nonatomic) CDRefreshHeader *header CDRefreshDeprecated("使用mj_header");
/** 上拉刷新控件 */
@property (strong, nonatomic) CDRefreshFooter *mj_footer;
@property (strong, nonatomic) CDRefreshFooter *footer CDRefreshDeprecated("使用mj_footer");

#pragma mark - other
- (NSInteger)mj_totalDataCount;
@property (copy, nonatomic) void (^mj_reloadDataBlock)(NSInteger totalDataCount);



@end
