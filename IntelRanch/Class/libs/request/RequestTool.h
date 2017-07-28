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

 @param layout  模型 id
 @param finishedBlock 回调
 */
-(void)requestWithRanchBasicLayoutTo:(NSInteger)layout FinishedBlock:(RequestFinishedBlock)finishedBlock;

/**
 获取牧场基本信息

 @param finishedBlock 回调
 */
-(void)requestWithRanchBasicInfoFinishedBlock:(RequestFinishedBlock)finishedBlock;

/**
 创建信息接口

 @param finishedBlock 回调
 */
-(void)requestWithCreateRanchName:(NSString *)name Address:(NSString*)address Time:(NSString*)time Area:(NSString*)area FinishedBlock:(RequestFinishedBlock)finishedBlock;

/**
 修改信息接口

 @param body 牧场参数
 @param finishedBlock 回调
 */
-(void)requestWithRanchInfoToServerPort:(NSString*)port InfoId:(NSString*)infoid Body:(NSDictionary *)body FinishedBlock:(RequestFinishedBlock)finishedBlock;

/**
 多媒体上传

 @param type 上传类型
 @param finishedBlock 回调
 */
-(void)uploadWithMediaType:(NSString*)type Media:(id)media FinishedBlock:(RequestFinishedBlock)finishedBlock;

/**
 获取犊牛样本平均值

 @param finishedBlock 回调
 */
-(void)requestWithSampleForServerFinishedBlock:(RequestFinishedBlock)finishedBlock;

/**
 上传犊牛样本表格界面数据

 @param parameter 索引
 @param finishedblock 回调
 */
-(void)uploadWithCalfSampleParameter:(NSMutableDictionary *)parameter FinishedBlock:(RequestFinishedBlock)finishedblock;

/**
 获取牧场信息

 @param finishedBlock 回调
 */
-(void)requestWithRanchInfoForServerFinishedBlock:(RequestFinishedBlock)finishedBlock;

/**
 上传图片列表

 @param imgs 图片集合
 @param type 所在类型 1 牧场类型
 @param finishedBlock 回调
 */
-(void)uploadWithImgList:(NSMutableArray *)imgs Summery:(NSString*)summery Type:(NSInteger)type ModelId:(NSString *)modelId FinishedBlock:(RequestFinishedBlock)finishedBlock;

/**
 获取图片列表

 @param type 模型对象
 @param finishedBlock 回调 
 */
-(void)requestWithImageListType:(NSInteger)type ModelId:(NSString *)modelId FinishedBlock:(RequestFinishedBlock)finishedBlock;

/**
 获取视频列表

 @param type 模型对象
 @param finishedBlock 回调
 */
-(void)requestWithVideosListType:(NSInteger)type ModelId:(NSString *)modelId FinishedBlock:(RequestFinishedBlock)finishedBlock;

/**
 上传视频列表

 @param video 图片
 @param type 模型对象
 @param finishedBlock  回调
 */
-(void)uploadWithVideosList:(NSString *)video Summery:(NSString*)summery Type:(NSInteger)type ModelId:(NSString *)modelId FinishedBlock:(RequestFinishedBlock)finishedBlock;

/**
 获取砖家信息

 @param finishedBlock 回调
 */
-(void)requestWithTeamInfoListForServerFinished:(RequestFinishedBlock)finishedBlock;

/**
 上传问题

 @param descript 问题描述
 @param type 问题类型
 @param teamId 砖家 ID
 @param finishedBlock  回调
 */
-(void)uploadWithProblemDescript:(NSString*)descript Tpye:(NSString*)type TeamId:(NSString*)teamId Finished:(RequestFinishedBlock)finishedBlock;

/**
 获取问题列表

 @param finishedBlock 回调
 */
-(void)requestWithProblemForServerListPage:(NSInteger)page FinishedBlock:(RequestFinishedBlock)finishedBlock;

/**
 获取常见问题列表

 @param page 页数
 @param finishedBlock 回调
 */
-(void)requestWithCommonProblemForServerListPage:(NSInteger)page FinishedBlock:(RequestFinishedBlock)finishedBlock;

/**************************************获取新生犊牛,饲养,疾病数据***************************************/
/**
 获取日志列表

 @param finishedBlock 回调
 */
-(void)requestWithCalfManagerListToserverId:(NSInteger)type FinishedBlock:(RequestFinishedBlock)finishedBlock;

/**
 获取日志

 @param idString 日志 ID
 @param finishedBlock  回调
 */
-(void)requestWithCalfManagerForId:(NSString *)idString Type:(NSInteger)type FinishedBlock:(RequestFinishedBlock)finishedBlock;

/**
 获取疾病列表

 @param idString 疾病 id
 @param finishedBlock 回调
 */
-(void)requestWithIcknessForId:(NSString *)idString FinishedBlock:(RequestFinishedBlock)finishedBlock;

/**
 获取犊牛样本列表
 
 @param finishedBlock 回调
 */
-(void)requestWithSamplesListForServerFinishedBlock:(RequestFinishedBlock)finishedBlock;
/***************************************上传评分************************************/

/**
 上传评分

 @param score 评分
 @param code 识别码
 @param type 类型
 @param value1 value
 @param value2 value
 @param finishedBlock 回调
 */
-(void)requestWithScoreForServer:(NSString*)score Sickness:(NSString *)sicknessId Code:(NSString*)code Type:(NSInteger)type Value1:(NSString*)value1 Value2:(NSString*)value2 FinishedBlock:(RequestFinishedBlock)finishedBlock;
@end
