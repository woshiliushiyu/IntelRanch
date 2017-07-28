//
//  LoginInfoModel.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/11.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface LoginInfoModel : JSONModel
@property(nonatomic,copy)NSNumber <Optional>* id;
@property(nonatomic,copy)NSString <Optional>* name;
@property(nonatomic,copy)NSString <Optional>* password;
@property(nonatomic,copy)NSString <Optional>* nick_name;
@property(nonatomic,copy)NSString <Optional>* mobile;
@property(nonatomic,copy)NSString <Optional>* avatar_url;
@property(nonatomic,copy)NSString <Optional>* salt;
@property(nonatomic,copy)NSString <Optional>* points;
@property(nonatomic,copy)NSString <Optional>* ip;
@property(nonatomic,copy)NSString <Optional>* token;
@property(nonatomic,copy)NSString <Optional>* type;
@property(nonatomic,copy)NSString <Optional>* source;
@property(nonatomic,copy)NSString <Optional>* uid;
@property(nonatomic,copy)NSString <Optional>* state;
@property(nonatomic,copy)NSString <Optional>* signed_at;
@property(nonatomic,copy)NSString <Optional>* logined_at;
@property(nonatomic,copy)NSString <Optional>* created_at;
@property(nonatomic,copy)NSString <Optional>* updated_at;

+(void)saveLoginInfo:(id)model;

+(LoginInfoModel*)getLoginInfoModel;

+(void)clearnLoginInfo;

+(BOOL)isLogin;
@end
