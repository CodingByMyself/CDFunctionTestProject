//
//  CDBaseObject.h
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/20.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDBaseObject : NSObject

@property (nonatomic,retain,readonly) NSString *baseDescription;

#pragma mark Public method
- (NSDictionary *)modelDescription;

@end
