//
//  HttpToolManager.h
//  SunnyPrj
//
//  Created by Pac on 16/3/6.
//  Copyright © 2016年 Pactera. All rights reserved.
//

#import "AFNetworking.h"

//请求方法define
typedef enum {
    kGET,
    kPOST
} HTTPMethod;

typedef NS_ENUM(NSUInteger, BcRequestCenterCachePolicy) {
    
    /**
     *  普通网络请求,不会有缓存
     */
    BcRequestCenterCachePolicyNormal,
    
    /**
     *  优先读取本地，不管有没有网络，优先读取本地
     */
    BcRequestCenterCachePolicyCacheAndLocal
};

typedef void(^RequestFinishedBlock)(id result, NSError *error);


@interface HttpToolManager : AFHTTPSessionManager



+ (instancetype)sharedManager;

- (void)requestWithMethod:(HTTPMethod)method URLString:(NSString *)URLString parameters:(id)patameters Upload:(BOOL)upload option:(BcRequestCenterCachePolicy)option finished:(RequestFinishedBlock)finishedBlock;

@end
