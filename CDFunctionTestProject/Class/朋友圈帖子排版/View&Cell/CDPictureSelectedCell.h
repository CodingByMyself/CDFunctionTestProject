//
//  CDPictureSelectedCell.h
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/5/5.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import "CDBaseTableViewCell.h"

@interface CDPictureSelectedCell : CDBaseTableViewCell

@property (nonatomic,strong) NSArray *pictures;


#pragma mark - Public Method
+ (CGFloat)heightOfCell;



@end
