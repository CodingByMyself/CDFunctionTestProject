//
//  CDSelectedCityController.h
//  CDFunctionTestProject
//
//  Created by Cindy on 16/8/5.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDCityModel.h"
@class CDSelectedCityController;

@protocol CDSelectedCityDelegate <NSObject>
- (void)didSelectedCity:(CDCityModel *)cityModel onController:(CDSelectedCityController *)controller;
@end

@interface CDSelectedCityController : UIViewController

@property (nonatomic,weak) id <CDSelectedCityDelegate> delegate;
- (instancetype)initWithCityModelArray:(NSArray *)cityList andItemSupperKey:(NSArray *)flagArray;

@end
