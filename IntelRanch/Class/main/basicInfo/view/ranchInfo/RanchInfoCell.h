//
//  RanchInfoCell.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/5.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LayoutModel.h"
@interface RanchInfoCell : UITableViewCell
@property(nonatomic,copy)void (^SelectRanchInfoBlock)();
@property(nonatomic,strong)LayoutModel * infoModel;
@property (strong, nonatomic) IBOutlet UILabel *headerLabel;

@property(nonatomic,strong)NSDictionary * dataDict;

@end
