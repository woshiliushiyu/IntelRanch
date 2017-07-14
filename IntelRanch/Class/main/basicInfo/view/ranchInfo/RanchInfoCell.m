//
//  RanchInfoCell.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/5.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "RanchInfoCell.h"

@interface RanchInfoCell ()
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UILabel *lineLabel;
@property (strong, nonatomic) IBOutlet UIButton *settingBtn;

@property(nonatomic,strong)UIView * backView;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UILabel * detailLabel;
@end

@implementation RanchInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self=[[NSBundle mainBundle] loadNibNamed:[NSString stringWithString:NSStringFromClass([self class])] owner:self options:nil].firstObject;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addShadowToCell:self.bgView];
        [self.settingBtn addTarget:self action:@selector(touchSetting) forControlEvents:UIControlEventTouchUpInside];
        
        [self.bgView addSubview:self.backView];
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.lineLabel.mas_bottom).offset(10);
            make.left.mas_equalTo(self.bgView).offset(10);
            make.right.bottom.mas_equalTo(self.bgView).offset(-10);
        }];
    }
    return self;
}
-(void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    
    for (int i=0; i<dataArray.count; i++) {
        
        self.nameLabel = Label.fnt(14.0f).color(@"214,214,214").str(@"这是主键:");//.xywh(0,i*25,50,15);
        [self.backView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.backView);
            make.top.mas_equalTo(i*25);
            make.height.mas_equalTo(15);
        }];
        
        self.detailLabel = Label.fnt(14.0f).color(@"214,214,214").str(@"这是内容详情页");//.xywh(60,i*25,50,15);
        [self.backView addSubview:self.detailLabel];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLabel.mas_right).offset(10);
            make.top.mas_equalTo(i*25);
            make.height.mas_equalTo(15);
        }];
    }
}
-(void)touchSetting
{
    NSLog(@"点击设置了");
    if (self.SelectRanchInfoBlock) {
        self.SelectRanchInfoBlock();
    }
}
-(UIView *)backView
{
    if (!_backView) {
        
        _backView = View.bgColor(@"white");
    }
    return _backView;
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
