//
//  CDKeywordsArrayView.m
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/3/21.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import "CDKeywordsArrayView.h"


@interface CDKeywordsArrayView() <UIGestureRecognizerDelegate>
{
    NSMutableArray <UIView *> *_selectedItems;
    
    NSInteger _numberOfItems;
    CGFloat _height;
}
@property (nonatomic,weak) id<CDKeywordsArrayViewDelegate> delegate;
@end

@implementation CDKeywordsArrayView

- (instancetype)initWithDelegate:(id<CDKeywordsArrayViewDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        [self setup];
    }
    return self;
}

- (void)setup
{
    _selectedItems = [[NSMutableArray alloc] init];
    
    if ([self.delegate respondsToSelector:@selector(numberOfKeywordsItem)]) {
        _numberOfItems = [self.delegate numberOfKeywordsItem];
    }
    
    CGFloat maxHeight = 0;
    CGFloat y = 10.0;
    CGFloat x = 15.0;
    for (NSInteger i = 0; i < _numberOfItems; i ++) {
        if ([self.delegate respondsToSelector:@selector(viewOfItemAtIndex:)]) {
            
            UIView *view = [self.delegate viewOfItemAtIndex:i];
            view.tag = i;
            view.userInteractionEnabled = YES;
            
            if ([view isKindOfClass:[UIView class]]) {
                
                CGSize size = [self.delegate sizeOfItemView:view atIndex:i];
                
                if (x + size.width > DefineScreenWidth) {
                    x = 15.0;
                    y = y + maxHeight + 10.0;
                    maxHeight = 0;
                }
                view.frame = CGRectMake(x, y, size.width, size.height);
                
                // 手势设置
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemViewTapGestureRecognizer:)];
                tap.delegate = self;
                tap.numberOfTapsRequired = 1;
                [view addGestureRecognizer:tap];
                
                [self addSubview:view];
                
                
                // 更新位置坐标
                maxHeight = MAX(maxHeight, size.height);
                x = x + size.width + 15.0;
            }
        }
    }
    
    _height = y + maxHeight + 10.0;
    
}

- (void)layoutSubviews
{
    // 更新高度约束
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(_height));
    }];
}

#pragma mark 
- (void)itemViewTapGestureRecognizer:(UITapGestureRecognizer *)tap
{
    NSLog(@"tap.view:\n\n%@",tap.view);
    if (self.multiple) {
        // 可多选
        if ([_selectedItems containsObject:tap.view]) {
            // 取消选中
            [_selectedItems removeObject:tap.view];
            if ([self.delegate respondsToSelector:@selector(didDeselectedItemView:atIndex:)]) {
                [self.delegate didDeselectedItemView:tap.view atIndex:tap.view.tag];
            }
        } else {
            // 选中
            [_selectedItems addObject:tap.view];
            if ([self.delegate respondsToSelector:@selector(didSelectedItemView:atIndex:)]) {
                [self.delegate didSelectedItemView:tap.view atIndex:tap.view.tag];
            }
        }
        
    } else {
        // 单选
        if ([_selectedItems containsObject:tap.view]) {
            [_selectedItems removeObject:tap.view];
            // 取消选中
            if ([self.delegate respondsToSelector:@selector(didDeselectedItemView:atIndex:)]) {
                [self.delegate didDeselectedItemView:tap.view atIndex:tap.view.tag];
            }
        } else {
            // 先取消选中
            if (_selectedItems.count > 0) {
                if ([self.delegate respondsToSelector:@selector(didDeselectedItemView:atIndex:)]) {
                    [self.delegate didDeselectedItemView:[_selectedItems firstObject] atIndex:[_selectedItems firstObject].tag];
                }
            }
            
            [_selectedItems removeAllObjects];
            // 再选中
            [_selectedItems addObject:tap.view];
            if ([self.delegate respondsToSelector:@selector(didSelectedItemView:atIndex:)]) {
                [self.delegate didSelectedItemView:tap.view atIndex:tap.view.tag];
            }
        }
    }
    
}

// 如果有item需要被设置为不可点击，则只需利用下面的代理方法返回NO即可
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    NSLog(@"touch.view:\n%@",touch.view);
    return YES;
}


@end
