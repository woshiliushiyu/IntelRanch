//
//  LayoutInfoModel.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/11.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "TableModel.h"
#import "EditorModel.h"
@interface LayoutInfoModel : JSONModel
@property(nonatomic,copy)NSString <Optional>* name;
@property(nonatomic,copy)NSString <Optional>* title;
@property(nonatomic,copy)NSString <Optional>* type;
@property(nonatomic,copy)NSString <Optional>* length;
@property(nonatomic,copy)NSString <Optional>* system;
@property(nonatomic,strong)TableModel <Optional>* table;
@property(nonatomic,strong)EditorModel <Optional>* editor;
@end
