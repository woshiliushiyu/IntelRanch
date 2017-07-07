//
//  TableViewModel.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/6.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface TableViewModel : JSONModel
@property(nonatomic,copy)NSString <Optional>* age;
@property(nonatomic,copy)NSString <Optional>* weight;
@property(nonatomic,copy)NSString <Optional>* height;
@property(nonatomic,copy)NSString <Optional>* length;
@property(nonatomic,copy)NSString <Optional>* chest;

-(instancetype)initWithAge:(NSString*)age Weight:(NSString*)weight Heights:(NSString*)height Length:(NSString*)lenght Chest:(NSString*)chest;
@end
