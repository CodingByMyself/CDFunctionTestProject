//
//  CDAddInputTextCell.m
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/5/5.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import "CDAddInputTextCell.h"


CGFloat const CDAddInputTextCellMargin = 8.0;

@interface CDAddInputTextCell() <UITextViewDelegate>
@property (nonatomic,strong) UITextView *textViewInput;
@property (nonatomic,strong) UILabel *labelTips;
@end


@implementation CDAddInputTextCell


- (void)setup
{
    [self textViewDidChange:self.textViewInput];
}


#pragma mark - UITextViewDelegate Method
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 0) {
        // 隐藏tips
        self.labelTips.hidden = YES;
    } else {
        // 显示tips
        self.labelTips.hidden = NO;
    }
}


#pragma mark - Getter Method
- (UITextView *)textViewInput
{
    if (_textViewInput == nil) {
        _textViewInput = [[UITextView alloc] init];
//        _textViewInput.backgroundColor = [UIColor yellowColor];
        _textViewInput.textColor = [UIColor darkTextColor];
        _textViewInput.font = [UIFont systemFontOfSize:15.0];
        _textViewInput.textAlignment = NSTextAlignmentLeft;
        _textViewInput.delegate = self;
        [self addSubview:_textViewInput];
        [_textViewInput mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(CDAddInputTextCellMargin);
            make.top.equalTo(self).offset(0);
            make.right.equalTo(self).offset(-CDAddInputTextCellMargin);
            make.bottom.equalTo(self).offset(0);
        }];
    }
    return _textViewInput;
}

- (UILabel *)labelTips
{
    if (_labelTips == nil) {
        _labelTips = [[UILabel alloc] init];
//        _labelTips.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _labelTips.textColor = [UIColor lightGrayColor];
        _labelTips.font = self.textViewInput.font;
        _labelTips.text = @"这一刻的您想分享的...";
        [self.textViewInput.viewForFirstBaselineLayout addSubview:_labelTips];
        [_labelTips mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_labelTips.superview).offset(8.0);
            make.top.equalTo(_labelTips.superview).offset(6.0);
        }];
    }
    return _labelTips;
}
@end
