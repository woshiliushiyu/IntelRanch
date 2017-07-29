//
//  ShitController.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/26.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "ShitController.h"
#import "TableCellView.h"
#import "AssessmentModel.h"
#import "TableDataTool.h"
#import "SicknessModel.h"
@interface ShitController ()<TableCellViewDelegate>
{
    TableCellView * tableView;
    NSInteger num;
    NSInteger _line;
    BOOL _isUpload;
    NSMutableDictionary * tempDict;
}
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * shitArray;
@property (strong, nonatomic) IBOutlet UILabel *lineLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightCell;

@end

@implementation ShitController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addShadowToCell:self.bgView];
    
    tempDict = [[NSMutableDictionary alloc] init];
    
    num = 1;
    
    [self.descriptArray enumerateObjectsUsingBlock:^(SicknessModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if ([model.type integerValue] == 2) {
            
            NSMutableDictionary * tempDicts = [[NSMutableDictionary alloc] init];
            
            [tempDicts setValue:Str(idx+1) forKey:@"serial"];
            [tempDicts setValue:model.value1 forKey:@"small"];
            [tempDicts setValue:model.value2 forKey:@"color"];
            
            [self.shitArray addObject:tempDicts];
        }
    }];
    
    [self.dataArray addObjectsFromArray:self.shitArray];
//    Str(self.shitArray.count+1)
    [self.dataArray addObject:@{@"serial":@"样本",@"small":@"",@"color":@""}];
    
    tableView = [[TableCellView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.lineLabel.frame)+10, Width-60, 90+(self.shitArray.count*30))];
    
    _heightCell.constant = 170.0f+(self.shitArray.count*30);
    
    [tableView setTitles:@[@"序号",@"气味",@"颜色"] andObjects:self.dataArray withTags:@[@"serial",@"small",@"color"]];
    
    tableView.delegate = self;
    
    [self.bgView addSubview:tableView];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(didNavBtnClick)];
}
- (void)didNavBtnClick {
    
    NSDictionary * lastDic = self.dataArray.lastObject;
    
    if ([lastDic[@"small"] isEqualToString:@""] || [lastDic[@"color"] isEqualToString:@""]) {
        
        [LCProgressHUD showFailure:@"请完善信息后上传"];
        
        return;
    }
    
    [[RequestTool sharedRequestTool] requestWithScoreForServer:@"" Sickness:self.idString Code:Str(arc4random()%2) Type:2 Value1:lastDic[@"small"] Value2:lastDic[@"color"] FinishedBlock:^(id result, NSError *error) {
        
        if ([result[@"status_code"] integerValue] == 200) {
            
            _isUpload = YES;
            
            [LCProgressHUD showMessage:@"提交成功"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else{
            [LCProgressHUD showMessage:result[@"message"]];
        }
    }];
}
-(NSInteger)fontWithRowText
{
    return 20;
}

-(CGFloat)setRowHeight
{
    return 30.0f;
}

-(void)selectAddBtn
{
    NSDictionary * lastDic = self.dataArray.lastObject;
    
    if ([lastDic[@"small"] isEqualToString:@""] || [lastDic[@"color"] isEqualToString:@""]) {
        
        [LCProgressHUD showFailure:@"请完善信息后添加"];
        
        return;
    }
    if (!_isUpload) {
        
        [LCProgressHUD showFailure:@"上传之后再次添加"];
        
        return;
    }
    num++;
    
    [self.dataArray addObject:@{@"serial":@"样本",@"small":@"",@"color":@""}];
    
    tableView.dataArray = self.dataArray;
    
    tableView.frame = CGRectMake(10, CGRectGetMaxY(self.lineLabel.frame)+10, Width-60, 30*self.dataArray.count+60);
    
    _heightCell.constant += 30;
}

-(void)selectRowSection:(NSInteger)line List:(NSInteger)list
{
    
    if (_line != line) {
        
        tempDict = [[NSMutableDictionary alloc] init];
    }
    
    ZYInputAlertView *alertView = [ZYInputAlertView alertView];
    
    [alertView.inputTextView becomeFirstResponder];
    
    alertView.tipLabel.text = @[@"序号",@"气味",@"颜色"][list-1];
    
    alertView.placeholder = @"请输入修改数据";
    
    [alertView confirmBtnClickBlock:^(NSString *inputString) {
        
        [self.dataArray removeObjectAtIndex:line];
        
        [tempDict setObject:Str(line+1) forKey:@"serial"];
        
        [tempDict setObject:inputString forKey:@[@"serial",@"small",@"color"][list-1]];
        
        [self.dataArray insertObject:tempDict atIndex:line];
        
        NSLog(@"输出数据源===%@   tempArray===>%@",self.dataArray,tempDict);
        
        tableView.dataArray = self.dataArray;
            
        [tableView reloadView];
    }];
    
    _line = line;
    
    [alertView show];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setDescriptArray:(NSMutableArray *)descriptArray
{
    _descriptArray = descriptArray;
}
-(void)addShadowToCell:(UIView*)bgView
{
    bgView.layer.shadowColor = [UIColor grayColor].CGColor;
    bgView.layer.shadowOpacity = 0.8f;
    bgView.layer.shadowOffset = CGSizeMake(0, 0);
    bgView.layer.shadowRadius = 5.0f;
}
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
-(NSMutableArray *)shitArray
{
    if (!_shitArray) {
        
        _shitArray = [[NSMutableArray alloc] init];
    }
    return _shitArray;
}
@end
