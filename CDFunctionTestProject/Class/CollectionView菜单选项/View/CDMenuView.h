//
//  CDMenuView.h
//  CDMenuView
//
//  Created by Cindy on 16/4/19.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#ifndef CDMenuView_h
#define CDMenuView_h

#import <UIKit/UIKit.h>
#import "CDMenuView.h"

typedef NS_ENUM(NSInteger,CDMenuShowMode) {
    CDMenuShowModeText = 0,         //  纯文字类型
    CDMenuShowModeIcon,                //  纯图标类型
    CDMenuShowModeIconAndText,  //  图文混排类型
};

//
#define MenuTextKey @"title"
#define MenuIconKey @"icon"



@protocol CDMenuViewDelegate;

@interface CDMenuView : UIView

@property (nonatomic,weak) id<CDMenuViewDelegate> delegate;
// 菜单展示的类型
@property (nonatomic,assign) CDMenuShowMode showMode;
//  存放菜单展示的数据
@property (nonatomic,strong) NSArray *item;
//  在水平方向最大的item数
@property (nonatomic,assign) NSInteger maxItemNumOnHorizontal;
//  每个item的高度
@property (nonatomic,assign) CGFloat itemHeight;
//  水平方向的间距
@property (nonatomic,assign) CGFloat spacingOnHorizontal;
//  垂直方向的间距
@property (nonatomic,assign) CGFloat spacingOnVertical;


@end


@protocol CDMenuViewDelegate <NSObject>
@optional
- (void)cdMenuView:(CDMenuView *)menuView didSelectItemAtIndex:(NSInteger)index;
@end


#endif /* CDMenuView_h */
