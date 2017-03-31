//
//  CDSinglePageCollectionCell.h
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/3/9.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CDSinglePageCollectionCell;

@protocol CDFaceViewDelegate <NSObject>

@optional
- (void)didSelectedEmojString:(NSString *)string;
- (void)didClickedDeleteButton;

@end

@interface CDSinglePageCollectionCell : UICollectionViewCell

@property (nonatomic,strong) id <CDFaceViewDelegate> delegate;


- (void)setup;
- (void)setEmojList:(NSArray *)list;

@end
