//
//  MyProblemModel.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/19.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "CommentInfoModel.h"

@protocol CommentInfoModel

@end

@interface MyProblemModel : JSONModel
/*
 "id": 6,
 "site_id": 1,
 "category_id": 5,
 "pasture_id": 4,
 "type": 1,
 "summary": "我的牛老是喝酒怎么办?",
 "images": "",
 "videos": "",
 "member_id": 7,
 "user_id": 1,
 "sort": 0,
 "state": 0,
 "created_at": "2017-07-19 15:41:13",
 "updated_at": "2017-07-19 15:41:13"
 */
@property(nonatomic,copy)NSString <Optional>* id;
@property(nonatomic,copy)NSString <Optional>* site_id;
@property(nonatomic,copy)NSString <Optional>* category_id;
@property(nonatomic,copy)NSString <Optional>* pasture_id;
@property(nonatomic,copy)NSString <Optional>* type;
@property(nonatomic,copy)NSString <Optional>* summary;
@property(nonatomic,copy)NSString <Optional>* images;
@property(nonatomic,copy)NSString <Optional>* videos;
@property(nonatomic,copy)NSString <Optional>* member_id;
@property(nonatomic,copy)NSString <Optional>* user_id;
@property(nonatomic,copy)NSString <Optional>* sort;
@property(nonatomic,copy)NSString <Optional>* state;
@property(nonatomic,strong)NSArray <CommentInfoModel>* comments;
@property(nonatomic,copy)NSString <Optional>* created_at;
@property(nonatomic,copy)NSString <Optional>* updated_at;
@end
