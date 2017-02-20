//
//  CDMenuItem.m
//  KnowledgePool
//
//  Created by Cindy on 2017/2/20.
//  Copyright © 2017年 Comtop. All rights reserved.
//

#import "CDMenuItem.h"


#pragma mark
@implementation CDSegmentMenuModel

@end



#pragma mark
@interface CDMenuItem ()

@property (nonatomic,strong) UILabel *labelTitle;
@property (nonatomic,strong) UIImageView *imageViewIcon;

@end

@implementation CDMenuItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateItemViewLayout];
}

#pragma mark private method
- (void)updateItemViewLayout
{
    [self.labelTitle removeFromSuperview];
    [self.imageViewIcon removeFromSuperview];
    
    switch (_model.layoutStyle) {
        case ONLY_TEXT:
        {
            self.labelTitle.attributedText = [self titleAttributte];
            [self addSubview:self.labelTitle];
            [self.labelTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
        }
            break;
        case ONLY_IMAGE:
        {
            CGSize iconSize = [self sizeOfIcon];
            self.imageViewIcon.image = _model.selected ? _model.iconSelected : _model.icon;
            [self addSubview:self.imageViewIcon];
            [self.imageViewIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@(iconSize.width));
                make.height.equalTo(@(iconSize.height));
                make.centerX.equalTo(self);
                make.centerY.equalTo(self);
            }];
        }
            break;
        case TEXT_AND_IMAGE:
        {
            self.labelTitle.attributedText = [self titleAttributte];
            self.imageViewIcon.image = _model.selected ? _model.iconSelected : _model.icon;
            CGSize iconSize = [self sizeOfIcon];
//            NSLog(@"iconSize = %@",NSStringFromCGSize(iconSize));
            CGFloat height = [self.labelTitle textRectForBounds:CGRectMake(0, 0, DefineScreenWidth, 100) limitedToNumberOfLines:1].size.height;
            // icon 在上
            [self addSubview:self.imageViewIcon];
            [self.imageViewIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@(iconSize.width));
                make.height.equalTo(@(iconSize.height));
                make.centerX.equalTo(self);
                make.centerY.equalTo(self).offset(-height/2.0);
            }];
            
            // title 在下
            [self addSubview:self.labelTitle];
            [self.labelTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self);
                make.right.equalTo(self);
                make.top.equalTo(self.imageViewIcon.mas_bottom);
            }];
        }
            break;
        default:
            break;
    }
}

- (CGSize)sizeOfIcon
{
    CGSize size;
    if ([_delegate respondsToSelector:@selector(itemCell:iconSizeAtSelected:)]) {
        size = [_delegate itemCell:self iconSizeAtSelected:_model.selected];
    }
    
    if (CGSizeEqualToSize(CGSizeZero, size)) {
        size = CGSizeMake(25.0, 25.0);
    }
    
    return size;
}

- (NSAttributedString *)titleAttributte
{
    NSAttributedString *attributteString;
    if ([_delegate respondsToSelector:@selector(itemCell:titleFormatterAtSelected:)]) {
        attributteString = [_delegate itemCell:self titleFormatterAtSelected:_model.selected];
    }
    
    if (attributteString == nil) {
        NSDictionary *attributtes = @{
                                      NSForegroundColorAttributeName : _model.selected ? [UIColor orangeColor]:[UIColor blackColor],
                                      NSFontAttributeName:[UIFont systemFontOfSize:15.0]};
        attributteString = [[NSAttributedString alloc] initWithString:_model.title attributes:attributtes];
    }
    return attributteString;
}

#pragma mark setter method
- (void)setModel:(CDSegmentMenuModel *)model
{
    _model = model;
    // 更新ui布局
    [self updateItemViewLayout];
}

- (void)setDelegate:(id<CDMenuItemDelegate>)delegate
{
    _delegate = delegate;
    // 更新ui布局
    [self updateItemViewLayout];
}

#pragma mark getter method
- (UILabel *)labelTitle
{
    if (_labelTitle == nil) {
        _labelTitle = [[UILabel alloc] init];
        _labelTitle.font = [UIFont systemFontOfSize:15.0];
        _labelTitle.textColor = [UIColor blackColor];
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

@end
