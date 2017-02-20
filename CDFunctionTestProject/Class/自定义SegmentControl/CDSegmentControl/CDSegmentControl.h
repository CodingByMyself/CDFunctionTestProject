//
//  CDSegmentControl.h
//  KnowledgePool
//
//  Created by Cindy on 2017/2/20.
//  Copyright © 2017年 Comtop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDMenuItem.h"
@class CDSegmentControl;


typedef NSAttributedString *(^CDTitleFormatterBlock)(CDSegmentControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected);
typedef CGSize (^CDIconImageSizeBlock)(CDSegmentControl *segmentedControl, UIImage *icon, NSUInteger index, BOOL selected);


#pragma mark
@interface CDSegmentControl : UIControl

// 数据源集合
@property (nonatomic,strong) NSArray<CDSegmentMenuModel *> *segmentMenuList;

// 设置文本属性的block回调
@property (nonatomic,copy) CDTitleFormatterBlock titleFormatter;

// 设置图标大小的block回调
@property (nonatomic,copy) CDIconImageSizeBlock iconImageSize;

// 当前选中的索引值
@property (nonatomic,assign) NSInteger selectedIndex;

@end
