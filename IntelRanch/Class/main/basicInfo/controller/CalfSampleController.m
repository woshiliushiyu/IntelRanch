//
//  CalfSampleController.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/7.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "CalfSampleController.h"
#import "CattleInfoCell.h"
#import "TableDataTool.h"
#import "Sample.h"
@interface CalfSampleController ()
{
    BOOL _isUpload;
    NSInteger _index;
    NSDictionary * _parameterDic;
}
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation CalfSampleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"犊牛样本";
    self.view.backgroundColor = BGCOLOR;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setupData];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(didNavBtnClick)];
}
- (void)didNavBtnClick {
    
    __block BOOL _isStop;
    
    NSArray * keys = @[@"number",@"days",@"weight",@"height",@"italic",@"bust"];
    
    [keys enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([_parameterDic[obj] isEqualToString:@""] | (_parameterDic == nil)) {
            
            [LCProgressHUD showInfoMsg:@"请完善信息之后上传"];
            
            _isStop = YES;
            
            return;
        }
    }];
    
    if (!_isStop) {
        
        NSMutableDictionary * parameterDic = [[NSMutableDictionary alloc] initWithDictionary:_parameterDic];
        
        [parameterDic setObject:Str(_index) forKey:@"type"];
        
        [[RequestTool sharedRequestTool] uploadWithCalfSampleParameter:parameterDic FinishedBlock:^(id result, NSError *error) {
            
            if ([result[@"status_code"] integerValue] == 200) {
                
                _isUpload = YES;
                
                [LCProgressHUD showSuccess:@"上传成功"];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self setupData];
                });
            }else{
                
                [LCProgressHUD showInfoMsg:result[@"message"]];
            }
        }];
    }
}
-(void)setupData
{
    [[RequestTool sharedRequestTool] requestWithSamplesListForServerFinishedBlock:^(id result, NSError *error) {
        
        if ([result[@"status_code"] integerValue] == 200) {
            
            NSMutableArray * pArray = [[NSMutableArray alloc] init];
            NSMutableArray * dArray = [[NSMutableArray alloc] init];
            
            for (NSDictionary * dic in result[@"data"]) {
                
                if (![dic[@"type"] integerValue]) {
                    
                    [pArray addObject:dic];
                }else{
                    
                    [dArray addObject:dic];
                }
            }
            [self.dataArray addObject:[[pArray reverseObjectEnumerator] allObjects]];
            [self.dataArray addObject:[[dArray reverseObjectEnumerator] allObjects]];

            [self.tableView reloadData];
            
            [LCProgressHUD hide];
            
        }else{
            [LCProgressHUD showMessage:result[@"message"]];
        }
    }];
}
#pragma mark ====   delegate ====
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count?2:0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CattleInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithString:NSStringFromClass([CattleInfoCell class])]];
    
    if (!cell) {
        
        cell = [[CattleInfoCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:[NSString stringWithString:NSStringFromClass([CattleInfoCell class])]];
    }
    cell.index = indexPath.row;
    cell.dataArray = self.dataArray[indexPath.row];
    cell.isUpload = _isUpload;
    cell.nameLabel.text = @[@"哺乳犊牛",@"断奶犊牛"][indexPath.row];
    cell.ReloadDataBlcok = ^(NSUInteger index) {
        
        _index = index;
        
        [self.tableView reloadData];
    };
    cell.PassDataBlcok = ^(NSDictionary *dataDic) {
        
        _parameterDic = dataDic;
    };
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * array = self.dataArray[indexPath.row];
    
    if (indexPath.row == 0) {

        return 150 + array.count*30;
    }else{
        
        return 150 + array.count*30;
    }
    return 150;
}
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isAdd"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
