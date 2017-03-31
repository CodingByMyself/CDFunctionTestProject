//
//  CDTestKeywordsArrayVC.m
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/3/21.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import "CDTestKeywordsArrayVC.h"
#import "CDKeywordsArrayView.h"

@interface CDTestKeywordsArrayVC () <CDKeywordsArrayViewDelegate>
{
    NSArray *_keywords;
}
@property (nonatomic,strong) CDKeywordsArrayView *keywordView;
@end

@implementation CDTestKeywordsArrayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"测试关键字排版";
    
    _keywords = @[@"我们都是好孩子",@"测试",@"test",@"你来一个",@"说明是对的",@"我只是个关键字哦",@"啦"];
    
    self.keywordView.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark 
- (NSInteger)numberOfKeywordsItem
{
    return _keywords.count;
}

- (UIView *)viewOfItemAtIndex:(NSInteger)index
{
    UILabel *label = [[UILabel alloc] init];
    label.text = _keywords[index];
    label.font = DefineFontSystem(14);
    label.textColor = DefineColorHEX(0x7F7F7F);
    label.layer.cornerRadius = 3.0;
    label.layer.borderColor = DefineColorHEX(0x7F7F7F).CGColor;
    label.layer.borderWidth = 0.6;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (CGSize)sizeOfItemView:(UIView *)viewItem atIndex:(NSInteger)index
{
    UILabel *label = (UILabel *)viewItem;
    CGSize size = [label textRectForBounds:CGRectMake(0, 0, DefineScreenWidth - 20.0, DefineScreenHeight) limitedToNumberOfLines:0].size;
    
    return CGSizeMake(size.width+18.0, size.height + 15.0);
}

// 选中
- (void)didSelectedItemView:(UIView *)viewItem atIndex:(NSInteger)index
{
    UILabel *label = (UILabel *)viewItem;
    label.backgroundColor = DefineColorRGB(47.0, 199.0, 98.0, 0.2);
    label.textColor = DefineColorHEX(0x28C06C);
    label.layer.borderColor = DefineColorRGB(47.0, 199.0, 98.0, 0.5).CGColor;
}

// 取消选中
- (void)didDeselectedItemView:(UIView *)viewItem atIndex:(NSInteger)index
{
    UILabel *label = (UILabel *)viewItem;
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = DefineColorHEX(0x7F7F7F);
    label.layer.borderColor = DefineColorHEX(0x7F7F7F).CGColor;
}

#pragma mark - Getter Method
- (CDKeywordsArrayView *)keywordView
{
    if (_keywordView == nil) {
        _keywordView = [[CDKeywordsArrayView alloc] initWithDelegate:self];
        [self.view addSubview:_keywordView];
        [_keywordView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.top.equalTo(self.view).offset(100.0);
            make.height.equalTo(@50.0);
        }];
    }
    return _keywordView;
    
}

@end
