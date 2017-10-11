//
//  CDTestCitySelectedViewController.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/8/8.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDTestCitySelectedViewController.h"
#import "CDSelectedCityController.h"
#import "CDCityModel.h"

@interface CDTestCitySelectedViewController () <CDSelectedCityDelegate>
{
    UILabel *_labelName;
}
@end

@implementation CDTestCitySelectedViewController


#pragma mark - IBAction
- (void)startLoadCityList
{
    NSArray *data = [self loadCityData];
    CDSelectedCityController *selected = [[CDSelectedCityController alloc] initWithCityModelArray:data andItemSupperKey:@[@"热门城市"]];
    selected.delegate = self;
    [self.navigationController pushViewController:selected animated:YES];
}

- (NSArray *)loadCityData
{
    NSMutableArray *allCityList = [[NSMutableArray alloc] init];
    
    NSDictionary *flightCityDictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"flight-city" ofType:@"plist"]];
    NSArray *keyArray = [flightCityDictionary allKeys];
    for (NSString *key in keyArray) {
        NSArray *valueArray = [flightCityDictionary objectForKey:key];
        for (NSString *descrip in valueArray) {
            CDCityModel *cityModel = [[CDCityModel alloc] init];
            cityModel.supperKey = key;
            NSArray *descripArray = [descrip componentsSeparatedByString:@","];
            cityModel.name = [descripArray objectAtIndex:1];
            cityModel.charCode = [descripArray objectAtIndex:2];
            cityModel.charCodeAbb = [descripArray objectAtIndex:3];
            [allCityList addObject:cityModel];
        }
    }
    return allCityList;
}

#pragma mark - view
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"加载城市列表";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc] initWithTitle:@"城市" style:UIBarButtonItemStyleDone target:self action:@selector(startLoadCityList)];
    self.navigationItem.rightBarButtonItem = flipButton;
    
    
    
    _labelName = [[UILabel alloc] init];
    _labelName.textColor = [UIColor redColor];
    _labelName.text = @"请点击右上角的“城市”进入城市列表";
    _labelName.textAlignment = NSTextAlignmentCenter;
    _labelName.font = [UIFont systemFontOfSize:16.0];
    [self.view addSubview:_labelName];
    [_labelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@(50.0));
        make.center.equalTo(self.view);
    }];
    
}

#pragma mark - CDSelectedCityDelegate
- (void)didSelectedCity:(CDCityModel *)cityModel onController:(CDSelectedCityController *)controller
{
    _labelName.text = [NSString stringWithFormat:@"你选择了【 %@ 】",cityModel.name];
}

@end
