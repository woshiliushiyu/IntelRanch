//
//  AssessmentModel.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/21.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface AssessmentModel : JSONModel
@property(nonatomic,copy)NSString <Optional>* serial;
@property(nonatomic,copy)NSString <Optional>* smell;
@property(nonatomic,copy)NSString <Optional>* color;

- (instancetype)initWithSerial:(NSString*)serial Small:(NSString*)smell Color:(NSString*)color;
@end
