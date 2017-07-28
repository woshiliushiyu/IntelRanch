//
//  FoodListController.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/21.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "FoodListController.h"
#import "RanchInfoController.h"
#import "FeedController.h"
#import "LayoutModel.h"
#import "FeedInfoModel.h"
#import "CommoneUseCell.h"
@interface FoodListController ()
@property(nonatomic,strong)NSMutableArray * layoutArray;
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation FoodListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"饲养日志";
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    self.tableView.backgroundColor = BGCOLOR;
    
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
    
    createView.navigationItem.title = @"创建饲养日志";
    
    createView.typeString = Str(3);
    
    [self.navigationController pushViewController:createView animated:YES];
}
-(void)requestLayoutData
{
    [[RequestTool sharedRequestTool] requestWithRanchBasicLayoutTo:3 FinishedBlock:^(id result, NSError *error) {
        
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
-(void)requestData
{
    [[RequestTool sharedRequestTool] requestWithCalfManagerListToserverId:3 FinishedBlock:^(id result, NSError *error) {
       
        if ([result[@"status_code"] integerValue] == 200) {
            
            [self.dataArray removeAllObjects];
            
            for (NSDictionary * entity in result[@"data"]) {
                
                FeedInfoModel * model = [[FeedInfoModel alloc] initWithDictionary:entity error:nil];
                
                [self.dataArray addObject:model];
            }
            
            
            [LCProgressHUD hide];
            
            [self.tableView reloadData];
            
            if (self.dataArray.count==0) {
                
                UIImage * image = GetImage(@"defult");
                self.view.layer.contents = (__bridge id _Nullable)(image.CGImage);
                self.view.layer.contentsRect = CGRectMake(0, 0, 1, 1);
            }else{
                self.view.layer.contents = nil;
            }
            
            [self.tableView.mj_header endRefreshing];
            
        }else{
            [LCProgressHUD showMessage:result[@"message"]];
        }
    }];
}
-(NSMutableArray *)layoutArray
{
    if (!_layoutArray) {
        
        _layoutArray = [[NSMutableArray alloc] init];
    }
    return _layoutArray;
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
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
    
    FeedInfoModel * model = self.dataArray[indexPath.row];
    
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
    
    FeedInfoModel * model = self.dataArray[indexPath.row];
    
    FeedController * calfView = [[FeedController alloc] init];
    
    calfView.layoutArray = self.layoutArray;
    
    calfView.idString = model.id;
    
    [self.navigationController pushViewController:calfView animated:YES];
}
@end
