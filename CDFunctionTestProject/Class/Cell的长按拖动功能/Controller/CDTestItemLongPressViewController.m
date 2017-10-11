//
//  CDTestItemLongPressViewController.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/28.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDTestItemLongPressViewController.h"
#import "CDCollectionViewFlowLayout.h"

NSInteger const  CollectionViewSectionNumber = 3;
@interface CDTestItemLongPressViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    NSMutableArray *_dataList[CollectionViewSectionNumber];
}

@end

@implementation CDTestItemLongPressViewController

#pragma mark - LongPressGesture Method
- (void)longPressGestureRecognized:(UILongPressGestureRecognizer *)longPress
{
    UIGestureRecognizerState states = longPress.state; //长按状态
    CGPoint location = [longPress locationInView:_collectionView];  //获取长按的位置
    NSIndexPath *indexPath = [_collectionView indexPathForItemAtPoint:location]; //根据位置得到cell的索引位置
    
    static UIView *snapshot = nil; //创建一个截图
    static NSIndexPath *souceIndexPath = nil; //开始移动cell的indexPath
    switch (states) {
        case UIGestureRecognizerStateBegan: {  //刚开始按下的时候获取到当前位置的cell
            souceIndexPath = indexPath;
            UICollectionViewCell *cell = [_collectionView cellForItemAtIndexPath:indexPath];
            snapshot = [self customSnapShottFromView:cell]; //得到一个截图View
            snapshot.center = cell.center;  //将得到的截图放到列表上
            snapshot.alpha = 0.0;
            [_collectionView addSubview:snapshot];
            //使用动画完成一个截图的拖拽效果
            [UIView animateWithDuration:0.15 animations:^{
                snapshot.center = location;
                snapshot.transform = CGAffineTransformMakeScale(0.98, 0.98); //将截图方法
                snapshot.alpha = 0.95; //将截图渐变
//                cell.backgroundColor = [UIColor clearColor]; //设置背景颜色
            }];
        }
            break;
        case UIGestureRecognizerStateChanged: {
            //如果手势移动的距离对应带另外一个 index path 就需要告诉Collection View，让它移动rows，同时你需要对data source进行更新。
            snapshot.center = location;
            //判断是否移动初始化的cell，indexPath为当前选中的cell sourceIndexPath为“移动”的cell
            if (indexPath && ![indexPath isEqual:souceIndexPath] && [indexPath section] == [souceIndexPath section]) {
                // TODO交换数据，即使重新加载数据位置也不会还原，如果注释这一行 则reload之后数据位置会还原
                [_dataList[souceIndexPath.section] exchangeObjectAtIndex:indexPath.row withObjectAtIndex:souceIndexPath.row];
                [_collectionView moveItemAtIndexPath:souceIndexPath toIndexPath:indexPath];  //交换cell
                souceIndexPath = indexPath; //将indexPath最为移动的cell
            }
        }
            break;
        default: {
            //当手势结束或者取消的时候，Collection View 和 data source都是最新的，将snapshot View
            //从Collection View中移除，并将Collection View Cell的背景颜色还原
            UICollectionViewCell *cell = [_collectionView cellForItemAtIndexPath:indexPath];
            [UIView animateWithDuration:0.15 animations:^{
                snapshot.center = cell.center;
                //还原成初始化的状态
                snapshot.transform = CGAffineTransformIdentity;
                snapshot.alpha = 0.0;
//                cell.backgroundColor = [UIColor whiteColor];
            } completion:^(BOOL finished) {
                [snapshot removeFromSuperview];
            }];
            
            souceIndexPath = nil;
        }
            break;
    }
    
}

- (UIView *)customSnapShottFromView:(UIView *)view
{
    UIView *snapshotView;
    if (IOS_VERSION >= 7.0) {
        snapshotView = [view snapshotViewAfterScreenUpdates:YES];
        snapshotView.layer.masksToBounds = NO;
        snapshotView.layer.borderWidth = 0.5;
        snapshotView.layer.borderColor = DefineColorRGB(180.0, 180.0, 180.0, 0.6).CGColor;
        snapshotView.layer.shadowColor = DefineColorRGB(180.0, 180.0, 180.0, 1.0).CGColor;
        snapshotView.layer.shadowOffset = CGSizeMake(0.0,0.0);
        snapshotView.layer.shadowOpacity = 1.0f;
        snapshotView.layer.shadowRadius = 2.0f;
    } else {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        snapshotView = [[UIView alloc] initWithFrame:view.bounds];
        [snapshotView setBackgroundColor:[UIColor colorWithPatternImage:snapshot]];
        snapshotView.layer.masksToBounds = NO;
        snapshotView.layer.borderWidth = 0.5;
        snapshotView.layer.borderColor = DefineColorRGB(180.0, 180.0, 180.0, 0.6).CGColor;
        snapshotView.layer.shadowColor = DefineColorRGB(180.0, 180.0, 180.0, 1.0).CGColor;
        snapshotView.layer.shadowOffset = CGSizeMake(1.0,1.0);
        snapshotView.layer.shadowOpacity = 1.0f;
        snapshotView.layer.shadowRadius = 2.0f;
    }
    return snapshotView;
}

