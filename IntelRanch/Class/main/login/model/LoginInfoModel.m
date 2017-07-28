//
//  LoginInfoModel.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/11.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "LoginInfoModel.h"


@implementation LoginInfoModel

static YTKKeyValueStore * _store;
static NSString * _tableName;


+(void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _store = [[YTKKeyValueStore alloc] initDBWithName:@"loginInfo.db"];
        
        _tableName = @"loginInfo";
        
        [_store createTableWithName:_tableName];
    });
}
+(void)saveLoginInfo:(id)model
{
    [_store putObject:model withId:@"login" intoTable:_tableName];
}
+(LoginInfoModel*)getLoginInfoModel
{
    return [[LoginInfoModel alloc] initWithDictionary:[_store getObjectById:@"login" fromTable:_tableName] error:nil];
}
+(void)clearnLoginInfo
{
    [_store clearTable:@"loginInfo"];
}
+(BOOL)isLogin
{
    if ([_store getObjectById:@"login" fromTable:_tableName] == nil) {
        
        return NO;
        
    }else{
        
        return YES;
    }
}
@end
