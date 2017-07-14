//
//  RequestTool.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/10.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "RequestTool.h"
#import "RequestParameter.h"
#import "NSDictionary+JSONString.h"
@implementation RequestTool
singleton_implementation(RequestTool);

#pragma Mark =========  implementation   ====
//注册
-(void)requestWithRegisterForPhoneNumber:(NSString *)phoneNumber Password:(NSString *)password Captcha:(NSString *)captcha FinishedBlock:(RequestFinishedBlock)finishedBlock
{
    NSDictionary * parameterDic = @{@"member_name":phoneNumber,@"password":password,@"captcha":captcha};
    
    
    [[HttpToolManager sharedManager] requestWithMethod:kGET URLString:mRegister parameters:parameterDic Upload:NO option:BcRequestCenterCachePolicyNormal finished:finishedBlock];
}
//请求验证码
-(void)requestWithCaptchaForPhoneNumber:(NSString *)mobile Type:(NSString *)type FinishedBlock:(RequestFinishedBlock)finishedBlock
{
    NSDictionary * parameterDic = @{@"site_id":@1,@"mobile":mobile,@"type":type};
    
    [[HttpToolManager sharedManager] requestWithMethod:kGET URLString:mCaptcha parameters:parameterDic Upload:NO option:BcRequestCenterCachePolicyNormal finished:finishedBlock];
}
//忘记密码
-(void)requestWithForgetPasswordMobile:(NSString *)mobile Captcha:(NSString *)captcha Password:(NSString *)newPassword FinishedBlock:(RequestFinishedBlock)finishedBlock
{
    NSDictionary * parameterDic = @{@"member_name":mobile,@"captcha":captcha,@"password":newPassword};
    
    [[HttpToolManager sharedManager] requestWithMethod:kGET URLString:mReset parameters:parameterDic Upload:NO option:BcRequestCenterCachePolicyNormal finished:finishedBlock];
}
//登录
-(void)requestWithLoginPhoneNumber:(NSString *)mobile Password:(NSString *)password FinishedBlock:(RequestFinishedBlock)finishedBlock
{
    NSDictionary * parameterDic = @{@"member_name":mobile,@"password":password};
    
    [[HttpToolManager sharedManager] requestWithMethod:kGET URLString:mLogin parameters:parameterDic Upload:NO option:BcRequestCenterCachePolicyNormal finished:finishedBlock];
}
//我的牧场列表
-(void)requestWithPasturesForOwnsFinishedBlock:(RequestFinishedBlock)finishedBlock
{
    NSDictionary * parameterDic = @{@"token":[LoginInfoModel getLoginInfoModel].token};
    
    [[HttpToolManager sharedManager] requestWithMethod:kGET URLString:Owns parameters:parameterDic Upload:NO option:BcRequestCenterCachePolicyNormal finished:finishedBlock];
}
//牧场基本详情界面布局
-(void)requestWithRanchBasicLayoutFinishedBlock:(RequestFinishedBlock)finishedBlock
{
    NSDictionary * parameterDic = @{@"id":@1};
    
    [[HttpToolManager sharedManager] requestWithMethod:kGET URLString:Layout parameters:parameterDic Upload:NO option:BcRequestCenterCachePolicyNormal finished:finishedBlock];
}
//获取牧场基本信息
-(void)requestWithRanchBasicInfoFinishedBlock:(RequestFinishedBlock)finishedBlock
{
    NSDictionary * parameterDic = @{@"id":@1};
    
    [[HttpToolManager sharedManager] requestWithMethod:kGET URLString:calfInfo parameters:parameterDic Upload:NO option:BcRequestCenterCachePolicyNormal finished:finishedBlock];
}
//创建牧场界面
-(void)requestWithCreateRanchName:(NSString *)name Address:(NSString *)address Time:(NSString *)time Area:(NSString *)area FinishedBlock:(RequestFinishedBlock)finishedBlock
{
    NSDictionary * dic = @{@"name":name,@"address":address,@"built_at":time,@"area":area
                           };
    
    NSDictionary * parameterDic = @{@"body":[dic JSONString]};
    
    NSString * URLString = [NSString stringWithFormat:@"%@?token=%@",createRanch,[LoginInfoModel getLoginInfoModel].token];
    
    [[HttpToolManager sharedManager] requestWithMethod:kPOST URLString:URLString parameters:parameterDic Upload:YES option:BcRequestCenterCachePolicyNormal finished:finishedBlock];
}
//修改牧场接口
-(void)requestWithRanchInfoToServer:(NSDictionary *)body FinishedBlock:(RequestFinishedBlock)finishedBlock
{
    NSDictionary * parameterDic = @{@"body":[body JSONString]};
    
    NSString * URLString = [NSString stringWithFormat:@"%@?token=%@&id=1",modfiyInfo,[LoginInfoModel getLoginInfoModel].token];
    
    [[HttpToolManager sharedManager] requestWithMethod:kPOST URLString:URLString parameters:parameterDic Upload:YES option:BcRequestCenterCachePolicyNormal finished:finishedBlock];
}

@end
