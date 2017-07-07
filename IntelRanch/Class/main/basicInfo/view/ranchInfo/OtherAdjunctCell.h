//
//  OtherAdjunctCell.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/5.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherAdjunctCell : UITableViewCell
@property(nonatomic,strong)NSMutableArray * imgs;
@property(nonatomic,assign)CGFloat cellHeight;
@property(nonatomic,copy)void (^TouchAddBlock)();
@end
