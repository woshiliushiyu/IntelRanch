//
//  CoustomPieView.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/5.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "CoustomPieView.h"

@interface CoustomPieView ()<PNChartDelegate>

@end


@implementation CoustomPieView

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"周到 init方法了");
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *items = @[[PNPieChartDataItem dataItemWithValue:30 color:PNBrown description:@"cat"],[PNPieChartDataItem dataItemWithValue:20 color:PNDarkBlue description:@"pig"], [PNPieChartDataItem dataItemWithValue:50 color:PNGrey description:@"dog"]];
        
        PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(100, 100, 200, 200) items:items];
        
        pieChart.delegate = self;
        [pieChart strokeChart];
        // 加到父视图上
        [self addSubview:pieChart];
        
        // 显示图例
//        pieChart.hasLegend = YES;
        // 横向显示
        pieChart.legendStyle = PNLegendItemStyleSerial;
        // 显示位置
        pieChart.legendPosition = PNLegendPositionTop;
//        // 获得图例 当横向排布不下另起一行
//        UIView *legend = [pieChart getLegendWithMaxWidth:100];
//        legend.frame = CGRectMake(100, 300, legend.bounds.size.width, legend.bounds.size.height);
//        [self addSubview:legend];
    }
    return self;
}

@end
