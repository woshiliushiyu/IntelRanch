//
//  SelectRanchController.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/10.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "SelectRanchController.h"
#import "MainViewController.h"
#import "SelectRanchCell.h"
#import "RootNaviController.h"
#import "MyRanchInfoModel.h"
@interface SelectRanchController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
{
    NSInteger _isSelectRow;
    SelectRanchCell * tempCell;
    
    SelectRanchCell * otherCell;
}
@property (strong, nonatomic) IBOutlet UIImageView *titleView;
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation SelectRanchController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.dataArray.count == 0) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@0 forKey:@"selectRanch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    RootNaviController * rootNav = (RootNaviController *) self.navigationController;
    
    rootNav.PopToViewController = ^BOOL{
        [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"selectRanch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return NO;
    };
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"选择牧场";
    
    _isSelectRow = 1000000;
    
    UIImage *image = [UIImage imageNamed:@"bj_login"];
    self.view.layer.contents = (__bridge id _Nullable)(image.CGImage);
    self.view.layer.contentsRect = CGRectMake(0, 0, 1, 1);
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleView.mas_bottom).offset(40);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    
    if (self.dataArray.count==0) {
        
        [self requestData];
    }
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
        
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(didNavBtnClick)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"selectRanch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return YES;
}
-(void)requestData
{
    [[RequestTool sharedRequestTool] requestWithPasturesForOwnsFinishedBlock:^(id result, NSError *error) {
    
        if ([result[@"status_code"] integerValue] == 200) {
            
            self.dataArray = [[NSMutableArray alloc] init];
            
            for (NSDictionary * entity in result[@"data"]) {
                
                MyRanchInfoModel * model = [[MyRanchInfoModel alloc] initWithDictionary:entity error:nil];
                
                [self.dataArray addObject:model];
            }
            
            [self.tableView reloadData];
            
        }else{
            [LCProgressHUD showMessage:result[@"message"]];
        }
    }];
}
- (void)didNavBtnClick {
    
    MyRanchInfoModel * model = self.dataArray[_isSelectRow];
    
    MainViewController * mainView = [[MainViewController alloc] init];
    
    mainView.ranchID = model.id;
    
    if (self.dataArray.count !=0) {
        
        AppDelegateMain.window.rootViewController = [[RootNaviController alloc] initWithRootViewController:mainView];
        
    }else{
        
        [self.navigationController pushViewController:mainView animated:YES];
    }

    [LocalDataTool putDataToTableName:[NSString stringWithString:NSStringFromClass([MyRanchInfoModel class])] Data:model];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:[model.id integerValue]] forKey:@"selectRanch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark === delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SelectRanchCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithString:NSStringFromClass([SelectRanchCell class])]];
    
    if (!cell) {
        cell = [[SelectRanchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithString:NSStringFromClass([SelectRanchCell class])]];
    }
    MyRanchInfoModel * model = self.dataArray[indexPath.row];
    
    cell.nameString = model.name;
    
    if (_isSelectRow == indexPath.row) {
        
        UIImage * bgImage = GetImage(@"dianjizhuangtai");
        cell.bgView.layer.contents = (__bridge id _Nullable)(bgImage.CGImage);
        cell.bgView.layer.contentsRect = CGRectMake(0, 0, 1, 1);
        otherCell = cell;
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectRanchCell * cell = (SelectRanchCell*)[tableView cellForRowAtIndexPath:indexPath];

    if (tempCell == cell) {
        
        return;
    }
    
    if (otherCell != nil) {
        
        UIImage * nomalImg = GetImage(@"weidianji");
        otherCell.bgView.layer.contents = (__bridge id _Nullable)(nomalImg.CGImage);
        otherCell.bgView.layer.contentsRect = CGRectMake(0, 0, 1, 1);
    }
    
    UIImage * bgImage = GetImage(@"dianjizhuangtai");
    cell.bgView.layer.contents = (__bridge id _Nullable)(bgImage.CGImage);
    cell.bgView.layer.contentsRect = CGRectMake(0, 0, 1, 1);
    
    UIImage * nomalImg = GetImage(@"weidianji");
    tempCell.bgView.layer.contents = (__bridge id _Nullable)(nomalImg.CGImage);
    tempCell.bgView.layer.contentsRect = CGRectMake(0, 0, 1, 1);
    
    tempCell = cell;
    
    _isSelectRow = indexPath.row;
    
    self.navigationItem.rightBarButtonItem.enabled = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate  =  self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
    }
    return _tableView;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
