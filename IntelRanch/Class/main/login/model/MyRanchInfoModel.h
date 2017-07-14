//
//  MyRanchInfoModel.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/14.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MyRanchInfoModel : JSONModel
/*
 address = "";
 area = 0;
 bns = 0;
 brdns = 0;
 brdnsjz = "";
 "built_at" = "<null>";
 "category_id" = 1;
 "created_at" = "2017-07-14 14:34:10";
 dndns = 0;
 dzdnsjz = "";
 gnwcns = 0;
 id = 6;
 images = "";
 "member_id" = 7;
 name = "\U5218\U4e16\U7389\U7267\U573a";
 nqpz = "";
 nrns = 0;
 qt = 0;
 "site_id" = 1;
 sort = 0;
 state = 1;
 "updated_at" = "2017-07-14 14:34:10";
 "user_id" = 0;
 videos = "";
 wpdycns = 0;
 xycns = 0;
 ypdycns = 0;
 zts = 0;
 */
@property(nonatomic,copy)NSString <Optional>* address;
@property(nonatomic,copy)NSString <Optional>* area;
@property(nonatomic,copy)NSString <Optional>* bns;
@property(nonatomic,copy)NSString <Optional>* brdns;
@property(nonatomic,copy)NSString <Optional>* brdnsjz;
@property(nonatomic,copy)NSString <Optional>* built_at;
@property(nonatomic,copy)NSString <Optional>* created_at;
@property(nonatomic,copy)NSString <Optional>* category_id;
@property(nonatomic,copy)NSString <Optional>* dndns;
@property(nonatomic,copy)NSString <Optional>* dzdnsjz;
@property(nonatomic,copy)NSString <Optional>* gnwcns;
@property(nonatomic,copy)NSString <Optional>* id;
@property(nonatomic,copy)NSString <Optional>* images;
@property(nonatomic,copy)NSString <Optional>* member_id;
@property(nonatomic,copy)NSString <Optional>* name;
@property(nonatomic,copy)NSString <Optional>* nqpz;
@property(nonatomic,copy)NSString <Optional>* nrns;
@property(nonatomic,copy)NSString <Optional>* qt;
@property(nonatomic,copy)NSString <Optional>* site_id;
@property(nonatomic,copy)NSString <Optional>* sort;
@property(nonatomic,copy)NSString <Optional>* state;
@property(nonatomic,copy)NSString <Optional>* updated_at;
@property(nonatomic,copy)NSString <Optional>* user_id;
@property(nonatomic,copy)NSString <Optional>* videos;
@property(nonatomic,copy)NSString <Optional>* wpdycns;
@property(nonatomic,copy)NSString <Optional>* xycns;
@property(nonatomic,copy)NSString <Optional>* ypdycns;
@property(nonatomic,copy)NSString <Optional>* zts;

@end
