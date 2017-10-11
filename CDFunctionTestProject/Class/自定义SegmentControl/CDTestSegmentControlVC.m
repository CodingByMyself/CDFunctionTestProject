//
//  CDTestSegmentControlVC.m
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/2/20.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import "CDTestSegmentControlVC.h"
#import "CDSegmentControl.h"




@interface CDTestSegmentControlVC ()
{
    CDSegmentControl *_segment;
}
@end

@implementation CDTestSegmentControlVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat height = 40;
    NSArray *func = @[@"纯文字",@"纯图标",@"图文结合"];
    for (NSInteger i = 0; i < func.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(0, i*(height + 20.0) + 70, DefineScreenWidth, height);
        [button setTitle:func[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClikedEvnet:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [self.view addSubview:button];
    }
    
    _segment = [[CDSegmentControl alloc] init];
    _segment.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_segment];
    [_segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(300.0);
        make.height.equalTo(@(40));
    }];
    // 事件
    [_segment addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)segmentValueChanged:(CDSegmentControl *)segment
{
    NSLog(@"segmentValueChanged to %zi",segment.selectedIndex);
}

#pragma mark -
- (void)buttonClikedEvnet:(UIButton *)button
{
    if (button.tag == 0) {
        [self createOnlyTextSegment];
    } else if (button.tag == 1) {
        [self createOlnyIconSegment];
    } else {
        [self createTextAndIcon];
    }
}

- (void)createOnlyTextSegment
{
    // 设置选中和非选中的title属性
    _segment.titleFormatter = ^NSAttributedString *(CDSegmentControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected) {
        NSAttributedString *attString = selected ?
        [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor orangeColor],NSFontAttributeName:[UIFont systemFontOfSize:15.0]}] :
        [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:15.0]}];
        return attString;
    };
    
    // 设置数据源
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    NSArray *titles = @[@"本周热门",@"本月热门",@"年度热门",@"阅读最多",@"收藏最多",@"测试最长的标题"];
    for (NSInteger i = 0; i < titles.count; i++) {
        CDSegmentMenuModel *model = [[CDSegmentMenuModel alloc] init];
        model.title = titles[i];
        model.titleSelected = titles[i];
        model.layoutStyle = ONLY_TEXT;
        model.selected = i == 0 ? YES : NO;
        [temp addObject:model];
    }
    [_segment setSegmentMenuList:temp];
}

- (void)createOlnyIconSegment
{
    // 设置选中和非选中的icon大小
    _segment.iconImageSize = ^CGSize(CDSegmentControl *segmentedControl, UIImage *icon, NSUInteger index, BOOL selected) {
        return CGSizeMake(30, 30);
    };
    
    // 设置数据源
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    NSArray *icons1 = @[@"very_good_select_icon",@"very_good_select_icon",@"very_good_select_icon",@"very_good_select_icon",@"very_good_select_icon",@"very_good_select_icon"];
    NSArray *icons2 = @[@"very_good_deselect_icon",@"very_good_deselect_icon",@"very_good_deselect_icon",@"very_good_deselect_icon",@"very_good_deselect_icon",@"very_good_deselect_icon"];
    for (NSInteger i = 0; i < icons1.count; i++) {
        CDSegmentMenuModel *model = [[CDSegmentMenuModel alloc] init];
        model.icon = [UIImage imageNamed:icons1[i]];
        model.iconSelected = [UIImage imageNamed:icons2[i]];
        model.layoutStyle = ONLY_IMAGE;
        model.selected = i == 0 ? YES : NO;
        [temp addObject:model];
    }
    [_segment setSegmentMenuList:temp];
}

- (void)createTextAndIcon
{
    // 设置选中和非选中的title属性
    _segment.titleFormatter = ^NSAttributedString *(CDSegmentControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected) {
        NSAttributedString *attString = selected ?
        [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor orangeColor],NSFontAttributeName:[UIFont systemFontOfSize:12.0]}] :
        [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:12.0]}];
        return attString;
    };
    // 设置选中和非选中的icon大小
    _segment.iconImageSize = ^CGSize(CDSegmentControl *segmentedControl, UIImage *icon, NSUInteger index, BOOL selected) {
        return CGSizeMake(24, 24);
    };
    
    // 设置数据源
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    NSArray *titles = @[@"本周热门",@"本月热门",@"年度热门",@"阅读最多",@"收藏最多",@"测试最长的标题"];
    NSArray *icons2 = @[@"very_good_select_icon",@"very_good_select_icon",@"very_good_select_icon",@"very_good_select_icon",@"very_good_select_icon",@"very_good_select_icon"];
    NSArray *icons1 = @[@"very_good_deselect_icon",@"very_good_deselect_icon",@"very_good_deselect_icon",@"very_good_deselect_icon",@"very_good_deselect_icon",@"very_good_deselect_icon"];
    for (NSInteger i = 0; i < titles.count; i++) {
        CDSegmentMenuModel *model = [[CDSegmentMenuModel alloc] init];
        model.title = titles[i];
        model.titleSelected = titles[i];
        model.icon = [UIImage imageNamed:icons1[i]];
        model.iconSelected = [UIImage imageNamed:icons2[i]];
        model.layoutStyle = TEXT_AND_IMAGE;
        model.selected = i == 0 ? YES : NO;
        [temp addObject:model];
    }
    [_segment setSegmentMenuList:temp];
}

@end
