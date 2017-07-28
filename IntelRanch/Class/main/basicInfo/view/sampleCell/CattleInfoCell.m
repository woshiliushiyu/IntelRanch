//
//  CattleInfoCell.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/8.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "CattleInfoCell.h"
#import "Sample.h"
#import "TableDataTool.h"

#import "TableCellView.h"
@interface CattleInfoCell ()<TableCellViewDelegate>
{
    NSUInteger num;
    NSUInteger n;
    NSArray * nameTables;
    NSArray * keys;
    
    TableCellView * tableView;
    NSInteger _line;
    NSMutableDictionary * tempDict;
}

@property(nonatomic,strong)NSMutableArray * outDataArray;
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UIView *bgTableView;


@end

@implementation CattleInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        num = 1;
        
        self = [[NSBundle mainBundle] loadNibNamed:[NSString stringWithString:NSStringFromClass([self class])] owner:self options:nil].firstObject;
        self.backgroundColor = BGCOLOR;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        nameTables = @[@"序号",@"日龄(d)",@"体重(kg)",@"体高(cm)",@"斜体长(cm)",@"胸围(cm)"];
        
        keys = @[@"number",@"days",@"weight",@"height",@"italic",@"bust"];
        
        tempDict = [[NSMutableDictionary alloc] initWithDictionary:@{@"number":Str(num),@"days":@"",@"weight":@"",@"height":@"",@"italic":@"",@"bust":@""}];
        
        [self addShadowToCell:_bgView];

    }
    return self;
}
-(void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    
    tableView = [[TableCellView alloc] initWithFrame:CGRectZero];
    
    tableView.delegate = self;
    
    [tableView setTitles:nameTables andObjects:dataArray withTags:keys];
    
    [_bgTableView addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self.bgTableView);
    }];
}
-(void)setIsUpload:(BOOL)isUpload
{
    _isUpload = isUpload;
}
-(void)setIndex:(NSUInteger)index
{
    _index = index;
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
-(void)selectAddBtn
{
    if (n != _index) {
        
        [LCProgressHUD showFailure:@"完成之后再次添加"];
        
        return;
    }

    __block BOOL _isStop;
    
    NSDictionary * dic = self.dataArray.lastObject;
    
    [keys enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([Str(dic[obj]) isEqualToString:@""]) {
            
            [LCProgressHUD showFailure:@"请完善信息"];
            
            _isStop = YES;
            
            return;
        }
    }];
    
    if (!_isUpload && _isStop) {
        
        [LCProgressHUD showInfoMsg:@"上传成功之后再次添加"];
        
        return;
    }
    
    if (!_isStop) {
    
        num++;
        
        [self.dataArray addObject:@{@"number":Str(self.dataArray.count+1),@"days":@"",@"weight":@"",@"height":@"",@"italic":@"",@"bust":@""}];
        
        tableView.dataArray = self.dataArray;
        
        [tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.edges.mas_equalTo(self.bgTableView);
        }];
    
        self.ReloadDataBlcok(_index);
        
        n = _index;
    }
}
-(void)selectRowSection:(NSInteger)line List:(NSInteger)list
{
    if (_line != line) {
        
        tempDict = [[NSMutableDictionary alloc] initWithDictionary:@{@"number":Str(self.dataArray.count+1),@"days":@"",@"weight":@"",@"height":@"",@"italic":@"",@"bust":@""}];
    }
    
    [self.dataArray removeObjectAtIndex:line];
    
    ZYInputAlertView *alertView = [ZYInputAlertView alertView];
    
    [alertView.inputTextView becomeFirstResponder];
    
    alertView.tipLabel.text = nameTables[list-1];
    
    alertView.placeholder = @"请输入修改数据";
    
    [alertView confirmBtnClickBlock:^(NSString *inputString) {
        
        [tempDict setObject:Str(line+1) forKey:@"number"];
        
        [tempDict removeObjectForKey:keys[list-1]];
        
        [tempDict setObject:inputString forKey:keys[list-1]];
        
        [self.dataArray insertObject:tempDict atIndex:line];
        
        tableView.dataArray = self.dataArray;
        
        [tableView reloadView];
    
        self.PassDataBlcok(tempDict);
    }];
    
    _line = line;
    
    [alertView show];
}
-(NSMutableArray *)outDataArray
{
    if (!_outDataArray) {
        
        _outDataArray = [[NSMutableArray alloc] init];
    }
    return _outDataArray;
}
-(NSInteger)fontWithRowText
{
    return 10.0f;
}
-(CGFloat)setRowHeight
{
    return 30.0f;
}
@end
