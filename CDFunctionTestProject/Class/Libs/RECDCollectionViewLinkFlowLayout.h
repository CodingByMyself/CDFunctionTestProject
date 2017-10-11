//
//  RECDCollectionViewLinkFlowLayout.h
//  EOA
//
//  Created by Cindy on 2017/4/17.
//
//

#import <UIKit/UIKit.h>

@interface RECDCollectionViewLinkFlowLayout : UICollectionViewFlowLayout


/**
 初始化一个布局类
 
 @param itemInterval Cell之间的间距
 @return 布局实例
 */
- (instancetype)initWithKeywordsInterval:(CGFloat)itemInterval;


@end
