//
//  GradeTableCell.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/21.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LayoutInfoModel.h"
@interface GradeTableCell : UITableViewCell
+(GradeTableCell *)setTableViewCustomCell:(UITableView*)tableView IndexPath:(NSIndexPath*)indexPath;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property(nonatomic,copy)NSString * descriptString;

@property(nonatomic,strong)LayoutInfoModel * model;

@property(nonatomic,copy)void (^SelectRowBlock)();

@end