#pragma mark - view
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Item长按拖拽";
    
    //  制造数据源
    for (NSInteger j = 0; j < CollectionViewSectionNumber ; j ++) {
        _dataList[j] = [[NSMutableArray alloc] init];
        for (NSInteger i = 0 ;i < 8*(j+1); i ++) {
            [_dataList[j] addObject:[NSString stringWithFormat:@"%zi-长按(%zi)",j, (i + 1)]];
        }
    }
    
    
    
    
    //  初始化装载控件
    CDCollectionViewFlowLayout *flowLayout= [[CDCollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.isSuspend = YES;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _collectionView.collectionViewLayout = flowLayout;
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    //  添加长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGestureRecognized:)];
    longPress.minimumPressDuration = 0.3;
    [_collectionView addGestureRecognizer:longPress];
    
}

#pragma mark - UI Collection View  Data  And  Delegate
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"MyCollectionCellID";
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"MyCollectionCellID"];
    UICollectionViewCell * cell = (UICollectionViewCell *)[_collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UILabel *labelDesr = [cell viewWithTag:100];
    if (labelDesr == nil) {
        labelDesr = [[UILabel alloc] initWithFrame:cell.bounds];
        labelDesr.tag = 100;
        labelDesr.textAlignment = NSTextAlignmentCenter;
        labelDesr.textColor = [UIColor darkGrayColor];
        labelDesr.font = [UIFont systemFontOfSize:14.0];
        [cell addSubview:labelDesr];
    }
    labelDesr.text = _dataList[indexPath.section][indexPath.row];
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section = %zi , item = %zi   clicked !",[indexPath section],[indexPath row]);
}

#pragma mark  Header  View   or   Footer   View
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:UICollectionElementKindSectionHeaderID];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:UICollectionElementKindSectionFooterID];
    
    CDCollectionViewFlowLayout *collectionViewFlowLayout = (CDCollectionViewFlowLayout *)collectionViewLayout;
    // 设置header或footer的size, 如不设置默认是CGSizeZero
    CGSize size = section == 0 ? CGSizeZero : CGSizeMake(DefineScreenWidth, 35.0);
    collectionViewFlowLayout.headerReferenceSize = size;
    collectionViewFlowLayout.footerReferenceSize = CGSizeZero;  //  不需要显示footer
    
    return size;
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        reusableView = [self retrunCollectionView:collectionView headerViewAtIndexPath:indexPath];
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        reusableView = [self retrunCollectionView:collectionView headerViewAtIndexPath:indexPath];
    } else {
        NSLog(@"other kind");
    }
    return reusableView;
}

//  Item   Cell    Method
- (UICollectionReusableView *)retrunCollectionView:(UICollectionView *)collectionView headerViewAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:UICollectionElementKindSectionHeaderID forIndexPath:indexPath];
    headerView.backgroundColor = [UIColor whiteColor];  //  设置header的背景颜色
    
    UILabel *label = [headerView viewWithTag:100];
    if (label == nil) {
        label = [[UILabel alloc] initWithFrame:headerView.bounds];
        label.tag = 100;
        label.textColor = [UIColor darkGrayColor];
        label.font = [UIFont systemFontOfSize:14.0];
        [headerView addSubview:label];
    }
    label.text = [NSString stringWithFormat:@"  我是section%zi的头信息",[indexPath section]];

    return  headerView;
}

- (UICollectionReusableView *)retrunCollectionView:(UICollectionView *)collectionView footerViewAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:UICollectionElementKindSectionFooterID forIndexPath:indexPath];
    
    return  footerView;
}

#pragma mark  Item Size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (DefineScreenWidth - 1.0*3)/4.0;
    CGSize size = CGSizeMake(width, width);
    
    return size;
}

#pragma mark  Item Number  And  Section Number
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_dataList[section] count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return CollectionViewSectionNumber;
}

#pragma mark  Item  Spacing
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

@end
