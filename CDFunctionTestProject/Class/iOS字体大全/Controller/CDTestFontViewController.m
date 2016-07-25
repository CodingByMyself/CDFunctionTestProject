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
    [super viewWillLayoutSubviews];
    _table.frame = CGRectOffset(self.view.bounds, 0, CDNavigationBarHeight);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"字体样式展示";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    
    /**
     IOS Font :
     
     LaoSangamMN
     HiraMinProN-W3
     HiraMinProN-W6
     HelveticaNeue (Light)
     
     */
    
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
    _table.clipsToBounds = NO;
    [self.view addSubview:_table];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}


#pragma mark - UITableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellID"];
    }
    if ([indexPath row] == 0) {
        UIImageView *bg = [[UIImageView alloc] init];
        //    bg.backgroundColor = [UIColor yellowColor];
        bg.image = [UIImage imageNamed:@"IMG_2705.JPG"];
        bg.contentMode = UIViewContentModeScaleToFill;
        [cell addSubview:bg];
        [bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell);
            make.left.equalTo(cell);
            make.right.equalTo(cell);
            make.bottom.equalTo(cell);
        }];
    }
    
    cell.textLabel.numberOfLines = 0;
    //    NSString * testStr = @"It has 15 功能测试哦~";
    NSString * testStr  = [NSString stringWithFormat:@"我随手一打就是漂亮的十五个字了 \nFontName = \" %@ \"",_fontArray[indexPath.row]];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:testStr];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,3)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3,3)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(6,4)];
//    [str addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:[testStr rangeOfString:testStr]];
    [str addAttribute:NSFontAttributeName value:DefineFont(_fontArray[indexPath.row], FontBaseSize) range:[testStr rangeOfString:testStr]];
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
    if ([indexPath row] == 0) {
        return 400.0;
    } else {
        return 60.0;
    }
}



@end
