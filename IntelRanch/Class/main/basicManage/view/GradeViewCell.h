//
//  GradeViewCell.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/13.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GradeViewCell : UITableViewCell
+(GradeViewCell *)setTableViewCustomCell:(UITableView*)tableView IndexPath:(NSIndexPath*)indexPath;
@property(nonatomic,copy)void (^SelectRowBlock)(NSInteger num);
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property(nonatomic,copy)NSString * type;

@property(nonatomic,strong)NSMutableArray * descriptArray;

@end
