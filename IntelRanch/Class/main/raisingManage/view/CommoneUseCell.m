
//
//  CommoneUseCell.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/25.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "CommoneUseCell.h"

@implementation CommoneUseCell

+(CommoneUseCell*)setTableView:(UITableView*)tableView IndexPath:(NSIndexPath*)index
{
    CommoneUseCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithString:NSStringFromClass([self class])]];
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
        
    }
    return self;
}
-(void)setTimeString:(NSString *)timeString
{
    _timeString = timeString;
    
    NSArray * array = [timeString componentsSeparatedByString:@" "];
    
    NSArray * days = [array[0] componentsSeparatedByString:@"-"];
    
    self.dayLabel.text = days[2];
    
    self.yearLabel.text = [NSString stringWithFormat:@"%@-%@",days[0],days[1]];
    
    NSArray * times = [array[1] componentsSeparatedByString:@":"];
    
    self.mmLabel.text = [times[0] integerValue] >12?@"PM":@"AM";
    
    self.timeLabel.text = array[1];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
