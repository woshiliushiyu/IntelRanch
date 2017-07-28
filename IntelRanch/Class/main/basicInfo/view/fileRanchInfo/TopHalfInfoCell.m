//
//  TopHalfInfoCell.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/7.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "TopHalfInfoCell.h"
#import "MOFSPickerManager.h"
@interface TopHalfInfoCell ()<UITextFieldDelegate>
{
    UITextField * _tempText;
}
@end

@implementation TopHalfInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self = [[NSBundle mainBundle] loadNibNamed:[NSString stringWithString:NSStringFromClass([self class])] owner:self options:nil].firstObject;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    [self.nameText resignFirstResponder];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
-(void)setModel:(LayoutInfoModel *)model
{
    _model = model;
    
    _nameLabel.text = model.title;
    
    if (![_model.editor.type isEqualToString:@"datetime"]) {
        
        if ([Str(_dataDict[model.name]) isEqualToString:@""] | [Str(_dataDict[model.name]) isEqualToString:@"0"]) {
            
            self.nameText.placeholder = [NSString stringWithFormat:@"请输入%@",model.title];
        }else{
            
            self.nameText.text = Str(_dataDict[model.name]);
        }
        [self addSubview:self.nameText];
        [self.nameText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
            make.left.mas_equalTo(self).offset(10);
            make.right.mas_equalTo(self).offset(-10);
            make.height.mas_equalTo(30);
        }];
    }else{
        
        if (![Str(_dataDict[model.name]) isEqualToString:@"0000-00-00 00:00:00"] && ![Str(_dataDict[model.name]) isEqualToString:@""] && _dataDict[model.name] !=nil) {
            
            [self.nameBtn setTitle:[Str(_dataDict[model.name]) componentsSeparatedByString:@" "][0] forState:UIControlStateNormal];
        }else{
            
            [self.nameBtn setTitle:@"请输入日期" forState:UIControlStateNormal];
        }
        
        [self addSubview:self.nameBtn];
        [self.nameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
            make.left.mas_equalTo(self).offset(10);
            make.right.mas_equalTo(self).offset(-10);
            make.height.mas_equalTo(30);
        }];
    }
    if ([model.editor.type isEqualToString:@"number"]) {
        
        _nameText.keyboardType = UIKeyboardTypePhonePad;
    }
}
-(void)setDataDict:(NSDictionary *)dataDict
{
    _dataDict = dataDict;
}
-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
    [self addSubview:self.nameLabel];
    
    self.nameText.delegate = self;
    self.nameText.backgroundColor = BGCOLOR;
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(10);
        
        if (indexPath.row == 0) {
            
            make.top.mas_equalTo(self).offset(10);
        }else{
            
            make.top.mas_equalTo(self);
        }
    }];
}
-(UITextField *)nameText
{
    if (!_nameText) {
        
        _nameText = TextField.insets(0,5,0,0).color(FONTCOL).fnt(15).onChange(^(NSString *text, UITextField *textField){
            
            self.FinishedBlock(textField.text,_indexPath.row);
            
        }).nextRetrunKey.borderRadius(5).onFinish(^(NSString *text){
            
            NSLog(@"完成是的获取%@",text);
        });
    }
    return _nameText;
}
-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        
        _nameLabel = Label.fnt(18).color(BIGCOL);
    }
    return _nameLabel;
}
-(UIButton *)nameBtn
{
    if (!_nameBtn) {
        
        _nameBtn = Button.insets(0,5,0,0).bgColor(BGCOLOR).str(@"请输入日期").color(FONTCOL).fnt(15).onClick(^(UIButton * btn){
            
            [self.superview endEditing:YES];
            
            NSDateFormatter *df = [NSDateFormatter new];
            
            df.dateFormat = @"yyyy-MM-dd";
            
            [[MOFSPickerManager shareManger] showDatePickerWithTag:1 commitBlock:^(NSDate *date) {
                
                [_nameBtn setTitle:[df stringFromDate:date] forState:UIControlStateNormal];
                
                self.FinishedBlock([df stringFromDate:date],_indexPath.row);
                
            } cancelBlock:^{}];
            
        }).borderRadius(5);
        
        _nameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _nameBtn;
}
@end
