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
@property(nonatomic,strong)NSMutableArray * selectBtnArray;
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
        
        self.mBtn = Button.xywh(0, self.isFold?i*60:i*30, Width-60,self.isFold?60:30).str(names[i]).img(@"touming").selectedImg(@"duihao").fnt(15).color(FONTCOL).bgColor(BGCOLOR).borderRadius(3).tg(100+i).border(1,@"white").onClick(^(UIButton * mBtn){
            

        });
        [self.mBtn addTarget:self action:@selector(touAddBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        if (self.isFold) {
            self.mBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            self.mBtn.titleLabel.lines(0);
        }
        
        if ([self.dataDict[_model.name] rangeOfString:@","].location == NSNotFound) {
            
            if ([names[i] isEqualToString:Str(self.dataDict[self.model.name])]) {
                
                self.mBtn.selected = YES;
                
                self.tempBtn = self.mBtn;
                
                [self.tempArray addObject:names[i]];
            }
        }else{
            NSArray * array = [self.dataDict[_model.name] componentsSeparatedByString:@","];
            
            [array enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([names[i] isEqualToString:obj]) {
                    
                    self.mBtn.selected = YES;
                    
                    self.tempBtn = self.mBtn;
                    
                    [self.tempArray addObject:names[i]];
                }
            }];
        }
        
        self.mBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.mBtn setImageEdgeInsets:UIEdgeInsetsMake(5, self.mBtn.frame.size.width-30, 5, 10)];
        [self.mBtn setTitleEdgeInsets:UIEdgeInsetsMake(5, -10, 5, 30)];
        [self.selectView addSubview:self.mBtn];
        [self.selectBtnArray addObject:self.mBtn];
    }
}
-(void)touAddBtn:(UIButton *)mBtn
{
    if (![self.model.editor.type isEqualToString:@"checkbox"]) {
        
        if (!mBtn.selected) {
            
            self.tempBtn.selected = NO;
            
            [self.tempArray removeAllObjects];
            
            [self.tempArray addObject:_model.editor.options[mBtn.tag-100]];
            
        }else{
            
            //                    weakSelf.tempBtn = self.mBtn;
            
            self.tempBtn.selected = NO;
            
            return;
        }
    }else{
        
        if ([self.tempArray containsObject:_model.editor.options[mBtn.tag-100]]) {
            
            [self.tempArray removeObject:_model.editor.options[mBtn.tag-100]];
            
        }else{
            
            [self.tempArray addObject:_model.editor.options[mBtn.tag-100]];
        }
    }
    self.FinishedBlock(self.tempArray,self.index);
    
    mBtn.selected = !mBtn.selected;
    
    self.tempBtn = mBtn;
    
    [self.superview endEditing:YES];
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
-(void)setDataDict:(NSDictionary *)dataDict
{
    _dataDict = dataDict;
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
-(NSMutableArray *)selectBtnArray
{
    if (!_selectBtnArray) {
        
        _selectBtnArray = [[NSMutableArray alloc] init];
    }
    return _selectBtnArray;
}
@end
