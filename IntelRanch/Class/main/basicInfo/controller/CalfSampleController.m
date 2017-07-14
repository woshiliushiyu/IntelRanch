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
@end

@implementation CalfSampleController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"犊牛样本";
    self.view.backgroundColor = BGCOLOR;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(didNavBtnClick)];
}
- (void)didNavBtnClick {
    
    NSLog(@"上传");
    
}
#pragma mark ====   delegate ====
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CattleInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithString:NSStringFromClass([CattleInfoCell class])]];
    
    if (!cell) {
        
        cell = [[CattleInfoCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:[NSString stringWithString:NSStringFromClass([CattleInfoCell class])]];
    }
    cell.index = indexPath.row;
    
    cell.ReloadDataBlcok = ^(NSUInteger index) {
        
        [self.tableView reloadData];
    };
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    return 140.0f+([TableDataTool selectTableData:Str(indexPath.row)].count*30)+([TableDataTool selectTableData:Str(indexPath.row)].count==0?45:0);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
