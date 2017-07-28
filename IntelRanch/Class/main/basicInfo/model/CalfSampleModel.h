//
//  CalfSampleModel.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/17.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CalfSampleModel : JSONModel
/*
 bust = 35;
 days = "5.0000";
 height = 70;
 italic = 40;
 weight = 20;
 */
@property(nonatomic,copy)NSString <Optional>* bust;
@property(nonatomic,copy)NSString <Optional>* days;
@property(nonatomic,copy)NSString <Optional>* height;
@property(nonatomic,copy)NSString <Optional>* italic;
@property(nonatomic,copy)NSString <Optional>* weight;
@end
