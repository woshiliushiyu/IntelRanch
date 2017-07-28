//
//  GradeController.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/21.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GradeController : UIViewController
@property(nonatomic,copy)NSString * idString;
@property(nonatomic,copy)NSString * typeString;
@property(nonatomic,strong)NSArray * images;
@property(nonatomic,strong)NSArray * subTitles;
@property(nonatomic,strong)NSArray * titles;
@end
