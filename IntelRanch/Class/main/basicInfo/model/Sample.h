//
//  Sample.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/8.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface Sample : JSONModel
@property(nonatomic,copy)NSString <Optional>* number;
@property(nonatomic,copy)NSString <Optional>* dayNumber;
@property(nonatomic,copy)NSString <Optional>* weight;
@property(nonatomic,copy)NSString <Optional>* stature;
@property(nonatomic,copy)NSString <Optional>* bodyLenght;
@property(nonatomic,copy)NSString <Optional>* bush;

-(instancetype)initWithNumber:(NSString*)number DayNumber:(NSString*)day Weight:(NSString*)weight Statyre:(NSString*)stature Body:(NSString*)body Bush:(NSString*)bush;
@end
