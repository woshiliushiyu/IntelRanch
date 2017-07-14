//
//  LocalDataTool.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/14.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "LocalDataTool.h"

@implementation LocalDataTool

static YTKKeyValueStore * _store;
static NSString * _dataName;

+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _store = [[YTKKeyValueStore alloc] initDBWithName:@"common.db"];
    });
}
+(void)putDataToTableName:(NSString *)tableName Data:(id)data
{
    [_store createTableWithName:tableName];
    
    _dataName = tableName;
    
    [_store putObject:data withId:_dataName intoTable:tableName];
    
}
+(id)getDataToDataName:(NSString *)name
{
    return [_store getObjectById:_dataName fromTable:_dataName];
}
+(void)cleanForTableName:(NSString *)name
{
    [_store deleteObjectById:name fromTable:_dataName];
}

@end
