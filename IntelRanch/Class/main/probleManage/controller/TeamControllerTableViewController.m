//
//  TeamControllerTableViewController.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/19.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "TeamControllerTableViewController.h"
#import "TeamCustomCell.h"
#import "TeamInfoModel.h"

@interface TeamControllerTableViewController ()
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation TeamControllerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"专家库";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = BGCOLOR;
    
    [self setupDataInfo];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setupDataInfo
{
    [[RequestTool sharedRequestTool] requestWithTeamInfoListForServerFinished:^(id result, NSError *error) {

        if ([result[@"status_code"] integerValue] == 200) {
            
            for (NSDictionary * entity in result[@"data"]) {
                
                TeamInfoModel * model = [[TeamInfoModel alloc] initWithDictionary:entity error:nil];
                
                [self.dataArray addObject:model];
            }
            [LCProgressHUD hide];
            
            [self.tableView reloadData];
            
        }else{
            [LCProgressHUD showMessage:result[@"message"]];
            
            UIImage * image = GetImage(@"fauil");
            self.view.layer.contents = (__bridge id _Nullable)(image.CGImage);
            self.view.layer.contentsRect = CGRectMake(0, 0, 1, 1);
        }
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TeamCustomCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithString:NSStringFromClass([TeamCustomCell class])]];
    
    if (!cell) {
        
        cell = [[TeamCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithString:NSStringFromClass([TeamCustomCell class])]];
    }
    TeamInfoModel * model=  self.dataArray[indexPath.row];
    
    [cell.iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https:%@",model.avatar_url]] placeholderImage:[UIImage imageNamed:@"ywjf"]];
    cell.nameLabel.text = model.name;
    cell.describeLabel.text = model.summary;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeamInfoModel * model=  self.dataArray[indexPath.row];
    
    TeamCustomCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (self.SelectRowsBlock) {
        
        self.SelectRowsBlock(model.id,model.name);
    }
    
    cell.selectImg.hidden = NO;
    
    self.tableView.userInteractionEnabled = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.navigationController popViewControllerAnimated:YES];
    });
}
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
