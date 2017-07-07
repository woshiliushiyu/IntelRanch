//
//  SudokuView.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/6.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SudokuView : UIView
- (instancetype)initWithFrame:(CGRect)frame Imgs:(NSMutableArray*)imgs;
@property(nonatomic,assign)CGFloat itemHeight;
@end
