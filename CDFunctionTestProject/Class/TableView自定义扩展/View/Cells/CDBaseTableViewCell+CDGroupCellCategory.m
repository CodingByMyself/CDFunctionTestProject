//
//  CDBaseTableViewCell+CDGroupCellCategory.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/7.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDBaseTableViewCell+CDGroupCellCategory.h"
#import "UIView+RoundedCorner.h"



@implementation CDBaseTableViewCell (CDGroupCellCategory)

- (void)initViewBgLayerShadow
{
    if (self.viewBg.tag == 0) {
        self.viewBg.tag = 1123;
        self.viewBg.layer.shadowColor = [UIColor blackColor].CGColor;
        self.viewBg.layer.shadowOffset = CGSizeMake(0.0,0.5);
        self.viewBg.layer.shadowOpacity = 0.15f;
        self.viewBg.layer.shadowRadius = 0.5f;
        
        [self.viewBg mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.viewBg.superview).offset(10.0);
            make.right.equalTo(self.viewBg.superview).offset(-10.0);
            make.bottom.equalTo(self.viewBg.superview).offset(-0.6);
        }];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
}

#pragma mark  update  group  and  corner radius
- (void)updateLayoutAndLayerWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    [self initViewBgLayerShadow];
    
    CGFloat  outOpacity = 0.13f;  //  设置最外层的阴影透明度
    CGFloat inOpacity = 0.06f;  //  设置内层的cell阴影透明度
    CGFloat radius = 5;  //  设置每个section的圆角度
    
//    UIView *viewBg = [self getViewBg];
    if ([indexPath row] == 0 && [tableView numberOfRowsInSection:[indexPath section]] == 1) {  //  单行(只有一行)
        [self.viewBg jm_setJMRadius:JMRadiusMake(radius, radius, radius, radius) withBackgroundColor:[UIColor whiteColor]];
        self.viewBg.layer.shadowOpacity = outOpacity;
        
    } else if ([tableView numberOfRowsInSection:[indexPath section]] == [indexPath row] + 1) { //  最后一行（有多行）
        [self.viewBg jm_setJMRadius:JMRadiusMake(0, 0, radius, radius) withBackgroundColor:[UIColor whiteColor]];
        self.viewBg.layer.shadowOpacity = outOpacity;
        
    } else if ([indexPath row] == 0) {  //  首行（有多行）
        [self.viewBg jm_setJMRadius:JMRadiusMake(radius, radius, 0, 0) withBackgroundColor:[UIColor whiteColor]];
        self.viewBg.layer.shadowOpacity = inOpacity;
        
    } else {  //  其他行
        [self.viewBg jm_setJMRadius:JMRadiusMake(0, 0, 0, 0) withBackgroundColor:[UIColor whiteColor]];
        self.viewBg.layer.shadowOpacity = inOpacity;
    }
    
}


@end
