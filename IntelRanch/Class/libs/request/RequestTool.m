//
//  RequestTool.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/10.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "RequestTool.h"
#import "RequestParameter.h"
#import "LocalDataTool.h"
#import "Sample.h"
#import "TableDataTool.h"
#import "MyRanchInfoModel.h"
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
-(void)requestWithRanchBasicLayoutTo:(NSInteger)layout FinishedBlock:(RequestFinishedBlock)finishedBlock
{
    [LCProgressHUD showLoading:@"加载中..."];
    
    NSDictionary * parameterDic = @{@"id":Str(layout)};
    
    [[HttpToolManager sharedManager] requestWithMethod:kGET URLString:Layout parameters:parameterDic Upload:NO option:BcRequestCenterCachePolicyCacheAndLocal finished:finishedBlock];
}
//获取牧场基本信息
-(void)requestWithRanchBasicInfoFinishedBlock:(RequestFinishedBlock)finishedBlock
{
    MyRanchInfoModel * model = [[MyRanchInfoModel alloc] initWithDictionary:[LocalDataTool getDataToDataName:[NSString stringWithString:NSStringFromClass([MyRanchInfoModel class])]] error:nil];
    
    NSDictionary * parameterDic = @{@"id":model.id};
    
    [[HttpToolManager sharedManager] requestWithMethod:kGET URLString:calfInfo parameters:parameterDic Upload:NO option:BcRequestCenterCachePolicyNormal finished:finishedBlock];
}
//创建牧场界面
-(void)requestWithCreateRanchName:(NSString *)name Address:(NSString *)address Time:(NSString *)time Area:(NSString *)area FinishedBlock:(RequestFinishedBlock)finishedBlock
{
    NSDictionary * dic = @{@"name":name,@"address":address,@"built_at":time,@"area":area
                           };
    
    NSDictionary * parameterDic = dic;
    
    NSString * URLString = [NSString stringWithFormat:@"%@?token=%@",createRanch,[LoginInfoModel getLoginInfoModel].token];
    
    [[HttpToolManager sharedManager] requestWithMethod:kPOST URLString:URLString parameters:parameterDic Upload:YES option:BcRequestCenterCachePolicyNormal finished:finishedBlock];
}
//修改牧场接口
-(void)requestWithRanchInfoToServerPort:(NSString*)port InfoId:(NSString*)infoid Body:(NSDictionary *)body FinishedBlock:(RequestFinishedBlock)finishedBlock
{
    NSDictionary * parameterDic =body;
    
//    NSString * idString;
//    
//    if ([port isEqualToString:modfiyInfo]) {
//        
//        idString = model.id;
//    }
//    if ([port isEqualToString:newborn]) {
//        
//        idString = [[NSUserDefaults standardUserDefaults] objectForKey:@"newCreate2"];
//    }
    
    NSString * URLString = [NSString stringWithFormat:@"%@?token=%@&id=%@",port,[LoginInfoModel getLoginInfoModel].token,infoid];
    
    [[HttpToolManager sharedManager] requestWithMethod:kPOST URLString:URLString parameters:parameterDic Upload:YES option:BcRequestCenterCachePolicyNormal finished:finishedBlock];
}
////多媒体上传
-(void)uploadWithMediaType:(NSString *)type Media:(id)media FinishedBlock:(RequestFinishedBlock)finishedBlock
{
    NSString * URLString = [NSString stringWithFormat:@"%@?type=%@&token=%@",uploadMedia,type,[LoginInfoModel getLoginInfoModel].token];
    if ([media isKindOfClass:[NSData class]]) {
        
        [[HttpToolManager sharedManager] uploadWithURLString:URLString parameters:(NSData *)media finished:finishedBlock];
        
    }else{
        [self convertVideoWithURL:(NSURL *)media URLString:URLString FinishedBlock:finishedBlock];
    }
}
//请求犊牛样本数据
-(void)requestWithSampleForServerFinishedBlock:(RequestFinishedBlock)finishedBlock
{
    MyRanchInfoModel * model = [[MyRanchInfoModel alloc] initWithDictionary:[LocalDataTool getDataToDataName:[NSString stringWithString:NSStringFromClass([MyRanchInfoModel class])]] error:nil];
    
    NSDictionary * parameter = @{@"pasture_id":model.id};
    
    [[HttpToolManager sharedManager] requestWithMethod:kGET URLString:sampleAverge parameters:parameter Upload:NO option:BcRequestCenterCachePolicyCacheAndLocal finished:finishedBlock];
}
//上传犊牛样本数据
-(void)uploadWithCalfSampleParameter:(NSMutableDictionary *)parameter FinishedBlock:(RequestFinishedBlock)finishedblock
{
    [LCProgressHUD showLoading:@"保存中..."];
    
    MyRanchInfoModel * model = [[MyRanchInfoModel alloc] initWithDictionary:[LocalDataTool getDataToDataName:[NSString stringWithString:NSStringFromClass([MyRanchInfoModel class])]] error:nil];
    
    [parameter setObject:model.id forKey:@"pasture_id"];
    
    NSString * URLString = [NSString stringWithFormat:@"%@?token=%@",uploadCalfSample,[LoginInfoModel getLoginInfoModel].token];
    
    [[HttpToolManager sharedManager] requestWithMethod:kPOST URLString:URLString parameters:parameter Upload:YES option:BcRequestCenterCachePolicyNormal finished:finishedblock];
}
//获取牧场信息
-(void)requestWithRanchInfoForServerFinishedBlock:(RequestFinishedBlock)finishedBlock
{
    NSLog(@"token====>%@",[LoginInfoModel getLoginInfoModel].token);
    
    MyRanchInfoModel * model = [[MyRanchInfoModel alloc] initWithDictionary:[LocalDataTool getDataToDataName:[NSString stringWithString:NSStringFromClass([MyRanchInfoModel class])]] error:nil];
    
    NSDictionary * paramterDic = @{@"id":model.id};
    
    [[HttpToolManager sharedManager] requestWithMethod:kGET URLString:getRanchInfo parameters:paramterDic Upload:NO option:BcRequestCenterCachePolicyCacheAndLocal finished:finishedBlock];
}
//上传图片列表
-(void)uploadWithImgList:(NSMutableArray *)imgs Summery:(NSString*)summery Type:(NSInteger)type ModelId:(NSString *)modelId FinishedBlock:(RequestFinishedBlock)finishedBlock
{

    NSString * URLString;
    
    NSMutableString * urls = [[NSMutableString alloc] init];
    
    for (int i=0; i<imgs.count; i++) {
        
        if (i==imgs.count-1) {
            
            [urls appendString:imgs[i]];
        }else{
            
            [urls appendFormat:@"%@,",imgs[i]];
        }
    }

    MyRanchInfoModel * model = [[MyRanchInfoModel alloc] initWithDictionary:[LocalDataTool getDataToDataName:[NSString stringWithString:NSStringFromClass([MyRanchInfoModel class])]] error:nil];
    
    URLString = [NSString stringWithFormat:@"%@?id=%@&token=%@&model_id=%ld&urls=%@&summary=%@",images,modelId==nil?model.id:modelId,[LoginInfoModel getLoginInfoModel].token,(long)type,urls,summery];
    
    [[HttpToolManager sharedManager] requestWithMethod:kPOST URLString:URLString parameters:nil Upload:YES option:BcRequestCenterCachePolicyNormal finished:finishedBlock];
    
}
//获取图片列表
-(void)requestWithImageListType:(NSInteger)type ModelId:(NSString *)modelId FinishedBlock:(RequestFinishedBlock)finishedBlock
{
    NSString * URLString;
    
    MyRanchInfoModel * model = [[MyRanchInfoModel alloc] initWithDictionary:[LocalDataTool getDataToDataName:[NSString stringWithString:NSStringFromClass([MyRanchInfoModel class])]] error:nil];
    
    URLString = [NSString stringWithFormat:@"%@?id=%@&model_id=%ld",images,modelId==nil?model.id:modelId,(long)type];

    [[HttpToolManager sharedManager] requestWithMethod:kGET URLString:URLString parameters:nil Upload:NO option:BcRequestCenterCachePolicyCacheAndLocal finished:finishedBlock];
}
//获取图片列表
-(void)requestWithVideosListType:(NSInteger)type ModelId:(NSString *)modelId FinishedBlock:(RequestFinishedBlock)finishedBlock
{
    [LCProgressHUD showLoading:@"请求中...."];
    
    NSString * URLString;
    
    MyRanchInfoModel * model = [[MyRanchInfoModel alloc] initWithDictionary:[LocalDataTool getDataToDataName:[NSString stringWithString:NSStringFromClass([MyRanchInfoModel class])]] error:nil];
    
    URLString = [NSString stringWithFormat:@"%@?id=%@&model_id=%ld",videos,modelId==nil?model.id:modelId,(long)type];

    [[HttpToolManager sharedManager] requestWithMethod:kGET URLString:URLString parameters:nil Upload:NO option:BcRequestCenterCachePolicyCacheAndLocal finished:finishedBlock];
}
//上传视频列表
-(void)uploadWithVideosList:(NSString *)video Summery:(NSString*)summery Type:(NSInteger)type ModelId:(NSString *)modelId FinishedBlock:(RequestFinishedBlock)finishedBlock
{
    NSString * URLString;
    
    MyRanchInfoModel * model = [[MyRanchInfoModel alloc] initWithDictionary:[LocalDataTool getDataToDataName:[NSString stringWithString:NSStringFromClass([MyRanchInfoModel class])]] error:nil];
    
    URLString = [NSString stringWithFormat:@"%@?id=%@&token=%@&model_id=%ld&urls=%@&summary=%@",videos,modelId==nil?model.id:modelId,[LoginInfoModel getLoginInfoModel].token,type,video,summery];
    
    [[HttpToolManager sharedManager] requestWithMethod:kPOST URLString:URLString parameters:nil Upload:YES option:BcRequestCenterCachePolicyNormal finished:finishedBlock];
}
//获取砖家接口
-(void)requestWithTeamInfoListForServerFinished:(RequestFinishedBlock)finishedBlock
{
    [LCProgressHUD showLoading:@"请求中...."];
    
    [[HttpToolManager sharedManager] requestWithMethod:kGET URLString:experts parameters:nil Upload:NO option:BcRequestCenterCachePolicyCacheAndLocal finished:finishedBlock];
}
//上传问题
-(void)uploadWithProblemDescript:(NSString *)descript Tpye:(NSString *)type TeamId:(NSString *)teamId Finished:(RequestFinishedBlock)finishedBlock
{
    MyRanchInfoModel * model = [[MyRanchInfoModel alloc] initWithDictionary:[LocalDataTool getDataToDataName:[NSString stringWithString:NSStringFromClass([MyRanchInfoModel class])]] error:nil];
    
    NSString * URLString = [NSString stringWithFormat:@"%@?pasture_id=%@&type=%@&expert_id=%@&summary=%@&token=%@",create,model.id,type,teamId,descript,[LoginInfoModel getLoginInfoModel].token];

    [[HttpToolManager sharedManager] requestWithMethod:kPOST URLString:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:nil Upload:NO option:BcRequestCenterCachePolicyNormal finished:finishedBlock];
}
//获取问题列表
-(void)requestWithProblemForServerListPage:(NSInteger)page FinishedBlock:(RequestFinishedBlock)finishedBlock
{
    [LCProgressHUD showLoading:@"请求中..."];
    
    MyRanchInfoModel * model = [[MyRanchInfoModel alloc] initWithDictionary:[LocalDataTool getDataToDataName:[NSString stringWithString:NSStringFromClass([MyRanchInfoModel class])]] error:nil];
    
    NSString * URLString = [NSString stringWithFormat:@"questions?pasture_id=%@&page_size=20&page=%ld",model.id,(long)page];
    
    [[HttpToolManager sharedManager] requestWithMethod:kGET URLString:URLString parameters:nil Upload:NO option:BcRequestCenterCachePolicyCacheAndLocal finished:finishedBlock];
}
-(void)requestWithCommonProblemForServerListPage:(NSInteger)page FinishedBlock:(RequestFinishedBlock)finishedBlock
{
    [LCProgressHUD showLoading:@"请求中..."];
    
    NSString * URLString = [NSString stringWithFormat:@"articles/list?category_id=1&page_size=20&page=%ld",(long)page];
    
    [[HttpToolManager sharedManager] requestWithMethod:kGET URLString:URLString parameters:nil Upload:NO option:BcRequestCenterCachePolicyCacheAndLocal finished:finishedBlock];
}
/**************************************获取新生犊牛&饲养&疾病数据***************************************/
//获取日志列表
-(void)requestWithCalfManagerListToserverId:(NSInteger)type FinishedBlock:(RequestFinishedBlock)finishedBlock
{
    MyRanchInfoModel * model = [[MyRanchInfoModel alloc] initWithDictionary:[LocalDataTool getDataToDataName:[NSString stringWithString:NSStringFromClass([MyRanchInfoModel class])]] error:nil];
    
    NSArray * array = @[@"pastures/owns",@"newborn/logs",@"feeding/logs",@"sickness/logs"];
    
    NSString * URLString = [NSString stringWithFormat:@"%@?pasture_id=%@",array[type-1],model.id];
    
    [[HttpToolManager sharedManager] requestWithMethod:kGET URLString:URLString parameters:nil Upload:NO option:BcRequestCenterCachePolicyCacheAndLocal finished:finishedBlock];
}
//获取信息
-(void)requestWithCalfManagerForId:(NSString *)idString Type:(NSInteger)type  FinishedBlock:(RequestFinishedBlock)finishedBlock
{
    NSArray * array = @[@"pastures/info",@"newborn/logs/info",@"feeding/logs/info",@"sickness/logs/info"];
    
    NSString * URLString = [NSString stringWithFormat:@"%@?id=%@",array[type-1],idString];
    
    [[HttpToolManager sharedManager] requestWithMethod:kGET URLString:URLString parameters:nil Upload:NO option:BcRequestCenterCachePolicyCacheAndLocal finished:finishedBlock];
}
//获取犊牛列表
-(void)requestWithSamplesListForServerFinishedBlock:(RequestFinishedBlock)finishedBlock
{
    [LCProgressHUD showLoading:@"获取中..."];
    
    MyRanchInfoModel * model = [[MyRanchInfoModel alloc] initWithDictionary:[LocalDataTool getDataToDataName:[NSString stringWithString:NSStringFromClass([MyRanchInfoModel class])]] error:nil];
    
    NSDictionary * paramterDic = @{@"pasture_id":model.id};
    
    [[HttpToolManager sharedManager] requestWithMethod:kGET URLString:@"samples/list" parameters:paramterDic Upload:NO option:BcRequestCenterCachePolicyCacheAndLocal finished:finishedBlock];
}

