//
//  SicknessModel.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/25.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SicknessModel : JSONModel
/*
 "sickness_log_id": 20,
 "id": 3,
 "code": "0",
 "type": 5,
 "value1": "",
 "value2": "",
 "member_id": 0,
 "sort": 1500972963,
 "score": 0
 */
@property(nonatomic,copy)NSString <Optional>* sickness_log_id;
@property(nonatomic,copy)NSString <Optional>* id;
@property(nonatomic,copy)NSString <Optional>* code;
@property(nonatomic,copy)NSString <Optional>* type;
@property(nonatomic,copy)NSString <Optional>* member_id;
@property(nonatomic,copy)NSString <Optional>* score;
@property(nonatomic,copy)NSString <Optional>* value1;
@property(nonatomic,copy)NSString <Optional>* value2;
@end
