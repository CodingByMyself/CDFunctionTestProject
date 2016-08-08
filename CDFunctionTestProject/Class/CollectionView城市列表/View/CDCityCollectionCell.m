//
//  CDCityCollectionCell.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/8/5.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDCityCollectionCell.h"

@implementation CDCityCollectionCell

- (void)initWithCityName:(NSString *)cityName atIndexPath:(NSIndexPath *)indexPath showBorder:(BOOL)show
{
    UILabel *labelDesr = [self viewWithTag:100];
    if (labelDesr == nil) {
        labelDesr = [[UILabel alloc] init];
        labelDesr.tag = 100;
        labelDesr.textColor = [UIColor darkGrayColor];
        labelDesr.font = [UIFont systemFontOfSize:13.5];
        [self addSubview:labelDesr];
        [labelDesr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(8.0);
            make.left.equalTo(self).offset(15.0);
            make.right.equalTo(self).offset(-15.0);
            make.bottom.equalTo(self).offset(-8.0);
        }];
    }
    labelDesr.text = cityName;
    
    // 文本显示模式
    if (show) {
        labelDesr.textAlignment = NSTextAlignmentCenter;
        labelDesr.layer.borderWidth = 0.5;
        labelDesr.layer.borderColor = DefineColorRGB(210, 210, 210, 1.0).CGColor;
        labelDesr.layer.cornerRadius = 6.0f;
        if (([indexPath row]+1)%3 == 0) {
            [labelDesr mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(0.0);
                make.right.equalTo(self.mas_right).offset(-16.0);
            }];
        } else if (([indexPath row]+1)%3 == 1) {
            [labelDesr mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(16.0);
                make.right.equalTo(self).offset(0.0);
            }];
        } else {
            [labelDesr mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(8.0);
                make.right.equalTo(self).offset(-8.0);
            }];
        }
        
    } else {
        labelDesr.textAlignment = NSTextAlignmentLeft;
        labelDesr.layer.borderWidth = 0;
        labelDesr.layer.cornerRadius = 0;
        [labelDesr mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10.0);
            make.right.equalTo(self).offset(-10.0);
        }];
    }
    [self layoutIfNeeded];
}

@end
