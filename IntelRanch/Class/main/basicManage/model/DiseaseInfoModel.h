//
//  DiseaseInfoModel.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/21.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface DiseaseInfoModel : JSONModel
/*
 "id": 19,
 "site_id": 1,
 "category_id": 2,
 "pasture_id": 4,
 "jblx": "",
 "fsl": 0,
 "fssj": "2017-10-10 00:00:00",
 "dnqttl": 0,
 "jcchl": 0,
 "zylzb": 0,
 "tszytsbfb": "",
 "images": "",
 "videos": "",
 "member_id": 7,
 "user_id": 0,
 "sort": 0,
 "state": 1,
 "created_at": "2017-07-21 16:28:36",
 "updated_at": "2017-07-21 16:28:36",
 "deleted_at": null
 */
@property(nonatomic,copy)NSString <Optional>* id;
@property(nonatomic,copy)NSString <Optional>* site_id;
@property(nonatomic,copy)NSString <Optional>* category_id;
@property(nonatomic,copy)NSString <Optional>* pasture_id;
@property(nonatomic,copy)NSString <Optional>* jblx;
@property(nonatomic,copy)NSString <Optional>* fsl;
@property(nonatomic,copy)NSString <Optional>* fssj;
@property(nonatomic,copy)NSString <Optional>* dnqttl;
@property(nonatomic,copy)NSString <Optional>* jcchl;
@property(nonatomic,copy)NSString <Optional>* zylzb;
@property(nonatomic,copy)NSString <Optional>* tszytsbfb;
@property(nonatomic,copy)NSString <Optional>* images;
@property(nonatomic,copy)NSString <Optional>* videos;
@property(nonatomic,copy)NSString <Optional>* member_id;
@property(nonatomic,copy)NSString <Optional>* user_id;
@property(nonatomic,copy)NSString <Optional>* sort;
@property(nonatomic,copy)NSString <Optional>* state;
@property(nonatomic,copy)NSString <Optional>* created_at;
@property(nonatomic,copy)NSString <Optional>* updated_at;
@property(nonatomic,copy)NSString <Optional>* deleted_at;
@end
