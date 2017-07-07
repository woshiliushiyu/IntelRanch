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
@property (strong, nonatomic) IBOutlet UILabel *ranchName;
@property (strong, nonatomic) IBOutlet UILabel *ranchAddress;
@property (strong, nonatomic) IBOutlet UILabel *createTime;
@property (strong, nonatomic) IBOutlet UILabel *areaNumber;
@property (strong, nonatomic) IBOutlet UILabel *uildLabel;
@property (strong, nonatomic) IBOutlet UIButton *settingBtn;

@end

@implementation RanchInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self=[[NSBundle mainBundle] loadNibNamed:[NSString stringWithString:NSStringFromClass([self class])] owner:self options:nil].firstObject;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addShadowToCell:self.bgView];
        [self.settingBtn addTarget:self action:@selector(touchSetting) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
-(void)touchSetting
{
    NSLog(@"点击设置了");
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
