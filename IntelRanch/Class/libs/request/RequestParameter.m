//
//  RequestParameter.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/11.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "RequestParameter.h"

@implementation RequestParameter

NSString * const  mRegister = @"members/register";

NSString * const mCaptcha = @"members/mobile/captcha";

NSString * const mReset = @"members/password/reset";

NSString * const mLogin = @"members/login";

NSString * const Owns = @"pastures/owns";

NSString * const Layout = @"models/info";

NSString * const calfInfo = @"models/table";

NSString * const createRanch = @"pastures/create";

NSString * const modfiyInfo = @"pastures/modify";

NSString * const uploadMedia = @"files/upload";

NSString * const sampleAverge = @"samples/average";

NSString * const uploadCalfSample = @"samples/create";

NSString * const getRanchInfo = @"pastures/info";

NSString * const images = @"images";

NSString * const videos = @"videos";

NSString * const experts = @"questions/experts";

NSString * const create = @"questions/create";

NSString * const newborn = @"newborn/logs/modify";
@end
