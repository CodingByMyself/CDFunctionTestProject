//
//  CDTestBaseModelViewController.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/19.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDTestBaseModelViewController.h"
#import "CDTestModel.h"

@interface CDTestBaseModelViewController ()

@end

@implementation CDTestBaseModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"模型扩展";
    self.view.backgroundColor = [UIColor whiteColor];

    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"打开控制台，查看打印日志";
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label.superview);
        make.right.equalTo(label.superview);
        make.centerY.equalTo(label.superview);
        make.height.equalTo(@(20.0));
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    CDTestModel *model = [[CDTestModel alloc] init];
    CDTestModel *model2 = [[CDTestModel alloc] init];
    model2.contactPersonList = @[[[CDTestModel alloc] init],@"我是个异类！",[[CDTestModel alloc] init]];
    model.contactPersonList = @[model2,@(1002),@(5555)];
    NSDictionary *dd = [model cd_ModelDescription];
//    MTDetailLog(@"modelDescription = %@\n",dd);
    MTDetailLog(@"JSONString ********** %@",[dd JSONString]);
    
    
    
    
    // 异步获取数据
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSString *url = @"http://qpool.motouch.cn/student_api/get_new_version_data?PageNum=1&PageSize=100&TableName=Mock&UserId=0&VersionNum=1";
        NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
        NSLog(@"Loaded");
        //        [jsonData dataUsingEncoding:NSUTF8StringEncoding];
        [CDBaseObject cd_dictionaryToLogJsonData:data andKey:@"Data" andKeyReplaceDictionary:nil];
    });
}

@end
