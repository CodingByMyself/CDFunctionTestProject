//
//  CDTestFontViewController.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/15.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDTestFontViewController.h"

@interface CDTestFontViewController () <UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_table;
    NSMutableArray *_fontArray;
}
@end

@implementation CDTestFontViewController
- (void)viewWillLayoutSubviews
{
    _table.frame = self.view.bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"字体样式展示";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    _fontArray = [[NSMutableArray alloc] initWithCapacity:242];
    for (NSString * familyName in [UIFont familyNames]) {
        NSLog(@"Font FamilyName = %@",familyName); //*输出字体族科名字
        for (NSString * fontName in [UIFont fontNamesForFamilyName:familyName]) {
            NSLog(@"111111 ----> %@",fontName);
            [_fontArray addObject:fontName];
        }
    }
    
    
    _table = [[UITableView alloc] initWithFrame:self.view.bounds];
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    
}


#pragma mark - UITableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellID"];
    }
    
    cell.textLabel.numberOfLines = 0;
    //    NSString * testStr = @"It has 15 功能测试哦~";
    NSString * testStr  = [NSString stringWithFormat:@"我随手一打就是漂亮的十五个字了\n\n%@",_fontArray[indexPath.row]];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:testStr];
//    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,3)];
//    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3,4)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:[testStr rangeOfString:testStr]];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:_fontArray[indexPath.row] size:18] range:[testStr rangeOfString:testStr]];
    cell.textLabel.attributedText = str;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_fontArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return 80.0;
}



@end
