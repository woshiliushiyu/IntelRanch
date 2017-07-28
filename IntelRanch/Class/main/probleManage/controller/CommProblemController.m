//
//  CommProblemController.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/25.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "CommProblemController.h"
#import "CommProblemCell.h"
@interface CommProblemController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _page;
    NSInteger _index;
}
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation CommProblemController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.tableView.backgroundColor = BGCOLOR;
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    
    [self setupData:1];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page =1;
        [self setupData:_page];
    }];
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        _page++;
        [self setupData:_page];
    }];
}
-(void)setupData:(NSInteger)page
{
    [[RequestTool sharedRequestTool] requestWithCommonProblemForServerListPage:page FinishedBlock:^(id result, NSError *error) {
        
        if (page == 1) {
            
            [self.dataArray removeAllObjects];
        }
        
        if ([result[@"status_code"] integerValue] == 200) {
            
            [self.dataArray addObjectsFromArray:result[@"data"]];
            
            [self.tableView reloadData];
            
            self.view.layer.contents = nil;
            
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
    
    CommProblemCell * cell = [CommProblemCell setTableView:tableView IndexPath:indexPath];
    
    NSDictionary * dic = self.dataArray[indexPath.row];
    
    cell.namelabel.text = dic[@"title"];
    
    cell.descriptlabel.text =dic[@"summary"];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_index == indexPath.row) {
        
        NSDictionary * dic = self.dataArray[indexPath.row];
        
        return 70+ [self heightForString:dic[@"summary"] fontSize:14 andWidth:Width-40.0f];
    }
    
    return 60.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommProblemCell * cell = (CommProblemCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    _index = indexPath.row;
    
    cell.selectBtn.hidden = YES;
    cell.nomalBtn.hidden = NO;
    
    [tableView reloadData];
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
//获得字符串的高度
-(CGFloat) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    UIColor  *backgroundColor=[UIColor blackColor];
    UIFont *font=[UIFont boldSystemFontOfSize:16.0];
    CGRect sizeToFit = [value boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
                                                                                                                                             NSForegroundColorAttributeName:backgroundColor,
                                                                                                                                             NSFontAttributeName:font
                                                                                                                                             } context:nil];
    return sizeToFit.size.height;
}

@end
