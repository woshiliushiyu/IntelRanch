//
//  MyProblemController.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/19.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyProblemController : UITableViewController
@property(nonatomic,copy)void (^SelectRowsBlock)(NSArray * dataArray);
@end
