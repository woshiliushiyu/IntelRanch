//
//  HttpToolManager.m
//  SunnyPrj
//
//  Created by Pac on 16/3/6.
//  Copyright © 2016年 Pactera. All rights reserved.
//

#import "HttpToolManager.h"
#import "YTKKeyValueStore.h"
#import "AppDelegate.h"
#define BaseURL @"https://ymzx.asia-cloud.com/api/"

@protocol HttpNetworkProxy <NSObject>

@optional
/**
 *  AFN私有方法
 *
 *  @param method           http 方法
 *  @param URLString        URLSting
 *  @param parameters       请求参数（一般字典）
 *  @param uploadProgress   上传进度
 *  @param downloadProgress 下载进度
 *  @param success          成功回调
 *  @param failure          失败回调
 *
 *  @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

@end

@interface HttpToolManager () <HttpNetworkProxy>
@property (assign, nonatomic) BOOL isReachability;

@end

@implementation HttpToolManager
static NSString *_tableName;
static YTKKeyValueStore *_store;


+ (instancetype)sharedManager {
    static HttpToolManager *manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:BaseURL]];
    });
    return manager;
}


+(void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _store = [[YTKKeyValueStore alloc] initDBWithName:@"CBTCache.db"];
        _tableName = @"user_table";
        [_store createTableWithName:_tableName];
    });
}

-(instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        [self.reachabilityManager startMonitoring];
        self.requestSerializer.timeoutInterval = 15;
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", nil];
//        self.responseSerializer = [AFHTTPResponseSerializer serializer];
//        [(AFJSONResponseSerializer *)self.responseSerializer setRemovesKeysWithNullValues:YES];
        
        //https ssl 验证
//        [self setSecurityPolicy:[self customSecurityPolicy]];
    }
    return self;
}


- (AFSecurityPolicy*)customSecurityPolicy {
    
#pragma mark - 先导入证书
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"" ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    securityPolicy.pinnedCertificates = [NSSet setWithArray:@[certData]];//@[certData];
    
    return securityPolicy;
}


#pragma mark - 封装AFN method

/**
 *  发起网络请求
 *
 *  @param method        GET / POST
 *  @param URLString     URLString
 *  @param patameters    请求参数（一般为字典）
 *  @param finishedBlock 完成的回调
 */

/**
 发起网络请求

 @param method GET / POST
 @param URLString URLString
 @param patameters 请求参数（一般为字典)
 @param option 网络请求是否缓存
 @param finishedBlock 完成的回调
 */
- (void)requestWithMethod:(HTTPMethod)method URLString:(NSString *)URLString parameters:(id)patameters Upload:(BOOL)upload option:(BcRequestCenterCachePolicy)option finished:(RequestFinishedBlock)finishedBlock {
    
    NSString *methodName = (method == kGET) ? @"GET" : @"POST";
    
    [LCProgressHUD showLoading:@"加载中..."];
    
    if (upload) {
        
        [self uploadMessageWithmethodName:methodName URLString:URLString parameters:patameters finished:finishedBlock];
        
    }else{
        switch (option) {
            case BcRequestCenterCachePolicyNormal: {//无缓存
                [self cachePolicyNormalWithmethodName:methodName URLString:URLString parameters:patameters finished:finishedBlock];
                //            [self cacheAndLocalWithmethodName:methodName URLString:URLString parameters:patameters finished:finishedBlock];
            }
                break;
            case BcRequestCenterCachePolicyCacheAndLocal: {//缓存
                [self cacheAndLocalWithmethodName:methodName URLString:URLString parameters:patameters finished:finishedBlock];
            }
                break;
                
            default:
                break;
        }
    }
}
//无缓存
- (void)cachePolicyNormalWithmethodName:(NSString *)methodName URLString:(NSString *)URLString parameters:(id)patameters finished:(RequestFinishedBlock)finishedBlock{
    [[self dataTaskWithHTTPMethod:methodName URLString:URLString parameters:patameters uploadProgress:NULL downloadProgress:NULL success:^(NSURLSessionDataTask *task, id responseObject) {
        if (finishedBlock) {
            [LCProgressHUD hide];
            finishedBlock(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (finishedBlock) {
            [LCProgressHUD hide];
            [LCProgressHUD showFailure:@"请求失败"];
            finishedBlock(nil, error);
        }
    }] resume];
}
//上传
- (void)uploadMessageWithmethodName:(NSString *)methodName URLString:(NSString *)URLString parameters:(id)patameters finished:(RequestFinishedBlock)finishedBlock
{
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:methodName URLString:[NSString stringWithFormat:BaseURL@"%@",URLString]  parameters:patameters error:nil];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        if (connectionError == nil) {
            
            NSDictionary * dic = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            finishedBlock(dic,nil);
            [LCProgressHUD hide];
            
        }else{
            [LCProgressHUD hide];
            [LCProgressHUD showFailure:@"请求失败"];
            finishedBlock(nil,connectionError);
        }
        [LCProgressHUD hide];
    }];
}
//缓存
- (void)cacheAndLocalWithmethodName:(NSString *)methodName URLString:(NSString *)URLString parameters:(id)patameters finished:(RequestFinishedBlock)finishedBlock{
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",URLString,patameters];
    if ([self judgeNet]) {
        [[self dataTaskWithHTTPMethod:methodName URLString:URLString parameters:patameters uploadProgress:NULL downloadProgress:NULL success:^(NSURLSessionDataTask *task, id responseObject) {
            
            if (finishedBlock) {
                [LCProgressHUD hide];
                [_store putObject:responseObject withId:URL intoTable:_tableName];
                finishedBlock(responseObject, nil);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (finishedBlock) {
                [LCProgressHUD showFailure:@"请求失败"];
                finishedBlock(nil, error);
            }
        }] resume];
    } else {
        id responseObject = [_store getObjectById:URL fromTable:_tableName];
        
        if (responseObject) {
            NSLog(@"系统有缓存 ");
            finishedBlock(responseObject,nil);
        } else {
            NSLog(@"系统无有缓存 ");
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"No Cache"                                                                      forKey:NSLocalizedDescriptionKey];
            NSError *error = [NSError errorWithDomain:@"com.storyBoard.test" code:-1000 userInfo:userInfo];
            finishedBlock(nil, error);
        }
    }
}
// 判断网络
- (BOOL)judgeNet {
        BOOL _isNetworkStatue = true;
        
        NSArray *children = [[[[UIApplication sharedApplication] valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
        NSString * state;
        
        for (id child in children) {
            if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
                //获取到状态栏
                int netType = [[child valueForKeyPath:@"dataNetworkType"] intValue];
                
                switch (netType) {
                    case 0:
                        state = @"无网络";
                        _isNetworkStatue = false;
                        //无网模式
                        break;
                    case 1:
                        state =  @"2G";
                        _isNetworkStatue = true;
                        break;
                    case 2:
                        state =  @"3G";
                        _isNetworkStatue = true;
                        break;
                    case 3:
                        state =   @"4G";
                        _isNetworkStatue = true;
                        break;
                    case 5:
                    {
                        state =  @"wifi";
                        _isNetworkStatue = true;
                        break;
                    default:
                        break;
                    }
                }
            }else{
                _isNetworkStatue = NO;
            }
            //根据状态选择
        }
    
    
        return _isNetworkStatue;
    
    
}



@end
