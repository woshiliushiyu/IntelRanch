//
//  AccountController.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/20.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "AccountController.h"
#import "AccountCustomCell.h"
#import "LoginInfoModel.h"
@interface AccountController ()
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation AccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"账号信息";
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    [self.tableView registerClass:[AccountCustomCell class] forCellReuseIdentifier:@"reuseIdentifier"];
}
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AccountCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    
    MyRanchInfoModel * model = [[MyRanchInfoModel alloc] initWithDictionary:[LocalDataTool getDataToDataName:[NSString stringWithString:NSStringFromClass([MyRanchInfoModel class])]] error:nil];
    
    LoginInfoModel * loginInfo = [ LoginInfoModel getLoginInfoModel];
    
    cell.nameLabel.text = @[@"牧场名称:",@"牧场地址:",@"联系电话:"][indexPath.row];
    
    cell.mobile = loginInfo.mobile;
    
    if (indexPath.row == 2) {
        
        cell.phoneBtn.hidden = NO;
        cell.titleLabel.hidden = YES;
        [cell.phoneBtn setTitle:loginInfo.mobile forState:UIControlStateNormal];
        
    }else if (indexPath.row == 1) {
        cell.titleLabel.text = model.address;
    }else{
        cell.titleLabel.text = model.name;
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
