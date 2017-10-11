//
//  CDTestModel.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/19.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDTestModel.h"

@implementation CDTestModel

#pragma mark - 初始化方法
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

//  设置初始值
- (void)setup
{
    self.userIdTest = @(0);
    self.nameTest = @"";
    self.ageTest = @(0);
    self.sexTest = @(0);
    self.contactPersonList = @[];
}

@end
