//
//  CDTestAnimationViewController.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/12.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDTestAnimationViewController.h"
#import "CDFlipAnimation.h"
#import "CDWaveAnimation.h"
#import "CDRippleAnimation.h"
#import "CDCubeAnimation.h"
#import "CDContinueFrameAnimation.h"
#import "CDBounceAnimation.h"



@interface CDTestAnimationViewController () <UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableAnimation;
    NSArray *_animtionList;
    NSArray *_classList;
}
@end

@implementation CDTestAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"动画列表";
    self.view.backgroundColor = [UIColor whiteColor];

    _animtionList = @[@"翻转动画",@"波浪动画",@"涟漪动画",@"转场系列动画",@"逐帧动画",@"弹跳动画"];
    _classList = @[
                   [[CDFlipAnimation alloc] init] ,
                   [[CDWaveAnimation alloc] init],
                   [[CDRippleAnimation alloc] init],
                   [[CDCubeAnimation alloc] init],
                   [[CDContinueFrameAnimation alloc] init],
                   [[CDBounceAnimation alloc] init]
                   ];
    _tableAnimation = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableAnimation.delegate = self;
    _tableAnimation.dataSource = self;
    [self.view addSubview:_tableAnimation];
    
}

#pragma mark - UITableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellID"];
    }
    cell.textLabel.font = DefineFontLaoSangamMN(FontBaseSize);
    cell.textLabel.text = [NSString stringWithFormat:@"    %zi、 %@", ([indexPath row] + 1), _animtionList[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([_classList count] > [indexPath row]) {
        [self.navigationController pushViewController:_classList[indexPath.row] animated:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_animtionList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return 50.0;
}


@end
