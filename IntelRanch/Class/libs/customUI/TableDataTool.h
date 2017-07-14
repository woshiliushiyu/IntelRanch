//
//  TableDataTool.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/8.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableDataTool : NSObject

/**
 插入数据

 @param tableData 数据
 */
+(BOOL)insertTableData:(NSMutableArray*)tableData Number:(NSString*)number;

/**
 根据索引查找数据

 @param number 索引
 @return 返回值
 */
+(NSMutableArray * )selectTableData:(NSString*)number;

/**
 删除数据

 @param number 索引
 @return 删除结果
 */
+(BOOL)deleteTableData:(NSString*)number;
@end
