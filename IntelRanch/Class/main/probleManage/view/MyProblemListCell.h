//
//  MyProblemListCell.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/19.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyProblemListCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *statuLabel;
@property (strong, nonatomic) IBOutlet UITextView *descriptionText;

@property (strong, nonatomic) IBOutlet UIView *bgView;

@end
