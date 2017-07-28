//
//  LocalDataTool.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/14.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalDataTool : NSObject

/**
 插入数据

 @param tableName 表名
 @param data 数据
 */
+(void)putDataToTableName:(NSString*)tableName Data:(id)data;

/**
 获取数据

 @param name 表名
 @return 获取的数据
 */
+(id)getDataToDataName:(NSString*)name;


/**
 清除指定表里面的数据

 @param name 表名
 */
+(void)cleanForTableName:(NSString*)name;

/**
 清除数据库表
 */
+(void)clearDataTableName:(NSString*)tableName;
@end
