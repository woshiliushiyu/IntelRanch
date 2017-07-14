//
//  YTKKeyValueStore.h
//  Ape
//
//  Created by TangQiao on 12-11-6.
//  Copyright (c) 2012年 TangQiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTKKeyValueItem : NSObject

@property (strong, nonatomic) NSString *itemId;
@property (strong, nonatomic) id itemObject;
@property (strong, nonatomic) NSDate *createdTime;

@end


@interface YTKKeyValueStore : NSObject


/**
 初始化数据库表名（默认地址来源）

 @param dbName 数据库表名
 @return 数据库
 */
- (id)initDBWithName:(NSString *)dbName;


/**
 初始化数据库地址

 @param dbPath 数据库地址
 @return 数据库
 */
- (id)initWithDBWithPath:(NSString *)dbPath;


/**
 创建数据库

 @param tableName 数据库表名
 */
- (void)createTableWithName:(NSString *)tableName;


/**
 清楚数据库所有信息
 
 @param tableName 数据库表名
 */
- (void)clearTable:(NSString *)tableName;

- (void)close;

///************************ Put&Get methods *****************************************


/**
 设置数据库信息（插入新数据，修改）id类型

 @param object 对应数据列表的数据信息
 @param objectId 数据列表对应Key
 @param tableName 数据库表名
 */
- (void)putObject:(id)object withId:(NSString *)objectId intoTable:(NSString *)tableName;


/**
 获取数据库信息

 @param objectId 数据列表对应Key
 @param tableName 数据库表名
 @return 对应数据列表的数据信息的Value
 */
- (id)getObjectById:(NSString *)objectId fromTable:(NSString *)tableName;



/**
 获取数据库信息

 @param objectId 数据列表对应Key
 @param tableName 数据库表名
 @return 对应数据列表的数据信息
 */
- (YTKKeyValueItem *)getYTKKeyValueItemById:(NSString *)objectId fromTable:(NSString *)tableName;


/**
 设置数据库信息（插入新数据，修改）NSString类型

 @param string 对应数据列表的数据信息
 @param stringId 数据列表对应Key
 @param tableName 数据库表名
 */
- (void)putString:(NSString *)string withId:(NSString *)stringId intoTable:(NSString *)tableName;

/**
 获取数据库信息

 @param stringId 数据列表对应Key
 @param tableName 数据库表名
 @return  获取数据库信息Key
 */
- (NSString *)getStringById:(NSString *)stringId fromTable:(NSString *)tableName;


/**
 设置数据库信息（插入新数据，修改）NSNumber类型

 @param number 对应数据列表的数据信息
 @param numberId 数据列表对应Key
 @param tableName 数据库表名
 */
- (void)putNumber:(NSNumber *)number withId:(NSString *)numberId intoTable:(NSString *)tableName;

/**
 获取数据库列表信息

 @param numberId 数据列表对应Key
 @param tableName 数据库表名
 @return 获取数据库信息Key
 */
- (NSNumber *)getNumberById:(NSString *)numberId fromTable:(NSString *)tableName;


/**
 获取数据库所有信息

 @param tableName 数据库表名
 @return 数据库所有信息
 */
- (NSArray *)getAllItemsFromTable:(NSString *)tableName;


/**
 删除数据库某一列

 @param objectId 数据列表对应Key
 @param tableName 数据库表名
 */
- (void)deleteObjectById:(NSString *)objectId fromTable:(NSString *)tableName;


/**
 删除数据库多列

 @param objectIdArray 数据列表对应Key数组
 @param tableName 数据库表名
 */
- (void)deleteObjectsByIdArray:(NSArray *)objectIdArray fromTable:(NSString *)tableName;


/**
 删除对象的key前缀

 @param objectIdPrefix 对象的key前缀
 @param tableName 数据库表名
 */
- (void)deleteObjectsByIdPrefix:(NSString *)objectIdPrefix fromTable:(NSString *)tableName;

@end
