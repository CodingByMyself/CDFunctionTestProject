//
//  CDBaseTableViewCell+CDGroupCellCategory.h
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/7.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDBaseTableViewCell.h"

@interface CDBaseTableViewCell (CDGroupCellCategory)


#pragma mark  update  group  and  corner radius
- (void)updateLayoutAndLayerWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
