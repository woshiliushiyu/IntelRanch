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
        

    }
    return self;
}
-(void)setModel:(CalfSampleModel *)model
{
    _model = model;
    
    JHGridView * table = [[JHGridView alloc] initWithFrame:CGRectMake(0, 0, (Width-70), self.frame.size.height)];
    
    table.delegate = self;
    
    NSMutableArray * array = [[NSMutableArray alloc] init];
    
    [array addObject:model];
    
    [table setTitles:@[@"日龄",@"体重",@"体高",@"斜体长",@"胸围"] andObjects:array withTags:@[@"days",@"weight",@"height",@"italic",@"bust"]];
    
    [_bgTableView addSubview:table];
    
    [table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(_bgTableView);
    }];
}
-(void)setAssessModel:(AssessmentModel *)assessModel
{
    _assessModel = assessModel;
    
    JHGridView * table = [[JHGridView alloc] initWithFrame:CGRectMake(0, 0, (Width-70), self.frame.size.height)];
    
    table.delegate = self;
    
    NSMutableArray * array = [[NSMutableArray alloc] init];
    
    [array addObject:assessModel];
    
    [table setTitles:@[@"序号",@"气味",@"颜色"] andObjects:array withTags:@[@"serial",@"smell",@"color"]];
    
    [_bgTableView addSubview:table];
    
    [table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(_bgTableView);
    }];
}
-(void)setAssessArray:(NSMutableArray *)assessArray
{
    _assessArray = assessArray;
    
    JHGridView * table = [[JHGridView alloc] initWithFrame:CGRectMake(0, 0, (Width-70), self.frame.size.height)];
    
    table.delegate = self;
    
    [table setTitles:@[@"序号",@"气味",@"颜色"] andObjects:assessArray withTags:@[@"serial",@"smell",@"color"]];
    
    [_bgTableView addSubview:table];
    
    [table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(_bgTableView);
    }];
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
-(UIColor *)backgroundColorForTitleAtIndex:(long)index
{
    return BGCOLOR;
}
-(UIColor *)backgroundColorForGridAtGridIndex:(GridIndex)gridIndex
{
    return BGCOLOR;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
