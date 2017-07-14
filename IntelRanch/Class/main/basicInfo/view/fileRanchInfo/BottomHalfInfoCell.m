//
//  BottomHalfInfoCell.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/7.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "BottomHalfInfoCell.h"

@interface BottomHalfInfoCell ()
@property(nonatomic,strong)UIImageView * tempImage;
@property(nonatomic,strong)NSMutableArray * tempArray;;
@property(nonatomic,strong)NSMutableArray * selectArray;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UIView * selectView;

@property(nonatomic,strong)UIButton * mBtn;

@property(nonatomic,strong)UIButton * tempBtn;
@end

@implementation BottomHalfInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
-(void)addRowView
{
    WeakifySelf();
    NSArray * names = _model.editor.options;
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.selectView];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self);
    }];
    
    [self.selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self).offset(10);
        make.bottom.right.mas_equalTo(self).offset(-10);
    }];
    
    for (int i=0; i<names.count; i++) {
        
        self.mBtn = Button.xywh(0, i*30, Width-60,30).str(names[i]).img(@"shouji").selectedImg(@"mima").fnt(15).color(FONTCOL).bgColor(BGCOLOR).borderRadius(3).tg(100+i).border(1,@"white").onClick(^(UIButton * mBtn){
            
            if ([weakSelf.model.editor.rows integerValue]==1) {
                
                if (!mBtn.selected) {

                    weakSelf.tempBtn.selected = NO;

                    [weakSelf.tempArray removeAllObjects];
                    
                    [weakSelf.tempArray addObject:names[i]];
                }else{
                    return;
                }
            }else{
                
                [weakSelf.tempArray addObject:names[i]];
            }
            weakSelf.FinishedBlock(weakSelf.tempArray,weakSelf.index);
            
            mBtn.selected = !mBtn.selected;
            
            self.tempBtn = mBtn;
        });
        self.mBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.mBtn setImageEdgeInsets:UIEdgeInsetsMake(5, self.mBtn.frame.size.width-30, 5, 10)];
        [self.mBtn setTitleEdgeInsets:UIEdgeInsetsMake(5, -10, 5, 0)];
        [self.selectView addSubview:self.mBtn];
    }
}

-(void)setModel:(LayoutInfoModel *)model
{
    _model = model;
    self.nameLabel.text = model.title;
    [self addRowView];
}
-(void)setIndex:(NSInteger)index
{
    _index = index;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
-(NSMutableArray *)tempArray
{
    if (!_tempArray) {
        
        _tempArray = [[NSMutableArray alloc] init];
    }
    return _tempArray;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        
        _nameLabel = Label.fnt(18).color(BIGCOL);
    }
    return _nameLabel;
}
-(UIView *)selectView
{
    if (!_selectView) {
        
        _selectView = [[UIView alloc] initWithFrame:CGRectZero];
        
        _selectView.backgroundColor = [UIColor whiteColor];
    }
    return _selectView;
}

@end
