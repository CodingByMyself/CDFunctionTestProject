//
//  CDBaseTableViewCell.h
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/7.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#ifndef CDBaseTableViewCell_h
#define CDBaseTableViewCell_h


#import <UIKit/UIKit.h>

@interface CDBaseTableViewCell : UITableViewCell

/**
 *  外界访问cell背景视图的统一入口
 *
 *  @return 返回cell背景视图的引用对象
 */
@property (nonatomic,readonly) UIView *baseViewBg;
@property (nonatomic,readonly) UILabel *baseLabelTitle;



/**
 *  公共基类的cell初始化方法，利用唯一标示在指定的tableView中得到指定的cell实例；
 *  如果没有，则新建一个cell实例，并从一个指定的nib文件中加载视图；
 *
 *  @param identifier  对新创建的cell设置一个唯一标示，复用机制
 *  @param nibName  指定的nib文件名
 *  @param tableView  cell所在的tableView
 *
 *  @return 返回一个该cell的实例对象
 */
- (instancetype)initWithRestorationIdentifier:(NSString *)identifier fromNibFileName:(NSString *)nibName onTableView:(UITableView *)tableView;


/**
 *  公共基类的cell初始化方法，利用唯一标示在指定的tableView中得到指定的cell实例；
 *  如果没有 则新建一个cell实例；
 *
 *  @param identifier 对新创建的cell设置一个唯一标示，复用机制
 *  @param tableView  该cell所在的tableView
 *
 *  @return 返回一个该cell的实例对象
 */
- (instancetype)initWithRestorationIdentifier:(NSString *)identifier onTableView:(UITableView *)tableView;

/**
 *  初始化方法 （空实现，子类可以重载该方法来自定义初始化代码）
 */
- (void)setup;

@end



#endif /* CDBaseTableViewCell_h */


