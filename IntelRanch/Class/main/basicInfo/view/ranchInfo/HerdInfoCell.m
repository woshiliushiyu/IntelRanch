//
//  HerdInfoCell.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/5.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "HerdInfoCell.h"
#import "CoustomPieView.h"
@interface HerdInfoCell ()<PNChartDelegate>
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UILabel *breedLabel;
@property (strong, nonatomic) IBOutlet UIButton *settBtn;
@property (strong, nonatomic) IBOutlet UIView *pngView;

@end


@implementation HerdInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self=[[NSBundle mainBundle] loadNibNamed:[NSString stringWithString:NSStringFromClass([self class])] owner:self options:nil].firstObject;
        self.backgroundColor = BGCOLOR;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addShadowToCell:self.bgView];
        [self.settBtn addTarget:self action:@selector(touchSetting) forControlEvents:UIControlEventTouchUpInside];
        
        [self setupPnPig];
    }
    return self;
}
-(void)setupPnPig
{
//    这是测试数据
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:30 color:PNBrown description:@"cat"],[PNPieChartDataItem dataItemWithValue:20 color:PNDarkBlue description:@"pig"], [PNPieChartDataItem dataItemWithValue:50 color:PNGrey description:@"dog"]];
    
    PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake((CGFloat) (SCREEN_WIDTH / 2.0 - 105), 10, 150.0, 150.0) items:items];
    pieChart.delegate = self;
    pieChart.outerCircleRadius = 75.0f;
    pieChart.innerCircleRadius = 0;
    pieChart.legendStyle = 1;
    [pieChart strokeChart];
    [self.pngView addSubview:pieChart];
    
    UIView *legend = [pieChart getLegendWithMaxWidth:50];
    [self.pngView addSubview:legend];
    [legend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.pngView).offset(-20);
        make.bottom.mas_equalTo(self.pngView).offset(-20);
        make.width.mas_equalTo(legend.frame.size.width);
        make.height.mas_equalTo(legend.frame.size.height);
    }];
}
-(void)touchSetting
{
    NSLog(@"点击设置了");
    if (self.SelectSetBlock) {
        self.SelectSetBlock();
    }
}
-(void)addShadowToCell:(UIView*)bgView
{
    bgView.layer.shadowColor = [UIColor grayColor].CGColor;
    bgView.layer.shadowOpacity = 0.8f;
    bgView.layer.shadowOffset = CGSizeMake(0, 0);
    bgView.layer.shadowRadius = 5.0f;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
