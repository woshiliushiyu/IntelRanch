//
//  CalfManagerModel.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/20.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CalfManagerModel : JSONModel
/*
 "id": 3,
 "site_id": 1,
 "category_id": 2,
 "pasture_id": 4,
 "bmgzff": "擦干",
 "qdxd": "否",
 "xdy": "其他",
 "xdcs": "3",
 "cz": "是",
 "qjsj": null,
 "qjff": "",
 "qfrsj": null,
 "qfrff": "",
 "dcghpl": "",
 "dchd": "",
 "xdff": "",
 "yjmcqx": "",
 "qhxd": "",
 "gjcd": "",
 "nslx": "",
 "sfsf": "",
 "fz": "",
 "tffs": "",
 "clsj": null,
 "snwd": "",
 "snsd": "",
 "swwd": "",
 "swsd": "",
 "lryj": "",
 "mkcd": "",
 "ckcd": "",
 "dqwd": "",
 "dqnd": "",
 "zzw": "",
 "snj": "",
 "gjssb": "",
 "qtcs": "",
 "images": "",
 "videos": "",
 "member_id": 7,
 "user_id": 0,
 "sort": 0,
 "state": 1,
 "created_at": "2017-07-20 16:20:50",
 "updated_at": "2017-07-20 16:20:50"
 */
@property(nonatomic,copy)NSString <Optional>* id;
@property(nonatomic,copy)NSString <Optional>* site_id;
@property(nonatomic,copy)NSString <Optional>* category_id;
@property(nonatomic,copy)NSString <Optional>* pasture_id;
@property(nonatomic,copy)NSString <Optional>* bmgzff;
@property(nonatomic,copy)NSString <Optional>* qdxd;
@property(nonatomic,copy)NSString <Optional>* xdy ;
@property(nonatomic,copy)NSString <Optional>* xdcs ;
@property(nonatomic,copy)NSString <Optional>* cz ;
@property(nonatomic,copy)NSString <Optional>* qjsj ;
@property(nonatomic,copy)NSString <Optional>* qjff ;
@property(nonatomic,copy)NSString <Optional>* qfrsj ;
@property(nonatomic,copy)NSString <Optional>* qfrff ;
@property(nonatomic,copy)NSString <Optional>* dcghpl ;
@property(nonatomic,copy)NSString <Optional>* dchd ;
@property(nonatomic,copy)NSString <Optional>* xdff ;
@property(nonatomic,copy)NSString <Optional>* yjmcqx ;
@property(nonatomic,copy)NSString <Optional>* qhxd ;
@property(nonatomic,copy)NSString <Optional>* gjcd ;
@property(nonatomic,copy)NSString <Optional>* nslx ;
@property(nonatomic,copy)NSString <Optional>* sfsf ;
@property(nonatomic,copy)NSString <Optional>* fz ;
@property(nonatomic,copy)NSString <Optional>* tffs ;
@property(nonatomic,copy)NSString <Optional>* clsj ;
@property(nonatomic,copy)NSString <Optional>* snwd ;
@property(nonatomic,copy)NSString <Optional>* snsd ;
@property(nonatomic,copy)NSString <Optional>* swwd ;
@property(nonatomic,copy)NSString <Optional>* swsd ;
@property(nonatomic,copy)NSString <Optional>* lryj ;
@property(nonatomic,copy)NSString <Optional>* mkcd ;
@property(nonatomic,copy)NSString <Optional>* ckcd ;
@property(nonatomic,copy)NSString <Optional>* dqwd ;
@property(nonatomic,copy)NSString <Optional>* dqnd ;
@property(nonatomic,copy)NSString <Optional>* zzw ;
@property(nonatomic,copy)NSString <Optional>* snj ;
@property(nonatomic,copy)NSString <Optional>* gjssb ;
@property(nonatomic,copy)NSString <Optional>* qtcs ;
@property(nonatomic,copy)NSString <Optional>* images ;
@property(nonatomic,copy)NSString <Optional>* videos ;
@property(nonatomic,copy)NSString <Optional>* member_id ;
@property(nonatomic,copy)NSString <Optional>* user_id ;
@property(nonatomic,copy)NSString <Optional>* sort ;
@property(nonatomic,copy)NSString <Optional>* state ;
@property(nonatomic,copy)NSString <Optional>* created_at ;
@property(nonatomic,copy)NSString <Optional>* updated_at;

@end
