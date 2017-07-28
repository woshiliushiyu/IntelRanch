//
//  FeedInfoModel.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/21.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface FeedInfoModel : JSONModel
/*
 "id": 3,
 "site_id": 1,
 "category_id": 2,
 "pasture_id": 4,
 "ymnfksj": "1小时内分开",
 "scwrsj": "1小时内饲喂",
 "scwrsl": "3-4L",
 "crswts": "2天",
 "crly": "新鲜初乳",
 "crbs": "否",
 "crlx": "抗奶",
 "sfxd": "",
 "crswl": "",
 "crjdfs": "直接加热",
 "crwd": "45",
 "swfs": "饮用",
 "swcs": "",
 "kslcp": "",
 "dnljg": "",
 "ksswsj": "",
 "fksw": "",
 "swgcsj": "",
 "gclx": "",
 "sfqd": "",
 "fxclpz": "",
 "csdd": "",
 "csff": "",
 "ksyssj": "",
 "ysfs": "",
 "snswjg": "",
 "dnbz": "",
 "dntz": "",
 "csl": "",
 "dnszq": "",
 "scsl": "",
 "sczcd": "",
 "nts": "",
 "scrj": "",
 "sclx": "",
 "scjrfs": "",
 "sysfzg": "",
 "ssfgj": "",
 "scqj": "",
 "scxd": "",
 "rdjc": "",
 "jdcrpz": "否",
 "yqjc": "",
 "zdbjc": "",
 "jcsj": "",
 "images": "",
 "videos": "",
 "member_id": 7,
 "user_id": 0,
 "sort": 0,
 "state": 1,
 "created_at": "2017-07-21 15:46:49",
 "updated_at": "2017-07-21 15:46:49",
 "deleted_at": null
 */
@property(nonatomic,copy)NSString <Optional>* id;
@property(nonatomic,copy)NSString <Optional>* site_id;
@property(nonatomic,copy)NSString <Optional>* category_id;
@property(nonatomic,copy)NSString <Optional>* pasture_id;
@property(nonatomic,copy)NSString <Optional>* ymnfksj;
@property(nonatomic,copy)NSString <Optional>* scwrsj;
@property(nonatomic,copy)NSString <Optional>* scwrsl;
@property(nonatomic,copy)NSString <Optional>* crswts;
@property(nonatomic,copy)NSString <Optional>* crly;
@property(nonatomic,copy)NSString <Optional>* crbs;
@property(nonatomic,copy)NSString <Optional>* crlx;
@property(nonatomic,copy)NSString <Optional>* sfxd;
@property(nonatomic,copy)NSString <Optional>* crswl;
@property(nonatomic,copy)NSString <Optional>* crjdfs;
@property(nonatomic,copy)NSString <Optional>* crwd;
@property(nonatomic,copy)NSString <Optional>* swfs;
@property(nonatomic,copy)NSString <Optional>* swcs;
@property(nonatomic,copy)NSString <Optional>* kslcp;
@property(nonatomic,copy)NSString <Optional>* dnljg;
@property(nonatomic,copy)NSString <Optional>* ksswsj;
@property(nonatomic,copy)NSString <Optional>* fksw;
@property(nonatomic,copy)NSString <Optional>* swgcsj;
@property(nonatomic,copy)NSString <Optional>* gclx;
@property(nonatomic,copy)NSString <Optional>* sfqd;
@property(nonatomic,copy)NSString <Optional>* fxclpz;
@property(nonatomic,copy)NSString <Optional>* csdd;
@property(nonatomic,copy)NSString <Optional>* csff;
@property(nonatomic,copy)NSString <Optional>* ksyssj;
@property(nonatomic,copy)NSString <Optional>* ysfs;
@property(nonatomic,copy)NSString <Optional>* snswjg;
@property(nonatomic,copy)NSString <Optional>* dnbz;
@property(nonatomic,copy)NSString <Optional>* dntz;
@property(nonatomic,copy)NSString <Optional>* csl;
@property(nonatomic,copy)NSString <Optional>* dnszq;
@property(nonatomic,copy)NSString <Optional>* scsl;
@property(nonatomic,copy)NSString <Optional>* sczcd;
@property(nonatomic,copy)NSString <Optional>* nts;
@property(nonatomic,copy)NSString <Optional>* scrj;
@property(nonatomic,copy)NSString <Optional>* sclx;
@property(nonatomic,copy)NSString <Optional>* scjrfs;
@property(nonatomic,copy)NSString <Optional>* sysfzg;
@property(nonatomic,copy)NSString <Optional>* ssfgj;
@property(nonatomic,copy)NSString <Optional>* scqj;
@property(nonatomic,copy)NSString <Optional>* scxd;
@property(nonatomic,copy)NSString <Optional>* rdjc;
@property(nonatomic,copy)NSString <Optional>* jdcrpz;
@property(nonatomic,copy)NSString <Optional>* yqjc;
@property(nonatomic,copy)NSString <Optional>* zdbjc;
@property(nonatomic,copy)NSString <Optional>* jcsj;
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
