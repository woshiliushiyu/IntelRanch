//
//  CommProblemCell.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/25.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommProblemCell : UITableViewCell

+(CommProblemCell*)setTableView:(UITableView*)tableView IndexPath:(NSIndexPath*)index;

@property (strong, nonatomic) IBOutlet UILabel *namelabel;
@property (strong, nonatomic) IBOutlet UIButton *selectBtn;

@property (strong, nonatomic) IBOutlet UIButton *nomalBtn;
@property (strong, nonatomic) IBOutlet UITextView *descriptlabel;
@end
