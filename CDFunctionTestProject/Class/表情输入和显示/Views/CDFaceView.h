//
//  CDFaceView.h
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/3/9.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDSinglePageCollectionCell.h"


@interface CDFaceView : UIView


- (void)setTheFaceViewDelegate:(id <CDFaceViewDelegate>)delegate;

- (void)reloadFaceView;

@end
