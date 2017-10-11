//
//  CDAutoLayoutTableCell.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/11.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDAutoLayoutTableCell.h"

@interface CDAutoLayoutTableCell()
{
//    UILabel *_titleLabel;
//    UILabel *_contentLabel;
    UILabel *_lineLabel;
}
@end


@implementation CDAutoLayoutTableCell
@synthesize titleLabel = _titleLabel;
@synthesize contentLabel = _contentLabel;

#pragma mark - overwrite
- (void)setup
{
    [super setup];
    NSLog(@"我是子类的 setup 方法");
    
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
    
    _lineLabel = [[UILabel alloc] init];
    _lineLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:_lineLabel];
    
    
    CGFloat margin = 10;
    _titleLabel.sd_layout
    .leftSpaceToView(self.contentView, margin)
    .topSpaceToView(self.contentView, margin)
    .rightSpaceToView(self.contentView, margin)
    .heightIs(20);
    
    _lineLabel.sd_layout
    .leftSpaceToView(self.contentView, margin)
    .bottomSpaceToView(self.contentView, 0.0)
    .rightSpaceToView(self.contentView, margin)
    .heightIs(1.0);
    
    _contentLabel.sd_layout
    .leftEqualToView(_titleLabel)
    .rightEqualToView(_titleLabel)
    .topSpaceToView(_titleLabel, margin)
    .autoHeightRatio(0);
    
    [self setupAutoHeightWithBottomView:_contentLabel bottomMargin:margin];
}

#pragma mark - getter method
- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor darkGrayColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel
{
    if (_contentLabel == nil) {
        _contentLabel = [UILabel new];
        _contentLabel.textColor = [UIColor lightGrayColor];
        _contentLabel.font = [UIFont systemFontOfSize:14];
    }
    return _contentLabel;
}

#pragma mark
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
