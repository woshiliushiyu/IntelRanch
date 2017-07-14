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
    NSArray * nameTables;
    NSArray * keys;
}
@property(nonatomic,strong)NSMutableArray * dataArray;
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UIView *bgTableView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableHeight;

@end

@implementation CattleInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        num = 1;
        
        self = [[NSBundle mainBundle] loadNibNamed:[NSString stringWithString:NSStringFromClass([self class])] owner:self options:nil].firstObject;
        self.backgroundColor = BGCOLOR;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        nameTables = @[@"序号",@"日龄",@"体重",@"体高",@"斜体长",@"胸围"];
        
        keys = @[@"number",@"dayNumber",@"weight",@"stature",@"bodyLenght",@"bush"];
        
        [self addShadowToCell:_bgView];
    }
    return self;
}
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
-(void)setIndex:(NSUInteger)index
{
    _index = index;
    
    if ([TableDataTool selectTableData:Str(_index)].count>0) {
        
        self.dataArray = [TableDataTool selectTableData:Str(_index)];
        
        _tableHeight.constant = 30*[TableDataTool selectTableData:Str(_index)].count+70;
        
    }else{
        
        [self.dataArray addObjectsFromArray:@[[[Sample alloc] initWithNumber:Str(1) DayNumber:@"0" Weight:@"0" Statyre:@"0" Body:@"0" Bush:@"0"]]];
        
        [TableDataTool insertTableData:self.dataArray Number:Str(_index)];
    }
    
    TableCellView * tableCellView = [[TableCellView alloc] initWithFrame:CGRectMake(0, 0, Width-60, ([TableDataTool selectTableData:Str(_index)].count*30)+70)];
    
    tableCellView.delegate = self;
    
    [tableCellView setTitles:nameTables andObjects:self.dataArray withTags:keys];
    
    [_bgTableView addSubview:tableCellView];
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
    num = self.dataArray.count+1;
    
    [self.dataArray addObjectsFromArray:@[[[Sample alloc] initWithNumber:Str(num) DayNumber:@"0" Weight:@"0" Statyre:@"0" Body:@"0" Bush:@"0"]]];
    
    [TableDataTool insertTableData:self.dataArray Number:Str(_index)];
    
    _tableHeight.constant =([TableDataTool selectTableData:Str(_index)].count*30);
    
    self.ReloadDataBlcok(_index);
}
-(void)selectRowSection:(NSInteger)line List:(NSInteger)list
{
    WeakifySelf();
    
    NSMutableArray * tempArray = [[NSMutableArray alloc] init];
    
    tempArray = [TableDataTool selectTableData:Str(_index)];
    
    if (tempArray.count>0) {
        
        NSMutableDictionary * sample =  [[tempArray objectAtIndex:line] toDictionary].mutableCopy;
        
        ZYInputAlertView *alertView = [ZYInputAlertView alertView];
        
        [alertView.inputTextView becomeFirstResponder];
        
        alertView.tipLabel.text = nameTables[list-1];
        
        alertView.placeholder = @"请输入修改数据";
        
        [alertView confirmBtnClickBlock:^(NSString *inputString) {
            
            NSLog(@"输出的数据%@",inputString);
            
            [TableDataTool deleteTableData:Str(_index)];
            
            [tempArray removeObjectAtIndex:line];
            
            [sample setObject:inputString forKey:keys[list-1]];
            
            [tempArray insertObject:[[Sample alloc] initWithDictionary:sample error:nil] atIndex:line];
            
            if ([TableDataTool insertTableData:tempArray Number:Str(_index)]) {
                
                weakSelf.ReloadDataBlcok(_index);
            }
        }];
        [alertView show];
    }
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
