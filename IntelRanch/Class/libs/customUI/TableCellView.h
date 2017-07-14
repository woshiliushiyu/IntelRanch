//
//  TableCellView.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/8.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TableCellViewDelegate <NSObject>

-(NSInteger)fontWithRowText;

-(CGFloat)setRowHeight;

-(void)selectAddBtn;

-(void)selectRowSection:(NSInteger)line List:(NSInteger)list;

@end

@interface TableCellView : UIView
@property (nonatomic) id<TableCellViewDelegate> delegate;
-(void)setTitles:(NSArray *)titles andObjects:(NSArray *)objects withTags:(NSArray *)tags;
@end
