//
//  ShitViewCell.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/26.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "ShitViewCell.h"
#import "TableCellView.h"

@interface ShitViewCell ()
@property (strong, nonatomic) IBOutlet UIView *bgView;

@end


@implementation ShitViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].firstObject;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        TableCellView * tableView = [[TableCellView alloc] initWithFrame:CGRectZero];
        
        [tableView setTitles:@[@"序号",@"气味",@"颜色"] andObjects:@[] withTags:@[]];
        
        [self.bgView addSubview:tableView];
        
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.bgView);
        }];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
