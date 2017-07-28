//
//  CommoneUseCell.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/25.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommoneUseCell : UITableViewCell

+(CommoneUseCell*)setTableView:(UITableView*)tableView IndexPath:(NSIndexPath*)index;


@property (strong, nonatomic) IBOutlet UIView *topView;

@property(nonatomic,copy)NSString * timeString;

@property (strong, nonatomic) IBOutlet UILabel *yearLabel;
@property (strong, nonatomic) IBOutlet UILabel *dayLabel;
@property (strong, nonatomic) IBOutlet UILabel *mmLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@end
