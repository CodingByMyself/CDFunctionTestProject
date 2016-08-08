//
//  CDCityModel.h
//  CDFunctionTestProject
//
//  Created by Cindy on 16/8/8.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDCityModel : NSObject

@property (nonatomic,retain) NSString *cityId;  //  城市id, 是某个城市的唯一标示
@property (nonatomic,retain) NSString *name; //  城市名字，如：深圳
@property (nonatomic,retain) NSString *charCode; //  全拼名字，如：shenzhen (比较时会忽略大小写)
@property (nonatomic,retain) NSString *charCodeAbb;  //  缩写名字，如：sz (比较时会忽略大小写)

@property (nonatomic,retain) NSString *supperKey; //  父节点 ，如深圳的父节点是：S (比较时会忽略大小写)
@property (nonatomic,retain) NSString *flag;  //  预留属性，一般用来扩展标志

@end
