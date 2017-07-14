//
//  CalfManageController.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/11.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "CalfManageController.h"
#import "AdjunctController.h"
#import "OtherAdjunctCell.h"
#import "DetailController.h"
#import "RanchInfoCell.h"
#import "GradeViewCell.h"
@interface CalfManageController ()
{
    CGFloat _cellHeight;
}
@end

@implementation CalfManageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = BGCOLOR;
    self.navigationItem.title = @"犊牛疾病管理";
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(didNavBtnClick)];
}
- (void)didNavBtnClick {
    
    NSLog(@"上传");
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

    return 7;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    WeakifySelf();
    
    if (indexPath.row == 6) {
        
        OtherAdjunctCell *cell = (OtherAdjunctCell *)[tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            
            cell = [[OtherAdjunctCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithString:NSStringFromClass([OtherAdjunctCell class])]];
            
        }
        cell.TouchAddBlock = ^{
            
            [weakSelf.navigationController pushViewController:[[AdjunctController alloc] init] animated:YES];
        };
        _cellHeight = cell.cellHeight;
        
        return cell;
    }
    if (indexPath.row == 2) {
        
        GradeViewCell * cell = [GradeViewCell setTableViewCustomCell:tableView IndexPath:indexPath];
        
        return cell;
        
    }
    
    RanchInfoCell *cell = (RanchInfoCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        
        cell = [[RanchInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithString:NSStringFromClass([RanchInfoCell class])]];
    }
    cell.headerLabel.text = @"牧场信息";
    
    cell.dataArray = [[NSMutableArray alloc] initWithObjects:@{@"name":@"你好"},@{@"name":@"你好"},@{@"name":@"你好"}, nil];
    
    cell.SelectRanchInfoBlock = ^{
        
        [self.navigationController pushViewController:[[DetailController alloc] init] animated:YES];
        
    };
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==6) {
        
        return 140.0f + _cellHeight;
    }
    if (indexPath.row == 2) {
        
        return 180;
    }
    
    return 75+(25*3);
}



@end
