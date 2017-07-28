//
//  BottomHalfInfoCell.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/7.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LayoutInfoModel.h"
@interface BottomHalfInfoCell : UITableViewCell
@property(nonatomic,strong)LayoutInfoModel * model;
@property(nonatomic)NSInteger  index;

@property(nonatomic,assign)BOOL isFold;
@property(nonatomic,strong)NSDictionary * dataDict;

@property(nonatomic,copy)void (^FinishedBlock)(NSMutableArray * finishArray,NSInteger index);

@end
