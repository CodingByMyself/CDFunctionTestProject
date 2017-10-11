//
//  CDTestPreviewDocumentVC.m
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/4/13.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import "CDTestPreviewDocumentVC.h"
#import "RECDPreviewDocumentManager.h"

@interface CDTestPreviewDocumentVC () <UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableViewDocList;
@property (nonatomic,strong) NSArray *documentNames;

@property (nonatomic,strong) RECDPreviewDocumentManager *previewManager;

@end



@implementation CDTestPreviewDocumentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"浏览";
    
    MTDetailLog(@"%@",DEFINE_LOCATION_DOCUMENT_ROOT_PATH);
    
    NSArray *urlList = [[NSBundle mainBundle] URLsForResourcesWithExtension:@"pdf" subdirectory:nil];
    self.documentNames = [NSArray arrayWithArray:urlList];
//    [self findLocationCacheFiles];
    
    
    
    self.tableViewDocList.delegate = self;
    self.tableViewDocList.dataSource = self;
}

- (void)findLocationCacheFiles
{
    NSString *cachePath = [DEFINE_LOCATION_DOCUMENT_ROOT_PATH stringByAppendingPathComponent:@"document_cache_file"];
    
    NSArray * tempFileList = [[NSArray alloc] initWithArray:[[NSFileManager defaultManager] contentsOfDirectoryAtPath:cachePath error:nil]];
    
    NSMutableArray *docs = [[NSMutableArray alloc] init];
    for (NSString *fileName in tempFileList) {
        MTLog(@"%@",fileName);
        if (fileName.length > 0) {
            [docs addObject:fileName];
        }
    }
    
    self.documentNames = [NSArray arrayWithArray:docs];
}

#pragma mark - TableView Delegate Method
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellFileListID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellFileListID"];
    }
    
    
    cell.textLabel.text = [self.documentNames[indexPath.row] lastPathComponent];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"%zi  -  %zi",[indexPath section] , [indexPath row]);
    
    NSURL *URL;
    if ([self.documentNames[indexPath.row] isKindOfClass:[NSURL class]]) {
        URL = self.documentNames[indexPath.row];
        
    } else {
        NSString *cachePath = [DEFINE_LOCATION_DOCUMENT_ROOT_PATH stringByAppendingPathComponent:@"document_cache_file"];
        
        NSString *path = [cachePath stringByAppendingPathComponent:self.documentNames[indexPath.row]];
        
        URL = [NSURL fileURLWithPath:path];
    }
    
    
    [self.previewManager setDocumentURL:URL];
    
    [self.previewManager startPreviewDocument];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.documentNames.count;
}


#pragma mark - Getter Method
- (UITableView *)tableViewDocList
{
    if (_tableViewDocList == nil) {
        _tableViewDocList = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        
        _tableViewDocList.sectionFooterHeight = 0;
        _tableViewDocList.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 0.1f)];
        _tableViewDocList.tableFooterView = [UIView new];
        
        _tableViewDocList.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_tableViewDocList setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        [self.view addSubview:_tableViewDocList];
        [_tableViewDocList mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(CDNavigationBarHeight);
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }];
        
    }
    return _tableViewDocList;
}

- (RECDPreviewDocumentManager *)previewManager
{
    if (_previewManager == nil) {
        _previewManager = [[RECDPreviewDocumentManager alloc] initWithPreviewController:self];
    }
    return _previewManager;
}

@end
