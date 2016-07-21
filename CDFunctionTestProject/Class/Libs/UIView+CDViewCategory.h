//
//  UIView+CDViewCategory.h
//  CDFunctionTestProject
//
//  Created by Cindy on 16/6/25.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import <UIKit/UIKit.h>

// 绘制边框的枚举
typedef NS_ENUM(NSInteger, ZJViewBorder) {
    ZJViewBorderTop = 1<<1,
    ZJViewBorderLeft = 1<<2,
    ZJViewBorderBottom = 1<<3,
    ZJViewBorderRight = 1<<4,
};



@interface UIView (CDViewCategory)

@property (nonatomic,assign) CGFloat cd_height;
@property (nonatomic,assign) CGFloat cd_width;
@property (nonatomic,assign) CGFloat cd_x;
@property (nonatomic,assign) CGFloat cd_y;

@property (nonatomic, assign) ZJViewBorder borderWhich;  //  自定义边框效果


- (void)removeAllSubviews;


@end
