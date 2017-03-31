//
//  CDKeywordsArrayView.h
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/3/21.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CDKeywordsArrayViewDelegate <NSObject>

@required
- (NSInteger)numberOfKeywordsItem;
- (UIView *)viewOfItemAtIndex:(NSInteger)index;
- (CGSize)sizeOfItemView:(UIView *)viewItem atIndex:(NSInteger)index;

@optional
// 选中
- (void)didSelectedItemView:(UIView *)viewItem atIndex:(NSInteger)index;
// 取消选中
- (void)didDeselectedItemView:(UIView *)viewItem atIndex:(NSInteger)index;

@end

@interface CDKeywordsArrayView : UIView


/**
 是否可以多选
 */
@property (nonatomic,assign) BOOL multiple;



/**
 初始化方法

 @param delegate 代理对象
 @return 实例
 */
- (instancetype)initWithDelegate:(id<CDKeywordsArrayViewDelegate>)delegate;


@end
