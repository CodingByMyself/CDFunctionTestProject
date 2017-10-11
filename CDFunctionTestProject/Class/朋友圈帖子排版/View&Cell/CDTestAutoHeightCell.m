//
//  CDTestAutoHeightCell.m
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/8/3.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import "CDTestAutoHeightCell.h"

@interface CDTestAutoHeightCell()

@property (nonatomic,strong) UILabel *labelTitle;
@property (nonatomic,strong) UITextView *labelContent;

@end

@implementation CDTestAutoHeightCell

- (void)setTitle:(NSString *)title content:(NSString *)content
{
    self.labelTitle.numberOfLines = 0;
//    self.labelContent.numberOfLines = 0;
    
    self.labelTitle.text = title;
    self.labelContent.text = content;
    
    
}


// If you are not using auto layout, override this method
- (CGSize)sizeThatFits:(CGSize)size
{
    CGFloat totalHeight = 10;
    totalHeight += [self.labelTitle sizeThatFits:size].height;
    totalHeight += 10;
    totalHeight += [self.labelContent sizeThatFits:size].height;
//    totalHeight += [self.labelContent contentSize].height;x
    totalHeight += 30; // margins
    return CGSizeMake(size.width, totalHeight);
}


#pragma mark -
- (UILabel *)labelTitle
{
    if (_labelTitle == nil) {
        _labelTitle = [[UILabel alloc] init];
        _labelTitle.textColor = [UIColor blackColor];
        _labelTitle.font = [UIFont systemFontOfSize:16.0];
//        _labelTitle.backgroundColor = [UIColor yellowColor];
        _labelTitle.numberOfLines = 0;
        [self addSubview:_labelTitle];
        [_labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(10.0);
            make.left.equalTo(self).offset(10.0);
            make.right.equalTo(self).offset(-10.0);
        }];
    }
    return _labelTitle;
}

- (UITextView *)labelContent
{
    if (_labelContent == nil) {
        _labelContent = [[UITextView alloc] init];
        _labelContent.font = [UIFont systemFontOfSize:16.0];
        _labelContent.textColor = [UIColor redColor];
        _labelContent.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _labelContent.editable = NO;
        _labelContent.scrollEnabled = NO;
        _labelContent.dataDetectorTypes = UIDataDetectorTypeLink;
        // specify amount to inset (positive) for each of the edges. values can be negative to 'outset'
        _labelContent.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        _labelContent.backgroundColor = [UIColor yellowColor];
        [_labelContent setTextAlignment:NSTextAlignmentLeft];//并设置左对齐
        
        [self addSubview:_labelContent];
        [_labelContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.labelTitle.mas_bottom).offset(10.0);
            make.left.equalTo(self).offset(6.0);
            make.right.equalTo(self).offset(-6.0);
//            make.bottom.equalTo(self).offset(-30.0);
        }];
    }
    return _labelContent;
}


@end
