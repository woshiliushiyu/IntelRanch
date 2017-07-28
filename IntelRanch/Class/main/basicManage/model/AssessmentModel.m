//
//  AssessmentModel.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/21.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "AssessmentModel.h"

@implementation AssessmentModel
- (instancetype)initWithSerial:(NSString*)serial Small:(NSString*)smell Color:(NSString*)color
{
    self = [super init];
    if (self) {
        self.serial = serial;
        self.smell = smell;
        self.color = color;
    }
    return self;
}
@end