-(void)requestWithScoreForServer:(NSString*)score Sickness:(NSString *)sicknessId Code:(NSString*)code Type:(NSInteger)type Value1:(NSString*)value1 Value2:(NSString*)value2 FinishedBlock:(RequestFinishedBlock)finishedBlock
{
    NSDictionary * dic = @{@"sickness_log_id":Str(sicknessId),@"code":code,@"type":Str(type),@"value1":Str(value1),@"value2":Str(value2),@"score":score,@"member_id":[LoginInfoModel getLoginInfoModel].uid};
    
    NSString * URLString = [NSString stringWithFormat:@"evaluates/create?token=%@",[LoginInfoModel getLoginInfoModel].token];
    
    [[HttpToolManager sharedManager] requestWithMethod:kPOST URLString:URLString parameters:dic Upload:YES option:BcRequestCenterCachePolicyNormal finished:finishedBlock];
}
-(void)requestWithIcknessForId:(NSString *)idString FinishedBlock:(RequestFinishedBlock)finishedBlock
{
    NSString * URLString = [NSString stringWithFormat:@"evaluates/list?sickness_log_id=%@&type=0",idString];
    
    [[HttpToolManager sharedManager] requestWithMethod:kGET URLString:URLString parameters:nil Upload:NO option:BcRequestCenterCachePolicyCacheAndLocal finished:finishedBlock];
}
/********************************************视频压缩**********************************************/
- (void)convertVideoWithURL:(NSURL *)url URLString:(NSString*)URLString FinishedBlock:(RequestFinishedBlock)finishedBlock
{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"YYYYMMddHHmmss"];
    NSString *dateName = [dateformatter stringFromDate:date];
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *pathName = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",dateName]];
    
    //转码配置
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:url options:nil];
    AVAssetExportSession *exportSession= [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetMediumQuality];
    exportSession.shouldOptimizeForNetworkUse = YES;
    exportSession.outputURL = [NSURL fileURLWithPath:pathName];
    exportSession.outputFileType = AVFileTypeMPEG4;
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        int exportStatus = exportSession.status;
        switch (exportStatus){
            case AVAssetExportSessionStatusFailed:
            {
                // log error to text view
                NSError *exportError = exportSession.error;
                NSLog (@"AVAssetExportSessionStatusFailed: %@", exportError);

                break;
            }
            case AVAssetExportSessionStatusCompleted:
            {
                [[HttpToolManager sharedManager] uploadWithURLString:URLString parameters:[NSData dataWithContentsOfFile:pathName] finished:finishedBlock];
            }
        }
    }];
}
@end
