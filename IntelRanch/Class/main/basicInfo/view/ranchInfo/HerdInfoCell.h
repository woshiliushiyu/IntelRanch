//
//  HerdInfoCell.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/5.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HerdInfoCell : UITableViewCell
@property(nonatomic,copy)void (^SelectSetBlock)();
@end
