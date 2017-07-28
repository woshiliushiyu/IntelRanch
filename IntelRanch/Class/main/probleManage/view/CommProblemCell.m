//
//  CommProblemCell.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/25.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "CommProblemCell.h"

@interface CommProblemCell ()
@property (strong, nonatomic) IBOutlet UIView *bgView;

@end


@implementation CommProblemCell

+(CommProblemCell*)setTableView:(UITableView*)tableView IndexPath:(NSIndexPath*)index
{
    CommProblemCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithString:NSStringFromClass([self class])]];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithString:NSStringFromClass([self class])]];
    }
    
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self=  [[NSBundle mainBundle] loadNibNamed:[NSString stringWithString:NSStringFromClass([self class])] owner:self options:nil].lastObject;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addShadowToCell:self.bgView];
        
        self.descriptlabel.layer.masksToBounds = YES;
        self.descriptlabel.layer.cornerRadius = 5.0f;
        
        
    }
    return self;
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
