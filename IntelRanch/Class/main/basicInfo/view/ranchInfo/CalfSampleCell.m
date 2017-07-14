//
//  CalfSampleCell.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/5.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "CalfSampleCell.h"
#import "SampleCell.h"
@interface CalfSampleCell ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UIButton *settBtn;
@property (strong, nonatomic) IBOutlet UIView *bgTableView;

@property(nonatomic,strong)UITableView * subTableView;
@end

@implementation CalfSampleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self=[[NSBundle mainBundle] loadNibNamed:[NSString stringWithString:NSStringFromClass([self class])] owner:self options:nil].firstObject;
        self.backgroundColor = BGCOLOR;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addShadowToCell:self.bgView];
        
        [self.settBtn addTarget:self action:@selector(touchSetting) forControlEvents:UIControlEventTouchUpInside];
        
        [self.bgTableView addSubview:self.subTableView];
        [self.subTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.bgTableView);
        }];
    }
    return self;
}
-(void)touchSetting
{
    NSLog(@"进入犊牛样本");
    if (self.PushCalfSampleViewBlock) {
        self.PushCalfSampleViewBlock();
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
#pragma mark ==== delegate & datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SampleCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithString:NSStringFromClass([SampleCell class])]];
    if (!cell) {
        cell = [[SampleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithString:NSStringFromClass([SampleCell class])]];
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}

#pragma lazy=====
-(UITableView *)subTableView
{
    if (!_subTableView) {
        _subTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _subTableView.delegate = self;
        _subTableView.dataSource  =self;
        _subTableView.scrollEnabled = NO;
        _subTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _subTableView.tableFooterView = [UIView new];
    }
    return _subTableView;
}
@end
