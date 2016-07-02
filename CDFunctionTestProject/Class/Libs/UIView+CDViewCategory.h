//
//  UIView+CDViewCategory.h
//  CDFunctionTestProject
//
//  Created by Cindy on 16/6/25.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CDViewCategory)

@property (nonatomic,assign) CGFloat cd_height;
@property (nonatomic,assign) CGFloat cd_width;
@property (nonatomic,assign) CGFloat cd_x;
@property (nonatomic,assign) CGFloat cd_y;


- (void)removeAllSubviews;


@end
