//
//  RECDPreviewDocumentManager.h
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/4/13.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RECDPreviewDocumentManager : NSObject


/**
 目标文档的url地址，可以是网络url，也可以是本地沙盒文件 或 包内文件
 */
@property(nonatomic, strong) NSURL *documentURL;




#pragma mark - Public Method
/**
 初始化一个文档浏览管理对象
 
 @param previewController 需要显示文档的目标控制器
 @return 管理对象
 */
- (instancetype)initWithPreviewController:(UIViewController *)previewController;


/**
 开始显示文档内容
 */
- (void)startPreviewDocument;


@end
