//
//  CalfSampleCell.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/5.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalfSampleModel.h"
@interface CalfSampleCell : UITableViewCell
@property(nonatomic,strong)NSMutableArray * models;
@property(nonatomic,copy)void (^PushCalfSampleViewBlock)();
@end
