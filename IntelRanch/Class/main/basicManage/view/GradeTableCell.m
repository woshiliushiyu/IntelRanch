//
//  GradeTableCell.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/21.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "GradeTableCell.h"
#import "AssessmentModel.h"
@interface GradeTableCell ()<JHGridViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *bgTableView;
@property (strong, nonatomic) IBOutlet UIButton *setBtn;

@property (strong, nonatomic) IBOutlet UIView *bgView;
@end


@implementation GradeTableCell

+(GradeTableCell *)setTableViewCustomCell:(UITableView*)tableView IndexPath:(NSIndexPath*)indexPath
{
    GradeTableCell * cell  = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithString:NSStringFromClass([self class])]];
    
    if (!cell) {
        
        cell = [[GradeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithString:NSStringFromClass([self class])]];
    }
    
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self = [[NSBundle mainBundle] loadNibNamed:[NSString stringWithString:NSStringFromClass([self class])] owner:self options:nil].firstObject;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.setBtn.touchAreaInsets = UIEdgeInsetsMake(10, 70, 10, 50);
        [self addShadowToCell:self.bgTableView];
    }
    return self;
}
-(void)setModel:(LayoutInfoModel *)model
{
    _model = model;

    NSMutableArray * dataArray = [[NSMutableArray alloc] init];
    
    NSArray * tempArray = model.editor.options;
    
    [tempArray enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSArray * stringArray = [obj componentsSeparatedByString:@"&"];
        
        AssessmentModel * model = [[AssessmentModel alloc] init];
        
        model.serial = stringArray[0];
        model.smell = stringArray[1];
        model.color = [obj isEqualToString:self.descriptString]?@"1":@"";
        
        [dataArray addObject:model];
        
    }];
    JHGridView * jhView = [[JHGridView alloc] initWithFrame:CGRectMake(0, 0, Width-60, dataArray.count*40+140)];
    jhView.delegate  = self;
    
    [jhView setTitles:@[@"脱水",@"症状",@"评估犊牛"] andObjects:dataArray withTags:@[@"serial",@"smell",@"color"]];
    [_bgView addSubview:jhView];
}
- (CGFloat)widthForColAtIndex:(long)index
{
    if (index==1) {
        
        return 150;
    }
    return (Width -210)/2;
}
-(UIFont *)fontForTitleAtIndex:(long)index
{
    return [UIFont systemFontOfSize:10.0f];
}
-(UIFont *)fontForGridAtGridIndex:(GridIndex)gridIndex
{
    return [UIFont systemFontOfSize:10.0f];
}
- (UIColor *)textColorForGridAtGridIndex:(GridIndex)gridIndex
{
    return RGBColor(121, 121, 121);
}
-(UIColor *)backgroundColorForTitleAtIndex:(long)index
{
    return BGCOLOR;
}
-(UIColor *)backgroundColorForGridAtGridIndex:(GridIndex)gridIndex
{
    return BGCOLOR;
}
- (UIColor *)textColorForTitleAtIndex:(long)index;
{
    return RGBColor(186, 186, 188);
}
- (CGFloat)heightForTitles
{
    return 25;
}
- (JHGridAlignmentType)gridViewAlignmentType
{
    return JHGridAlignmentTypeCenter;
}
- (IBAction)touchSetAction:(id)sender {
    
    self.SelectRowBlock();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)addShadowToCell:(UIView*)bgView
{
    bgView.layer.shadowColor = [UIColor grayColor].CGColor;
    bgView.layer.shadowOpacity = 0.8f;
    bgView.layer.shadowOffset = CGSizeMake(0, 0);
    bgView.layer.shadowRadius = 5.0f;
}
@end
