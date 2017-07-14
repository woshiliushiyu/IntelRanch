//
//  LayoutModel.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/11.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "LayoutInfoModel.h"


@protocol LayoutInfoModel

@end

@interface LayoutModel : JSONModel
@property(nonatomic,copy)NSString <Optional>* name;
@property(nonatomic,copy)NSString <Optional>* title;
@property(nonatomic,strong)NSArray <LayoutInfoModel>* fields;
@end
