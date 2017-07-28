//
//  CattleInfoController.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/7.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LayoutInfoModel.h"
@interface CattleInfoController : UIViewController
@property(nonatomic,strong)NSMutableArray <LayoutInfoModel*> * dataArray;

@property(nonatomic,strong)NSDictionary * dataDict;
@end
