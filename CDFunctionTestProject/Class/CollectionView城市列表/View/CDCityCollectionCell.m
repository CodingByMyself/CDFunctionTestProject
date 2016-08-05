//
//  CDCityCollectionCell.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/8/5.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDCityCollectionCell.h"

@implementation CDCityCollectionCell

- (void)initWithCityName:(NSString *)cityName atIndexPath:(NSIndexPath *)indexPath
{
    UILabel *labelDesr = [self viewWithTag:100];
    if (labelDesr == nil) {
        labelDesr = [[UILabel alloc] init];
        labelDesr.tag = 100;
        labelDesr.textColor = [UIColor darkGrayColor];
        labelDesr.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:labelDesr];
        [labelDesr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(5.0);
            make.left.equalTo(self).offset(15.0);
            make.right.equalTo(self).offset(-15.0);
            make.bottom.equalTo(self).offset(-5.0);
        }];
    }
    labelDesr.text = [NSString stringWithFormat:@"%zi%zi",[indexPath section],[indexPath row]];
    
    // 文本显示模式
    if ([indexPath section] == 0 || [indexPath section] == 1 || [indexPath section] == 2) {
        labelDesr.textAlignment = NSTextAlignmentCenter;
        labelDesr.layer.borderWidth = 1.0;
        labelDesr.layer.borderColor = DefineColorRGB(200, 200, 200, 1.0).CGColor;
        labelDesr.layer.cornerRadius = 3.0f;
        [labelDesr mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15.0);
            make.right.equalTo(self).offset(-15.0);
        }];
    } else {
        labelDesr.textAlignment = NSTextAlignmentLeft;
        labelDesr.layer.borderWidth = 0;
        labelDesr.layer.cornerRadius = 0;
        [labelDesr mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(25.0);
            make.right.equalTo(self).offset(-25.0);
        }];
    }
}

@end
