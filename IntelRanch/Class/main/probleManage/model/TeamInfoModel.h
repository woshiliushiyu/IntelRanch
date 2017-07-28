//
//  TeamInfoModel.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/19.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface TeamInfoModel : JSONModel
@property(nonatomic,copy)NSString <Optional>* id;
@property(nonatomic,copy)NSString <Optional>* name;
@property(nonatomic,copy)NSString <Optional>* summary;
@property(nonatomic,copy)NSString <Optional>* avatar_url;
@end
