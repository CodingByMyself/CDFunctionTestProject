//
//  CDBaseTableViewCell.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/7.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDBaseTableViewCell.h"

@interface CDBaseTableViewCell()
{
    
}
@end

@implementation CDBaseTableViewCell
@synthesize viewBg = _viewBg;
@synthesize labelTitle = _labelTitle;


#pragma mark - Public init method
/**
 *  公共基类的cell初始化方法，利用唯一标示在指定的tableView中得到指定的cell实例；
 *  如果没有，则新建一个cell实例，并从一个指定的nib文件中加载视图；
 *
 *  @param identifier  对新创建的cell设置一个唯一标示，复用机制
 *  @param nibName  指定的nib文件名
 *  @param tableView  cell所在的tableView
 *
 *  @return 返回一个该cell的实例对象
 */
- (instancetype)initWithRestorationIdentifier:(NSString *)identifier fromNibFileName:(NSString *)nibName onTableView:(UITableView *)tableView
{
    CDBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        NSLog(@"xibName = 【%@】",nibName);
        NSLog(@"NSStringFromClass([self class]) = 【%@】",NSStringFromClass([self class]));
        if (nibName) {
            //  开始寻找指定的nib
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
            for(id oneObject in nib) {
                if([oneObject isKindOfClass:[self class]]) { self = oneObject; break; }
            }
        }
        
        if (self == nil) {
            self = [super init];
        }
        [self setRestorationIdentifier:identifier];
        return self;
        
    } else {
        return cell;
    }
}

/**
 *  公共基类的cell初始化方法，利用唯一标示在指定的tableView中得到指定的cell实例；
 *  如果没有 则新建一个cell实例；
 *
 *  @param identifier 对新创建的cell设置一个唯一标示，复用机制
 *  @param tableView  该cell所在的tableView
 *
 *  @return 返回一个该cell的实例对象
 */
- (instancetype)initWithRestorationIdentifier:(NSString *)identifier onTableView:(UITableView *)tableView
{
    CDBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        self = [super init];
        [self setRestorationIdentifier:identifier];
        return self;
    } else {
        return cell;
    }
}

#pragma mark   -  property  getter  method
- (UIView *)viewBg
{
    if (_viewBg == nil) {
        _viewBg = [[UIView alloc] init];
        _viewBg.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_viewBg];
        [_viewBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_viewBg.superview);
            make.left.equalTo(_viewBg.superview);
            make.right.equalTo(_viewBg.superview);
            make.bottom.equalTo(_viewBg.superview);
        }];
    }
    return _viewBg;
}

- (UILabel *)labelTitle
{
    if (_labelTitle == nil) {
        _labelTitle = [[UILabel alloc] init];
        _labelTitle.font = [UIFont systemFontOfSize:15.0];
        _labelTitle.textColor = [UIColor darkGrayColor];
        [self.viewBg addSubview:_labelTitle];
        [_labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_labelTitle.superview);
            make.left.equalTo(_labelTitle.superview).offset(6.0);
            make.right.equalTo(_labelTitle.superview).offset(-6.0);
            make.bottom.equalTo(_labelTitle.superview);
        }];
    }
    return _labelTitle;
}

#pragma mark
- (void)layoutSubviews
{
    [self.contentView sendSubviewToBack:_viewBg];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
