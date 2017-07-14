//
//  GradeViewCell.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/13.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "GradeViewCell.h"
#import "SelectTableView.h"

@interface GradeViewCell ()
@property (strong, nonatomic) IBOutlet UIView *bgRootView;

@property (strong, nonatomic) IBOutlet UIView *bgView;
@end

@implementation GradeViewCell
+(GradeViewCell *)setTableViewCustomCell:(UITableView*)tableView IndexPath:(NSIndexPath*)indexPath
{
    GradeViewCell * cell  = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithString:NSStringFromClass([self class])]];
    
    if (!cell) {
        
        cell = [[GradeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithString:NSStringFromClass([self class])]];
    }
    
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self = [[NSBundle mainBundle] loadNibNamed:[NSString stringWithString:NSStringFromClass([self class])] owner:self options:nil].firstObject;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addShadowToCell:self.bgRootView];
        
        SelectTableView * mView = [[SelectTableView alloc] initWithTitles:@[@"评分",@"0分",@"0分",@"0分"] SubTitles:@[@"温度范围",@"37.8~38.8",@"37.8~38.8",@"37.8~38.8"] TableBody:@[@[@"",@"1",@"",@""]] Select:NO FooterView:nil];
        
        mView.SelectRowBlock = ^(NSInteger line, NSInteger row) {
            
        };
        
        [self.bgView addSubview:mView];
        [mView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(_bgView);
        }];
    }
    return self;
}
- (IBAction)touchPush:(id)sender {
    
    
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
