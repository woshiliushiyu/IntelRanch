//
//  SelectRanchCell.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/10.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "SelectRanchCell.h"

@interface SelectRanchCell ()

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property(nonatomic,strong)UIView * tempView;
@end

@implementation SelectRanchCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self = [[NSBundle mainBundle] loadNibNamed:[NSString stringWithString:NSStringFromClass([self class])] owner:self options:nil].firstObject;
        self.backgroundColor = [UIColor clearColor];
        self.bgView.userInteractionEnabled = YES;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImage * bgImage = GetImage(@"weidianji");
        self.bgView.layer.contents = (__bridge id _Nullable)(bgImage.CGImage);
        self.bgView.layer.contentsRect = CGRectMake(0, 0, 1, 1);
    }
    return self;
}
-(void)setNameString:(NSString *)nameString
{
    _nameString = nameString;
    self.nameLabel.text = nameString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
