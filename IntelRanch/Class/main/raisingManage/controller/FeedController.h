//
//  FeedController.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/20.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedController : UITableViewController
@property(nonatomic,strong)NSMutableArray * layoutArray;
@property(nonatomic,copy)NSString * idString;

@property(nonatomic,assign)BOOL _isPush;
@end
