//
//  CDCenterViewController.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/25.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDCenterViewController.h"

@interface CDCenterViewController ()

@end

@implementation CDCenterViewController

- (void)closeThePush:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - view
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"添加";
    self.view.backgroundColor = [UIColor brownColor];
    
    
    //  关闭
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 20.0, DefineScreenWidth - 20.0*2, 50.0)];
    [button setTitle:@"点击关闭" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [button addTarget:self action:@selector(closeThePush:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
