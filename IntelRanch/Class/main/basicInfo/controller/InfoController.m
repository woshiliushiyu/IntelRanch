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
@interface InfoController ()
{
    CGFloat _cellHeight;
}
@property(nonatomic,strong)UIButton * rightBtn;
@end

@implementation InfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"牧场基本信息";
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIButton *)rightBtn
{
    if (!_rightBtn) {
        
        _rightBtn= Button.wh(40,30).str(@"提交").color(@"block").fnt(18).highColor(@"block").selectedColor(@"block").onClick(^(UIButton * btn){
            
            NSLog(@"提交");
        });
    }
    return _rightBtn;
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
        RanchInfoCell * cell = (RanchInfoCell *)[tableView dequeueReusableCellWithIdentifier:[NSString stringWithString:NSStringFromClass([RanchInfoCell class])]];
        if (!cell) {
            
            cell = [[RanchInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithString:NSStringFromClass([RanchInfoCell class])]];
        }
        
        return cell;
    }
    if (indexPath.row ==1) {
        HerdInfoCell * cell = (HerdInfoCell *)[tableView dequeueReusableCellWithIdentifier:[NSString stringWithString:NSStringFromClass([HerdInfoCell class])]];
        if (!cell) {
        
            cell = [[HerdInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithString:NSStringFromClass([HerdInfoCell class])]];
        }
        return cell;
    }
    if (indexPath.row ==2) {
        CalfSampleCell * cell = (CalfSampleCell *)[tableView dequeueReusableCellWithIdentifier:[NSString stringWithString:NSStringFromClass([CalfSampleCell class])]];
        if (!cell) {
            
            cell = [[CalfSampleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithString:NSStringFromClass([CalfSampleCell class])]];
        }
        return cell;
    }
    if (indexPath.row ==3) {
        OtherAdjunctCell * cell = (OtherAdjunctCell *)[tableView dequeueReusableCellWithIdentifier:[NSString stringWithString:NSStringFromClass([OtherAdjunctCell class])]];
        if (!cell) {
            
            cell = [[OtherAdjunctCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithString:NSStringFromClass([OtherAdjunctCell class])]];
            
        }
        cell.TouchAddBlock = ^{
            
            [weakSelf pushNextView:[AdjunctController class]];
        };
        _cellHeight = cell.cellHeight;
        
        return cell;
    }
    return NULL;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
        
        return 210.0f;
    }
    if (indexPath.row ==1) {
        
        return 270.0f;
    }
    if (indexPath.row == 2) {
        
        return 270.0f;
    }
    return 140.0f + _cellHeight;
}
-(void)pushNextView:(Class)vc
{
    [self.navigationController pushViewController:[[vc alloc] init] animated:YES];
}
@end
