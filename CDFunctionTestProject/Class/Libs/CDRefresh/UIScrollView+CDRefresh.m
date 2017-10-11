//
//  UIScrollView+CDRefresh.m
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/6/14.
//  Copyright © 2017年 Cindy. All rights reserved.
//


#import "CDRefreshHeader.h"
#import "CDRefreshFooter.h"
#import <objc/runtime.h>

@implementation NSObject (CDRefresh)

+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
}

+ (void)exchangeClassMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getClassMethod(self, method1), class_getClassMethod(self, method2));
}

@end



@implementation UIScrollView (CDRefresh)

#pragma mark - header
static const char CDRefreshHeaderKey = '\0';
- (void)setMj_header:(CDRefreshHeader *)mj_header
{
    if (mj_header != self.mj_header) {
        // 删除旧的，添加新的
        [self.mj_header removeFromSuperview];
        [self insertSubview:mj_header atIndex:0];
        
        // 存储新的
        [self willChangeValueForKey:@"mj_header"]; // KVO
        objc_setAssociatedObject(self, &CDRefreshHeaderKey,
                                 mj_header, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"mj_header"]; // KVO
    }
}

- (CDRefreshHeader *)mj_header
{
    return objc_getAssociatedObject(self, &CDRefreshHeaderKey);
}

#pragma mark - footer
static const char CDRefreshFooterKey = '\0';
- (void)setMj_footer:(CDRefreshFooter *)mj_footer
{
    if (mj_footer != self.mj_footer) {
        // 删除旧的，添加新的
        [self.mj_footer removeFromSuperview];
        [self insertSubview:mj_footer atIndex:0];
        
        // 存储新的
        [self willChangeValueForKey:@"mj_footer"]; // KVO
        objc_setAssociatedObject(self, &CDRefreshFooterKey,
                                 mj_footer, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"mj_footer"]; // KVO
    }
}

- (CDRefreshFooter *)mj_footer
{
    return objc_getAssociatedObject(self, &CDRefreshFooterKey);
}

#pragma mark - 过期
- (void)setFooter:(CDRefreshFooter *)footer
{
    self.mj_footer = footer;
}

- (CDRefreshFooter *)footer
{
    return self.mj_footer;
}

- (void)setHeader:(CDRefreshHeader *)header
{
    self.mj_header = header;
}

- (CDRefreshHeader *)header
{
    return self.mj_header;
}

#pragma mark - other
- (NSInteger)mj_totalDataCount
{
    NSInteger totalCount = 0;
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        
        for (NSInteger section = 0; section<tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        
        for (NSInteger section = 0; section<collectionView.numberOfSections; section++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return totalCount;
}

static const char CDRefreshReloadDataBlockKey = '\0';
- (void)setMj_reloadDataBlock:(void (^)(NSInteger))mj_reloadDataBlock
{
    [self willChangeValueForKey:@"mj_reloadDataBlock"]; // KVO
    objc_setAssociatedObject(self, &CDRefreshReloadDataBlockKey, mj_reloadDataBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"mj_reloadDataBlock"]; // KVO
}

- (void (^)(NSInteger))mj_reloadDataBlock
{
    return objc_getAssociatedObject(self, &CDRefreshReloadDataBlockKey);
}

- (void)executeReloadDataBlock
{
    !self.mj_reloadDataBlock ? : self.mj_reloadDataBlock(self.mj_totalDataCount);
}
@end

@implementation UITableView (CDRefresh)

+ (void)load
{
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(mj_reloadData)];
}

- (void)mj_reloadData
{
    [self mj_reloadData];
    
    [self executeReloadDataBlock];
}
@end

@implementation UICollectionView (CDRefresh)

+ (void)load
{
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(mj_reloadData)];
}

- (void)mj_reloadData
{
    [self mj_reloadData];
    
    [self executeReloadDataBlock];
}


@end


