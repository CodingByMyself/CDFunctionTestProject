//
//  CDTabBar.h
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/25.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CDTabBar;

@protocol CDTabBarDelegate <UITabBarDelegate>
- (void)cdTabBarClickCenterPlusBtn:(CDTabBar *)tabbar;
@end

@interface CDTabBar : UITabBar

@property(nonatomic,weak) id<CDTabBarDelegate> delegate;

@end
