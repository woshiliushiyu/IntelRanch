//
//  SampleCell.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/5.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "SampleCell.h"
#import "TableViewModel.h"
@interface SampleCell ()<JHGridViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *sampleLabel;
@property (strong, nonatomic) IBOutlet UIView *bgTableView;

@end


@implementation SampleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self=[[NSBundle mainBundle] loadNibNamed:[NSString stringWithString:NSStringFromClass([self class])] owner:self options:nil].firstObject;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        JHGridView * table = [[JHGridView alloc] initWithFrame:CGRectMake(0, 0, (Width-70), self.frame.size.height)];
        
        table.delegate = self;
        
        NSArray * array =@[ [[TableViewModel alloc] initWithAge:@"20" Weight:@"30cm" Heights:@"85cm" Length:@"160cm" Chest:@"120cm"]];
        
        [table setTitles:@[@"平均日龄",@"平均体重",@"平均体高",@"平均斜体长",@"平均胸围"] andObjects:array withTags:@[@"age",@"weight",@"height",@"length",@"chest"]];
        
        [_bgTableView addSubview:table];
        
        [table mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(_bgTableView);
        }];
    }
    return self;
}
#pragma mark====deleage===
-(UIFont *)fontForTitleAtIndex:(long)index
{
    return [UIFont systemFontOfSize:10.0f];
}
-(UIFont *)fontForGridAtGridIndex:(GridIndex)gridIndex
{
    return [UIFont systemFontOfSize:10.0f];
}
-(CGFloat)widthForColAtIndex:(long)index
{
    return (Width-70)/5;
}
-(CGFloat)heightForTitles
{
    return _bgTableView.frame.size.height/2;
}
-(CGFloat)heightForRowAtIndex:(long)index
{
    return self.frame.size.height/2;
}
- (UIColor *)textColorForGridAtGridIndex:(GridIndex)gridIndex
{
    return [UIColor grayColor];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
