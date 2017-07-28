//
//  HerdInfoCell.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/5.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "HerdInfoCell.h"
#import "CoustomPieView.h"
#import "LayoutInfoModel.h"
@interface HerdInfoCell ()<PNChartDelegate>
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UILabel *breedLabel;
@property (strong, nonatomic) IBOutlet UIButton *settBtn;
@property (strong, nonatomic) IBOutlet UIView *pngView;
@property (strong, nonatomic) IBOutlet UILabel *calfVary;

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
    }
    return self;
}
-(void)setModel:(LayoutModel *)model
{
    _model = model;
    
    NSInteger sum = 0;

    NSArray * array = model.fields;
    
    self.calfVary.hidden = NO;
    
    self.breedLabel.hidden = NO;
    
    self.settBtn.hidden = NO;
    
    NSMutableArray * itemsArray = [[NSMutableArray alloc] init];
    
    NSDictionary * dic = [LocalDataTool getDataToDataName:[NSString stringWithString:NSStringFromClass([MyRanchInfoModel class])]];
    
    if ([dic[@"zts"] isKindOfClass:[NSNull class]] || dic[@"zts"] == 0) {
        
        return;
    }

    for (int i=0; i<array.count; i++) {
        
        LayoutInfoModel * model = array[i];
        
        if (i>=2) {
            
            int R = (arc4random() % 256) ;
            int G = (arc4random() % 256) ;
            int B = (arc4random() % 256) ;
            
            if (sum == 0) {
                return;
            }
            
            float  num = (float)[dic[model.name] integerValue]/sum;
            
            PNPieChartDataItem * item = [PNPieChartDataItem dataItemWithValue:num*100 color:[UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1] description:model.title];
            
            [itemsArray addObject:item];
            
        }else if (i==1){
            
            sum = [dic[model.name] integerValue];
            
            if (sum == 0) {
                
                return;
            }
        }else{
            
            self.breedLabel.text = dic[model.name];
        }
    }
    [self setupPnPig:itemsArray];
}
-(void)setupPnPig:(NSArray *)items
{
//    这是测试数据
    PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake((CGFloat) (SCREEN_WIDTH / 2.0 - 155), 10, 150.0, 150.0) items:items];
    pieChart.delegate = self;
    pieChart.descriptionTextFont = [UIFont systemFontOfSize:9.0f];
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
