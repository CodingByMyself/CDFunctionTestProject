//
//  CDMomentsItemCell.m
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/5/9.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import "CDMomentsItemCell.h"


@interface CDMomentsItemCell ()
@property (nonatomic,strong) UIImageView *imageViewHeader; // 发布人的头像
@property (nonatomic,strong) UILabel *labelName; // 发布人的昵称
@property (nonatomic,strong) UILabel *labelDate; // 发布时时间
@property (nonatomic,strong) UILabel *labelContent; // 发布的内容
@end


CGFloat const CDMomentsItemCellMargin = 10.0;

@implementation CDMomentsItemCell




#pragma mark - Getter Method
- (UIImageView *)imageViewHeader
{
    if (_imageViewHeader == nil) {
        _imageViewHeader = [[UIImageView alloc] init];
        _imageViewHeader.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageViewHeader];
        [_imageViewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(CDMomentsItemCellMargin);
            make.top.equalTo(self);
            make.height.equalTo(@25.0);
            make.width.equalTo(_imageViewHeader.mas_height);
        }];
    }
    return _imageViewHeader;
}

- (UILabel *)labelName
{
    if (_labelName == nil) {
        _labelName = [[UILabel alloc] init];
        _labelName.textColor = [UIColor darkTextColor];
        _labelName.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:_labelName];
        [_labelName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageViewHeader.mas_right).offset(5.0);
            make.right.equalTo(self);
            make.centerY.equalTo(self.imageViewHeader);
        }];
    }
    return _labelName;
}

- (UILabel *)labelDate
{
    if (_labelDate == nil) {
        _labelDate = [[UILabel alloc] init];
        
        
    }
    return _labelDate;
}



@end
