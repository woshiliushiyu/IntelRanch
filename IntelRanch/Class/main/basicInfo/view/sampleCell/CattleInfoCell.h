//
//  CattleInfoCell.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/8.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CattleInfoCell : UITableViewCell
@property(nonatomic,copy)void (^ReloadDataBlcok)(NSUInteger index);
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property(nonatomic,assign)NSUInteger index;

@end
