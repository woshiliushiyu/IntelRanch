//
//  MyProblemController.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/19.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "MyProblemController.h"
#import "MyProblemModel.h"
#import "MyProblemListCell.h"

@interface MyProblemController ()
{
    NSInteger _page;
}
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation MyProblemController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupData:1];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = BGCOLOR;
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page =1;
        [self setupData:_page];
    }];
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        _page++;
        [self setupData:_page];
    }];
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setupData:(NSInteger)page
{
    [[RequestTool sharedRequestTool] requestWithProblemForServerListPage:page FinishedBlock:^(id result, NSError *error) {
        
        if (page == 1) {
            
            [self.dataArray removeAllObjects];
        }
        
        if ([result[@"status_code"] integerValue] == 200) {
            
            for (NSDictionary * entity in result[@"data"]) {
                
                MyProblemModel * model = [[MyProblemModel alloc] initWithDictionary:entity error:nil];
                
                [self.dataArray addObject:model];
            }
            if (self.dataArray.count==0) {
                
                UIImage * image = GetImage(@"quse_defult");
                self.view.layer.contents = (__bridge id _Nullable)(image.CGImage);
                self.view.layer.contentsRect = CGRectMake(0, 0, 1, 1);
            }else{
                self.view.layer.contents = nil;
            }
            
            [self.tableView reloadData];
            
            [self.tableView.mj_footer endRefreshing];
            [self.tableView.mj_header endRefreshing];
            
            [LCProgressHUD hide];
        }else{
            
            [LCProgressHUD showMessage:result[@"message"]];
            
            UIImage * image = GetImage(@"fauil");
            self.view.layer.contents = (__bridge id _Nullable)(image.CGImage);
            self.view.layer.contentsRect = CGRectMake(0, 0, 1, 1);
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyProblemListCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithString:NSStringFromClass([MyProblemListCell class])]];
    
    if (!cell) {
        cell = [[MyProblemListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithString:NSStringFromClass([MyProblemListCell class])]];
    }
    MyProblemModel * model = self.dataArray[indexPath.row];
    
    cell.timeLabel.text = [NSString stringWithFormat:@"时间:%@",model.created_at];
    cell.statuLabel.text = model.comments.count>0?@"已答复":@"未答复";
    cell.descriptionText.text = model.summary;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyProblemModel * model = self.dataArray[indexPath.row];
    
    if (model.comments.count==0) {
        
        [LCProgressHUD showInfoMsg:@"问题正在解答,请耐心等待"];
        
        return;
    }
    
    self.SelectRowsBlock(model.comments);
    
}

@end
