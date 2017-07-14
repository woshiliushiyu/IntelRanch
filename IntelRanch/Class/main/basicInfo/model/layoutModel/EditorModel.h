//
//  EditorModel.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/11.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface EditorModel : JSONModel
@property(nonatomic,copy)NSString <Optional>* index;
@property(nonatomic,copy)NSString <Optional>* show;
@property(nonatomic,copy)NSString <Optional>* type;
@property(nonatomic,strong)NSArray <Optional>* options;
@property(nonatomic,copy)NSString <Optional>* rows;
@property(nonatomic,copy)NSString <Optional>* columns;
@property(nonatomic,copy)NSString <Optional>* group;
@property(nonatomic,copy)NSString <Optional>* required;
@end
