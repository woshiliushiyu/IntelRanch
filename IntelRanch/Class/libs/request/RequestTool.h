//
//  RequestTool.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/10.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpToolManager.h"

// .h
#define singleton_interface(class) + (instancetype)shared##class;

// .m
#define singleton_implementation(class) \
static class *_instance; \
\
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
\
return _instance; \
} \
\
+ (instancetype)shared##class \
{ \
if (_instance == nil) { \
_instance = [[class alloc] init]; \
} \
\
return _instance; \
}


@interface RequestTool : NSObject
singleton_interface(RequestTool);

/**
 注册请求

 @param phoneNumber 手机号
 @param password 密码
 @param captcha 验证码
 @param finishedBlock 回调
 */
-(void)requestWithRegisterForPhoneNumber:(NSString*)phoneNumber Password:(NSString*)password Captcha:(NSString*)captcha FinishedBlock:(RequestFinishedBlock)finishedBlock;

/**
 请求验证码

 @param mobile 手机号
 @param type 类型(0:找回密码,1:注册,2:重置密码,3:绑定手机,4:解除绑定手机,5:登录验证)
 @param finishedBlock 回调
 */
-(void)requestWithCaptchaForPhoneNumber:(NSString*)mobile Type:(NSString*)type FinishedBlock:(RequestFinishedBlock)finishedBlock;

/**
 忘记 修改密码接口

 @param mobile 手机号
 @param captcha 验证码
 @param newPassword 新密码
 @param finishedBlock 回调
 */
-(void)requestWithForgetPasswordMobile:(NSString*)mobile Captcha:(NSString*)captcha Password:(NSString*)newPassword FinishedBlock:(RequestFinishedBlock)finishedBlock;

/**
 登录请求

 @param mobile 手机号
 @param password 密码
 @param finishedBlock 回调
 */
-(void)requestWithLoginPhoneNumber:(NSString*)mobile Password:(NSString*)password FinishedBlock:(RequestFinishedBlock)finishedBlock;

/**
 获取我的牧场接口

 @param finishedBlock 回调
 */
-(void)requestWithPasturesForOwnsFinishedBlock:(RequestFinishedBlock)finishedBlock;

/**
 牧场基本信息界面布局

 @param finishedBlock 回调
 */
-(void)requestWithRanchBasicLayoutFinishedBlock:(RequestFinishedBlock)finishedBlock;

/**
 获取牧场基本信息

 @param finishedBlock 回调
 */
-(void)requestWithRanchBasicInfoFinishedBlock:(RequestFinishedBlock)finishedBlock;

/**
 创建牧场

 @param finishedBlock 回调
 */
-(void)requestWithCreateRanchName:(NSString *)name Address:(NSString*)address Time:(NSString*)time Area:(NSString*)area FinishedBlock:(RequestFinishedBlock)finishedBlock;

/**
 修改牧场信息

 @param body 牧场参数
 @param finishedBlock 回调
 */
-(void)requestWithRanchInfoToServer:(NSDictionary *)body FinishedBlock:(RequestFinishedBlock)finishedBlock;


@end
