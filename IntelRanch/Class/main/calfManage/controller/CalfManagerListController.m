//
//  CalfManagerListController.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/20.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "CalfManagerListController.h"
#import "CalfManagerModel.h"
#import "CalfManagerController.h"
#import "RanchInfoController.h"
#import "LayoutModel.h"
#import "LayoutInfoModel.h"
#import "CommoneUseCell.h"
@interface CalfManagerListController ()
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * layoutArray;
@end

@implementation CalfManagerListController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView.mj_header beginRefreshing];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"新生日志";
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    self.tableView.backgroundColor = BGCOLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self requestLayoutData];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self requestLayoutData];
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"创建" style:UIBarButtonItemStylePlain target:self action:@selector(didNavBtnClick)];
}
- (void)didNavBtnClick {
    
    LayoutModel * model = self.layoutArray[0];
    
    RanchInfoController * createView = [[RanchInfoController alloc] init];
    
    createView.dataArray = model.fields.mutableCopy;
    
    createView.navigationItem.title = @"创建新生日志";
    
    createView.typeString = Str(2);
    
    [self.navigationController pushViewController:createView animated:YES];
}
-(void)requestLayoutData
{
    [[RequestTool sharedRequestTool] requestWithRanchBasicLayoutTo:2 FinishedBlock:^(id result, NSError *error) {
        
        [self.layoutArray removeAllObjects];
        
        if ([result[@"status_code"] integerValue] == 200) {
            
            for (NSDictionary * entity in result[@"data"][@"groups"]) {
                
                LayoutModel * model = [[LayoutModel alloc] initWithDictionary:entity error:nil];
                
                [self.layoutArray addObject:model];
            }
            [self requestData];
            
        }else{
            
            [LCProgressHUD showMessage:result[@"message"]];
        }
        [self.tableView.mj_header endRefreshing];
    }];
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(void)requestData
{
    [[RequestTool sharedRequestTool] requestWithCalfManagerListToserverId:2 FinishedBlock:^(id result, NSError *error) {
       
        [self.dataArray removeAllObjects];
        
        if ([result[@"status_code"] integerValue] == 200) {
            
            for (NSDictionary * entity in result[@"data"]) {
                
                CalfManagerModel * model = [[CalfManagerModel alloc] initWithDictionary:entity error:nil];
                
                [self.dataArray addObject:model];
            }
            
            [LCProgressHUD hide];
            
            if (self.dataArray.count==0) {
                
                UIImage * image = GetImage(@"defult");
                self.view.layer.contents = (__bridge id _Nullable)(image.CGImage);
                self.view.layer.contentsRect = CGRectMake(0, 0, 1, 1);
            }else{
                self.view.layer.contents = nil;
            }
            
            [self.tableView reloadData];
            
            [self.tableView.mj_header endRefreshing];
            
        }else{
            [LCProgressHUD showMessage:result[@"message"]];
        }
    }];
}
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
-(NSMutableArray *)layoutArray
{
    if (!_layoutArray) {
        
        _layoutArray = [[NSMutableArray alloc] init];
    }
    return _layoutArray;
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

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommoneUseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    
    if (!cell) {
        
        cell = [[CommoneUseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    
    CalfManagerModel * model = self.dataArray[indexPath.row];
    
    cell.timeString = model.created_at;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CalfManagerModel * model = self.dataArray[indexPath.row];
    
    CalfManagerController * calfView = [[CalfManagerController alloc] init];
    
    calfView.layoutArray = self.layoutArray;
    
    calfView.idString = model.id;
    
    [self.navigationController pushViewController:calfView animated:YES];
}

@end
