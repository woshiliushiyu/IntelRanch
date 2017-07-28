//
//  SampleCell.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/5.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalfSampleModel.h"
#import "AssessmentModel.h"
@interface SampleCell : UITableViewCell
@property(nonatomic,strong)CalfSampleModel * model;
@property(nonatomic,strong)AssessmentModel * assessModel;

@property(nonatomic,strong)NSMutableArray * assessArray;
@end
