//
//  ImageModel.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/18.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ImageModel : JSONModel
/*
 "id": 11,
 "title": null,
 "url": "https://ymzx.asia-cloud.com/uploads/images/2017/0718/20170718134624967.jpg",
 "description": ""
 */
@property(nonatomic,copy)NSString <Optional>* id;
@property(nonatomic,copy)NSString <Optional>* title;
@property(nonatomic,copy)NSString <Optional>* url;
@end
