//
//  CDTestMenuViewController.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/8.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDTestMenuViewController.h"
#import "CDMenuView.h"

@interface CDTestMenuViewController () <CDMenuViewDelegate>
{
    CDMenuView *menu;
}
@end

@implementation CDTestMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"菜单展示";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 5; i ++) {
        [tempArray addObject:@{MenuTextKey : [NSString stringWithFormat:@"item-%zi",i+1] , MenuIconKey : @"test_icon"}];
    }
    menu = [[CDMenuView alloc] init];
    menu.delegate = self;
    menu.maxItemNumOnHorizontal = 3;
//    menu.maxItemNumOnHorizontal = 5;
    menu.itemHeight = 70.0;
    menu.spacingOnHorizontal = 1.0;
    menu.spacingOnVertical = 1.0;
//    menu.showMode = CDMenuShowModeIconAndText;
//    menu.showMode = CDMenuShowModeIcon;
    menu.item = [NSArray arrayWithArray:tempArray];
    [self.view addSubview:menu];
    CGFloat menuHeight = (menu.itemHeight + menu.spacingOnVertical)*ceil([menu.item count]*1.0/menu.maxItemNumOnHorizontal) - menu.spacingOnVertical;
    [menu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(menu.superview);
        make.left.equalTo(menu.superview);
        make.right.equalTo(menu.superview);
        make.height.equalTo(@(menuHeight));
    }];
}

#pragma mark - CDMenuView Delegate
- (void)cdMenuView:(CDMenuView *)menuView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"item  row = %zi",index);
}

@end
