//
//  TableViewModel.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/6.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "TableViewModel.h"

@implementation TableViewModel
-(instancetype)initWithAge:(NSString *)age Weight:(NSString *)weight Heights:(NSString *)height Length:(NSString *)lenght Chest:(NSString *)chest
{
    if (self = [super init]) {
        
        _age = age;
        _weight = weight;
        _height = height;
        _length = lenght;
        _chest = chest;
    }
    return self;
}
@end
