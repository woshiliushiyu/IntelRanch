//
//  SelectTableView.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/13.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectTableView : UIView

/**
 创建表格

 @param titles 表格头
 @param subTitles 表格副标题
 @param bodys 表格数据
 @param select 是否能选择
 @param footerView 底图
 */
- (instancetype)initWithTitles:(NSArray*)titles SubTitles:(NSArray*)subTitles TableBody:(NSArray*)bodys Select:(BOOL)select FooterView:(NSArray *)footerView;

@property(nonatomic,copy)BOOL (^SelectRowBlock)(NSInteger line,NSInteger row);

@property(nonatomic,copy)void (^BackHeightBlock)();

@property(nonatomic,copy)void (^SelectAddBlock)();

@property(nonatomic,strong)NSArray * bodyArray;

@property(nonatomic,strong)NSArray * subTitleArray;
@end
