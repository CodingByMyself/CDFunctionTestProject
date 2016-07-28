//
//  CDTestCellLongPressViewController.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/28.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDTestCellLongPressViewController.h"

@interface CDTestCellLongPressViewController () <UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_table;
    NSMutableArray *_dataList;
}
@end

@implementation CDTestCellLongPressViewController

#pragma mark - LongPressGesture Method
- (void)longPressGestureRecognized:(UILongPressGestureRecognizer *)longPress
{
    UIGestureRecognizerState states = longPress.state; //长按状态
    CGPoint location = [longPress locationInView:_table];  //获取长按的位置
    NSIndexPath *indexPath = [_table indexPathForRowAtPoint:location]; //根据位置得到cell的索引位置
    
    static UIView *snapshot = nil; //创建一个截图
    static NSIndexPath *souceIndexPath = nil; //开始移动cell的indexPath
    switch (states) {
        case UIGestureRecognizerStateBegan: {  //刚开始按下的时候获取到当前位置的cell
            souceIndexPath = indexPath;
            UITableViewCell *cell = [_table cellForRowAtIndexPath:indexPath];
            snapshot = [self customSnapShottFromView:cell]; //得到一个截图View
            __block CGPoint center = cell.center;  //将得到的截图放到列表上
            snapshot.center = center;
            snapshot.alpha = 0.0;
            [_table addSubview:snapshot];
            //使用动画完成一个截图的拖拽效果
            [UIView animateWithDuration:0.15 animations:^{
                center.y = location.y;
                snapshot.center = center;
                snapshot.transform = CGAffineTransformMakeScale(0.98, 0.98); //将截图方法
                snapshot.alpha = 0.95; //将截图渐变
                cell.backgroundColor = [UIColor clearColor]; //设置背景颜色
            }];
        }
            break;
        case UIGestureRecognizerStateChanged: {
            //如果手势移动的距离对应带另外一个 index path 就需要告诉table View，让它移动rows，同时你需要对data source进行更新。
            CGPoint center = snapshot.center;
            center.y = location.y;
            snapshot.center = center;
            //判断是否移动初始化的cell，indexPath为当前选中的cell sourceIndexPath为“移动”的cell
            if (indexPath && ![indexPath isEqual:souceIndexPath] && [indexPath section] == [souceIndexPath section]) {
                // TODO交换数据，即使重新加载数据位置也不会还原，如果注释这一行 则reload之后数据位置会还原
                [_dataList exchangeObjectAtIndex:indexPath.row withObjectAtIndex:souceIndexPath.row];
                [_table moveRowAtIndexPath:souceIndexPath toIndexPath:indexPath]; //交换cell
                souceIndexPath = indexPath; //将indexPath最为移动的cell
            }
        }
            break;
        default: {
            //当手势结束或者取消的时候，table view 和 data source都是最新的，将snapshot View
            //从tableView中移除，并将tableViewcell的背景颜色还原
            UITableViewCell *cell = [_table cellForRowAtIndexPath:indexPath];
            [UIView animateWithDuration:0.15 animations:^{
                snapshot.center = cell.center;
                //还原成初始化的状态
                snapshot.transform = CGAffineTransformIdentity;
                snapshot.alpha = 0.0;
                cell.backgroundColor = [UIColor whiteColor];
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
        snapshotView.layer.borderColor = DefineColorRGB(180.0, 180.0, 180.0, 0.6).CGColor;
        snapshotView.layer.borderWidth = 0.5;
        snapshotView.layer.shadowColor = DefineColorRGB(180.0, 180.0, 180.0, 1.0).CGColor;
        snapshotView.layer.shadowOffset = CGSizeMake(0.0,0.0);
        snapshotView.layer.shadowOpacity = 1.0f;
        snapshotView.layer.shadowRadius = 1.5;
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
        snapshotView.layer.shadowOffset = CGSizeMake(0.0,0.0);
        snapshotView.layer.shadowOpacity = 1.0f;
        snapshotView.layer.shadowRadius = 1.5;
    }
    return snapshotView;
}

#pragma mark - view
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"长按拖动";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataList = [[NSMutableArray alloc] init];
    for (NSInteger i = 0 ;i < 20; i ++) {
        [_dataList addObject:[NSString stringWithFormat:@" %zi、 长按一下试试 (%zi)", (i + 1),(i + 1)]];
    }
    
    _table = [[UITableView alloc] initWithFrame:self.view.bounds];
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    [_table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGestureRecognized:)];
    longPress.minimumPressDuration = 0.3;
    [_table addGestureRecognizer:longPress];
  
    //  刷新按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Reload" style:UIBarButtonItemStyleDone target:_table action:@selector(reloadData)];
}

#pragma mark - UI Table View Data And Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellID"];
    }
    
    cell.textLabel.text = _dataList[[indexPath row]];
    cell.textLabel.font = DefineFontLaoSangamMN(FontBaseSize + 2.0);
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"section = %zi , row = %zi",[indexPath section],[indexPath row]);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataList count];
}

@end
