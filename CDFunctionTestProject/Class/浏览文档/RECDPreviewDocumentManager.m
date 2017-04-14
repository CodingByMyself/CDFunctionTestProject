//
//  RECDPreviewDocumentManager.m
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/4/13.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import "RECDPreviewDocumentManager.h"


@interface RECDPreviewDocumentManager () <UIDocumentInteractionControllerDelegate>

{
    UIViewController *_previewController;
}

@property (strong, nonatomic) UIDocumentInteractionController *documentPreview;

@end



@implementation RECDPreviewDocumentManager

#pragma mark
/**
 初始化一个文档浏览管理对象

 @param previewController 需要显示文档的目标控制器
 @return 管理对象
 */
- (instancetype)initWithPreviewController:(UIViewController *)previewController
{
    self = [super init];
    if (self) {
        _previewController = previewController;
    }
    return self;
}

#pragma mark - Public Method
/**
 开始显示文档
 */
- (void)startPreviewDocument
{
    // Preview PDF
    [self.documentPreview presentPreviewAnimated:YES];
}



#pragma mark - Document Interaction Controller Delegate Methods
- (UIViewController *)documentInteractionControllerViewControllerForPreview: (UIDocumentInteractionController *) controller
{
    return _previewController;
}

- (void)documentInteractionControllerWillBeginPreview:(UIDocumentInteractionController *)controller
{
    
}

#pragma mark - Setter Method
- (void)setDocumentURL:(NSURL *)documentURL
{
    _documentURL = documentURL;
    
    self.documentPreview.URL = documentURL;
}


#pragma mark  Getter Method
- (UIDocumentInteractionController *)documentPreview
{
    if (_documentPreview == nil) {
        // Initialize Document Interaction Controller
        _documentPreview = [UIDocumentInteractionController interactionControllerWithURL:self.documentURL];
        
        // Configure Document Interaction Controller
        [_documentPreview setDelegate:self];
    }
    return _documentPreview;
}

@end
