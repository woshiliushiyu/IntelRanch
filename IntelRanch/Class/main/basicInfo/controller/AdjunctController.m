//
//  AdjunctController.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/6.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "AdjunctController.h"
#import "UploadImgCell.h"
#import "AdjunctMsgCell.h"
@interface AdjunctController ()
{
    CGFloat _cellHeight;
}
@property(nonatomic,strong)UIButton * rightBtn;
@end

@implementation AdjunctController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.navigationItem.title = @"新增附件";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIButton *)rightBtn
{
    if (!_rightBtn) {
        
        _rightBtn= Button.wh(40,30).str(@"上传").color(@"block").fnt(18).highColor(@"block").selectedColor(@"block").onClick(^(UIButton * btn){
            
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

    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        UploadImgCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithString:NSStringFromClass([UploadImgCell class])]];
        
        if (!cell) {
            
            cell = [[UploadImgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithString:NSStringFromClass([UploadImgCell class])]];
        }
            
        _cellHeight = cell.cellHeight;
        
        return cell;
    }
    return NULL;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180.f+_cellHeight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击我了");
}

@end
