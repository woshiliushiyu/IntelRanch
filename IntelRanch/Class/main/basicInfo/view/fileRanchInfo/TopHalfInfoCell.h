//
//  TopHalfInfoCell.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/7.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LayoutInfoModel.h"
@interface TopHalfInfoCell : UITableViewCell
@property(nonatomic,strong)LayoutInfoModel * model;
@property(nonatomic,strong)NSIndexPath * indexPath;
@property(nonatomic,strong)NSDictionary * dataDict;

@property(nonatomic,strong)UITextField * nameText;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UIButton * nameBtn;

@property(nonatomic,copy)void (^FinishedBlock)(NSString * finishString,NSInteger index);
@end
