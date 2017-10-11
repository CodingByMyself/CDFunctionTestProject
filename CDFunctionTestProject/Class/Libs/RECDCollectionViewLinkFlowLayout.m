//
//  RECDCollectionViewLinkFlowLayout.m
//  EOA
//
//  Created by Cindy on 2017/4/17.
//
//

#import "RECDCollectionViewLinkFlowLayout.h"

@interface RECDCollectionViewLinkFlowLayout ()

/** attrs的数组 */
@property(nonatomic,strong) NSMutableArray *attrsArray;

@property(nonatomic,assign) CGFloat itemInterval;

@end


@implementation RECDCollectionViewLinkFlowLayout

/**
 初始化一个布局类
 
 @param itemInterval Cell之间的间距
 @return 布局实例
 */
- (instancetype)initWithKeywordsInterval:(CGFloat)itemInterval
{
    self = [super init];
    if (self) {
        self.itemInterval = itemInterval;
    }
    return self;
}

#pragma mark - Getter Method
-(NSMutableArray *)attrsArray
{
    if(_attrsArray == nil){
        _attrsArray=[[NSMutableArray alloc] init];
    }
    return _attrsArray;
}


#pragma mark - Over Write Method
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    [self.attrsArray removeAllObjects];
    
    NSArray *attributeList = [super layoutAttributesForElementsInRect:rect];
    
    for (NSInteger i = 0 ; i < attributeList.count ; i ++) {
        UICollectionViewLayoutAttributes *layoutAttribute = attributeList[i];
        
        if (layoutAttribute.representedElementCategory == UICollectionElementCategoryCell) {
            UICollectionViewLayoutAttributes * attrs = [self layoutAttributesForItemAtIndexPath:layoutAttribute.indexPath];
            [self.attrsArray addObject:attrs];
        }
    }
    
    
    for (UICollectionViewLayoutAttributes *att in attributeList) {
        
        UICollectionViewLayoutAttributes *layoutAttributes;
        
        if ([att.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            // 头视图
            layoutAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:att.indexPath];
            
        } else if ([att.representedElementKind isEqualToString:UICollectionElementKindSectionFooter]) {
            // 脚视图
            layoutAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:att.indexPath];
        }
        
        if ([layoutAttributes isKindOfClass:[UICollectionViewLayoutAttributes class]]) {
            [self.attrsArray addObject:layoutAttributes];
        }
        
    }
    
    return self.attrsArray;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *layoutAttribute;
    
    @try {
        
        layoutAttribute = [super layoutAttributesForItemAtIndexPath:indexPath];
        
        if (layoutAttribute.frame.origin.x == self.sectionInset.left) {
            return layoutAttribute;
        } else {
            
            UICollectionViewLayoutAttributes *previousLayoutAttribute;
            NSInteger lastRow = indexPath.row-1;
            if (lastRow >=0 && lastRow < [self.collectionView numberOfItemsInSection:indexPath.section]) {
                previousLayoutAttribute = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:lastRow inSection:indexPath.section]];
            }
            //             UICollectionViewLayoutAttributes *previousLayoutAttribute = self.attrsArray.count > 0 ? [self.attrsArray lastObject] : nil;
            
            CGRect frame = layoutAttribute.frame;
            
            if (CGRectGetMinY(previousLayoutAttribute.frame) == CGRectGetMinY(layoutAttribute.frame)) {
                
                frame.origin.x = CGRectGetMaxX(previousLayoutAttribute.frame) + self.itemInterval;
                
                //                if (CGRectGetMaxX(frame) + self.sectionInset.right > ScreenWidth) {
                //                    // 叠加的宽度已经超出限制
                //                    frame.origin.x = self.sectionInset.left;
                //                    frame.origin.y = CGRectGetMaxY(previousLayoutAttribute.frame) + self.minimumLineSpacing;
                //                }
            } else {
                frame.origin.x = self.sectionInset.left;
            }
            
            layoutAttribute.frame = frame;
        }
        
    } @catch (NSException *exception) {
        MTDetailLog(@"异常信息：%@",exception);
    } @finally {
        return layoutAttribute;
    }
    
}



@end
