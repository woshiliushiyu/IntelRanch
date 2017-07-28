//
//  CommentInfoModel.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/19.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CommentInfoModel : JSONModel
/*
 "id": 2,
 "summary": "1234",
 "member_id": 0,
 "member_name": "",
 "member_avatar_url": "",
 "user_id": 2,
 "user_name": " 刘锰",
 "user_avatar_url": ""
 */
@property(nonatomic,copy)NSString <Optional>* id;
@property(nonatomic,copy)NSString <Optional>* summary;
@property(nonatomic,copy)NSString <Optional>* member_id;
@property(nonatomic,copy)NSString <Optional>* member_name;
@property(nonatomic,copy)NSString <Optional>* member_avatar_url;
@property(nonatomic,copy)NSString <Optional>* user_id;
@property(nonatomic,copy)NSString <Optional>* user_name;
@property(nonatomic,copy)NSString <Optional>* user_avatar_url;
@end
