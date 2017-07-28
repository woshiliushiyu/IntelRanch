//
//  TeamControllerTableViewController.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/19.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamControllerTableViewController : UITableViewController
@property(nonatomic,copy)void (^SelectRowsBlock)(NSString * teamId,NSString * name);
@end
