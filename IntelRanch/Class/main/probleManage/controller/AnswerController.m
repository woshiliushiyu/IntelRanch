//
//  AnswerController.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/19.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "AnswerController.h"
#import "TeamCustomCell.h"
@interface AnswerController ()

@end

@implementation AnswerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"回答详情";
    self.tableView.backgroundColor = BGCOLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TeamCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];

    if (!cell) {
        
        cell = [[TeamCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    CommentInfoModel * model = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.nameLabel.text = model.user_name;
    [cell.iconView sd_setImageWithURL:[NSURL URLWithString:model.user_avatar_url] placeholderImage:[UIImage imageNamed:@"ywjf"]];
    cell.describeLabel.text = model.summary;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
