//
//  GradeDataTool.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/24.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "GradeDataTool.h"

@implementation GradeDataTool
static FMDatabase *_db;

+ (void)initialize
{
    // 1.获得数据库文件的路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *filename = [doc stringByAppendingPathComponent:@"grade.sql"];
    
    // 2.得到数据库
    _db = [FMDatabase databaseWithPath:filename];
    
    // 3.打开数据库
    if ([_db open]) {
        
        BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_home_status (id integer PRIMARY KEY AUTOINCREMENT, number text NOT NULL,tableData blob NOT NULL);"];
        
        if (result) {
            NSLog(@"成功创表");
        } else {
            NSLog(@"创表失败");
        }
    }
}
+(BOOL)insertTableData:(NSMutableArray *)tableData Number:(NSString *)number
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:tableData];
    
    BOOL b = [ _db executeUpdate:@"insert into t_home_status(number,tableData)values(?,?)",number,data];
    
    if (!b) {
        NSLog(@"插入数据失败");
        return NO;
    }else{
        NSLog(@"插入数据成功");
        return YES;
    }
}
+(NSMutableArray *)selectTableData:(NSString *)number
{
    NSMutableArray * mutable = [[NSMutableArray alloc] init];
    
    NSString * sql = [NSString stringWithFormat:@"select * from t_home_status where number = '%@' ",number];
    
    FMResultSet * result = [_db executeQuery:sql];
    
    while ([result next]) {
        
        NSData * data = [result objectForColumnName:@"tableData"];
        
        mutable = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return mutable;
}
+(BOOL)deleteTableData:(NSString *)number
{
    NSString * tablename = [NSString stringWithFormat:@"delete from t_home_status where number = '%@'",number];
    
    BOOL b = [_db executeUpdate:tablename];
    if (!b) {
        return NO;
    }
    return YES;
}
@end
