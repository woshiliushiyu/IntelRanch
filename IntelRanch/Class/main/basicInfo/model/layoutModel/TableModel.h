//
//  TableModel.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/11.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface TableModel : JSONModel
@property(nonatomic,copy)NSString <Optional>* show;
@property(nonatomic,copy)NSString <Optional>* align;
@property(nonatomic,copy)NSString <Optional>* width;
@property(nonatomic,copy)NSString <Optional>* formatter;
@property(nonatomic,copy)NSString <Optional>* editable;
@end
