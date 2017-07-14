//
//  Sample.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/8.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "Sample.h"

@implementation Sample
-(instancetype)initWithNumber:(NSString*)number DayNumber:(NSString*)day Weight:(NSString*)weight Statyre:(NSString*)stature Body:(NSString*)body Bush:(NSString*)bush
{
    if (self = [super init]) {
        
        _number = number;
        _dayNumber = day;
        _weight = weight;
        _stature = stature;
        _bodyLenght = body;
        _bush = bush;
    }
    return self;
}
@end
