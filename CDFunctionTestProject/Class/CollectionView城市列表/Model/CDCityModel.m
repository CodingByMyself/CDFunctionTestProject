//
//  CDCityModel.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/8/8.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDCityModel.h"

@implementation CDCityModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.cityId = @"";
    self.name = @"";
    self.charCode = @"";
    self.charCodeAbb = @"";
    self.flag = @"";
}

@end
