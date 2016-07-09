//
//  CDMenuCollectionCell.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/8.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDMenuCollectionCell.h"



@interface CDMenuCollectionCell()
{
    CDMenuShowMode _currentMode;
}

@end

@implementation CDMenuCollectionCell
@synthesize imageViewIcon = _imageViewIcon;
@synthesize labelTitle = _labelTitle;

#pragma mark 
- (void)layoutSubviews
{
    if (_currentMode == CDMenuShowModeIconAndText) {
        [_imageViewIcon mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self).offset( - (self.cd_height/2.5/3.0));
            make.height.equalTo(@(self.cd_height/2.5));
        }];
    } else if (_currentMode == CDMenuShowModeIcon) {
        [_imageViewIcon mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(self.cd_height/2.5));
        }];
    }
}

#pragma mark - getter method
- (UILabel *)labelTitle
{
    if (_labelTitle == nil) {
        _labelTitle = [[UILabel alloc] init];
        _labelTitle.font = [UIFont systemFontOfSize:12.0];
        _labelTitle.textColor = [UIColor darkGrayColor];
        _labelTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _labelTitle;
}

- (UIImageView *)imageViewIcon
{
    if (_imageViewIcon == nil) {
        _imageViewIcon = [[UIImageView alloc] init];
        _imageViewIcon.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageViewIcon;
}

#pragma mark - public method
- (void)displayMenuItemData:(NSDictionary *)item onMode:(CDMenuShowMode)showMode
{
    [self removeAllSubviews];
    switch (showMode) {
        case CDMenuShowModeIcon:
        {
            self.imageViewIcon.image = [UIImage imageNamed:[item objectForKey:MenuIconKey]];
            [self addSubview:_imageViewIcon];
            [_imageViewIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self);
                make.right.equalTo(self);
                make.centerY.equalTo(self);
                make.height.equalTo(@(self.cd_height/2.5));
            }];
        }
            break;
        case CDMenuShowModeText:
        {
            self.labelTitle.text = [item objectForKey:MenuTextKey];
            [self addSubview:_labelTitle];
            [_labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self);
                make.left.equalTo(self);
                make.right.equalTo(self);
                make.bottom.equalTo(self);
            }];
        }
            break;
        case CDMenuShowModeIconAndText:
        {
            self.labelTitle.text = [item objectForKey:MenuTextKey];
            self.imageViewIcon.image = [UIImage imageNamed:[item objectForKey:MenuIconKey]];
            [self addSubview:_imageViewIcon];
            [_imageViewIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self);
                make.right.equalTo(self);
                make.centerY.equalTo(self).offset( - (self.cd_height/2.5/3.0));
                make.height.equalTo(@(self.cd_height/2.5));
            }];
            [self addSubview:_labelTitle];
            [_labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_imageViewIcon.mas_bottom).offset(5.0);
                make.left.equalTo(_imageViewIcon);
                make.right.equalTo(_imageViewIcon);
            }];
        }
            break;
            
        default:
            break;
    }
    _currentMode = showMode;  //  记录下当前的模式
}

@end
