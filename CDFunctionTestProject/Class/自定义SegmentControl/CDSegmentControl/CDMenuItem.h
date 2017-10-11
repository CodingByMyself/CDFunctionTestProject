//
//  CDMenuItem.h
//  KnowledgePool
//
//  Created by Cindy on 2017/2/20.
//  Copyright © 2017年 Comtop. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CDMenuItem;


@protocol CDMenuItemDelegate <NSObject>
- (CGSize)itemCell:(CDMenuItem *)item iconSizeAtSelected:(BOOL)selected;
- (NSAttributedString *)itemCell:(CDMenuItem *)item titleFormatterAtSelected:(BOOL)selected;
@end



typedef enum : NSUInteger {
    ONLY_TEXT,
    ONLY_IMAGE,
    TEXT_AND_IMAGE,
} CDSegmentControlLayoutStyle;


#pragma mark
@interface CDSegmentMenuModel : NSObject
@property (nonatomic,assign) CDSegmentControlLayoutStyle layoutStyle;
@property (nonatomic,assign) BOOL selected;

@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *titleSelected;

@property (nonatomic,retain) UIImage *icon;
@property (nonatomic,retain) UIImage *iconSelected;
@end




@interface CDMenuItem : UICollectionViewCell

@property (nonatomic,weak) id <CDMenuItemDelegate> delegate;

@property (nonatomic,strong) CDSegmentMenuModel *model;

@end
