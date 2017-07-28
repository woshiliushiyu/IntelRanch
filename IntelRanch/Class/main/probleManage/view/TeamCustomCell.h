//
//  TeamCustomCell.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/19.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamCustomCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *iconView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *describeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *selectImg;

@property (strong, nonatomic) IBOutlet UIView *bgView;
@end
