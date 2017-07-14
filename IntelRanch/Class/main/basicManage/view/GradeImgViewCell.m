//
//  GradeImgViewCell.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/13.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "GradeImgViewCell.h"

@implementation GradeImgViewCell

+(GradeImgViewCell *)setTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath
{
    GradeImgViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithString:NSStringFromClass([self class])]];
    
    if (!cell) {
        cell = [[GradeImgViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithString:NSStringFromClass([self class])]];
    }
    
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
