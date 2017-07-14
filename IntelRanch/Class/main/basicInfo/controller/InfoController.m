//
//  InfoController.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/5.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "InfoController.h"
#import "RanchInfoCell.h"
#import "HerdInfoCell.h"
#import "CalfSampleCell.h"
#import "OtherAdjunctCell.h"
#import "AdjunctController.h"
#import "CalfSampleController.h"
#import "RanchInfoController.h"
#import "CattleInfoController.h"
#import "LayoutModel.h"
@interface InfoController ()
{
    CGFloat _cellHeight;
}
@property(nonatomic,strong)NSMutableArray * layoutArray;
@end

@implementation InfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = BGCOLOR;
    self.navigationItem.title = @"牧场基本信息";
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self getLayoutView];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(didNavBtnClick)];
}
- (void)didNavBtnClick {
    
    NSLog(@"上传");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//获取分页面布局信息
-(void)getLayoutView
{
    [[RequestTool sharedRequestTool] requestWithRanchBasicLayoutFinishedBlock:^(id result, NSError *error) {
        
        if ([result[@"status_code"] integerValue] == 200) {

            for (NSDictionary * dic in result[@"data"][@"groups"]) {
                
                LayoutModel * model = [[LayoutModel alloc] initWithDictionary:dic error:nil];
                
                [self.layoutArray addObject:model];
            }
        }else{
            
            [LCProgressHUD showFailure:result[@"message"]];
        }
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WeakifySelf()
    
    if (indexPath.row==0) {

        RanchInfoCell *cell = (RanchInfoCell *)[tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            
            cell = [[RanchInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithString:NSStringFromClass([RanchInfoCell class])]];
        }
        cell.headerLabel.text = @"牧场信息";
        
        cell.dataArray = [[NSMutableArray alloc] initWithObjects:@{@"name":@"你好"},@{@"name":@"你好"},@{@"name":@"你好"}, nil];
        
        cell.SelectRanchInfoBlock = ^{
            
            if (self.layoutArray.count>0) {
                
                [weakSelf pushNextView:[[RanchInfoController alloc] init] DataModel:self.layoutArray[indexPath.row]];
            }else{
                
                [weakSelf getLayoutView];
            }
        };
        
        return cell;
    }
    if (indexPath.row ==1) {

        HerdInfoCell *cell = (HerdInfoCell *)[tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
        
            cell = [[HerdInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithString:NSStringFromClass([HerdInfoCell class])]];
        }
        cell.SelectSetBlock = ^{
            
            if (self.layoutArray.count>0) {
                
                [weakSelf pushNextView:[[CattleInfoController alloc] init] DataModel:self.layoutArray[indexPath.row]];
            }else{
                
                [weakSelf getLayoutView];
            }
        };
        return cell;
    }
    if (indexPath.row ==2) {

        CalfSampleCell *cell = (CalfSampleCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        if (!cell) {
            
            cell = [[CalfSampleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithString:NSStringFromClass([CalfSampleCell class])]];
        }
        cell.PushCalfSampleViewBlock = ^{
            
            if (self.layoutArray.count>0) {
                
                [weakSelf pushNextView:[[CalfSampleController alloc] init] DataModel:self.layoutArray[indexPath.row]];
            }else{
                
                [weakSelf getLayoutView];
            }
        };
        return cell;
    }
    if (indexPath.row ==3) {

        OtherAdjunctCell *cell = (OtherAdjunctCell *)[tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            
            cell = [[OtherAdjunctCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithString:NSStringFromClass([OtherAdjunctCell class])]];
            
        }
        cell.TouchAddBlock = ^{
            
            if (self.layoutArray.count>0) {
                
                [weakSelf pushNextView:[[AdjunctController alloc] init] DataModel:self.layoutArray[indexPath.row]];
            }else{
                
                [weakSelf getLayoutView];
            }
        };
        _cellHeight = cell.cellHeight;
        
        return cell;
    }
    return NULL;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
        
        return 75+(25*3);
    }
    if (indexPath.row ==1) {
        
        return 270.0f;
    }
    if (indexPath.row == 2) {
        
        return 270.0f;
    }
    return 140.0f + _cellHeight;
}

-(void)pushNextView:(UIViewController *)vc DataModel:(LayoutModel*)model
{
    if ([vc isKindOfClass:[RanchInfoController class]]) {
        
        RanchInfoController * VC = (RanchInfoController *)vc;
        
        VC.dataArray = model.fields.mutableCopy;
    }
    if ([vc isKindOfClass:[CattleInfoController class]]) {
        
        CattleInfoController * VC = (CattleInfoController *)vc;
        
        VC.dataArray = model.fields.mutableCopy;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}
-(NSMutableArray *)layoutArray
{
    if (!_layoutArray) {
        
        _layoutArray = [[NSMutableArray alloc] init];
    }
    return _layoutArray;
}
@end
