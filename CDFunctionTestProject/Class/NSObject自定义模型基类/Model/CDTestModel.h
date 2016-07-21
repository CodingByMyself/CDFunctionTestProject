//
//  CDTestModel.h
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/19.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDBaseObject.h"

@interface CDTestModel : CDBaseObject

@property (nonatomic,strong) NSNumber *userIdTest;  //  用户id
@property (nonatomic,retain) NSString *nameTest;
@property (nonatomic,strong) NSNumber *ageTest;
@property (nonatomic,strong) NSNumber *sexTest;
@property (nonatomic,strong) NSArray *contactPersonList;  //  常用联系人列表

@end
