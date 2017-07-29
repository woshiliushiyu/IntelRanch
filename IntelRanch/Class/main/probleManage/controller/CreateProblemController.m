//
//  CreateProblemController.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/19.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "CreateProblemController.h"
#import "MOFSPickerManager.h"
#import "TeamControllerTableViewController.h"
@interface CreateProblemController ()
{
    NSArray * _dataArray;
    NSUInteger _sum;
    NSString * _teamId;
    NSInteger _index;
}
@property (strong, nonatomic) IBOutlet UITextView *problemTextView;
@property (strong, nonatomic) IBOutlet UIButton *ranchTypeBtn;
@property (strong, nonatomic) IBOutlet UIView *teamView;
@property (strong, nonatomic) IBOutlet UILabel *teamNameLabel;
@property (strong, nonatomic) IBOutlet UIView *bgView;

@end

@implementation CreateProblemController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"问题提交";
    
    self.ranchTypeBtn.layer.masksToBounds = YES;
    self.ranchTypeBtn.layer.cornerRadius = 5;
    self.ranchTypeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.ranchTypeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    self.problemTextView.layer.masksToBounds = YES;
    self.problemTextView.layer.cornerRadius = 5;
    
    self.teamView.layer.masksToBounds = YES;
    self.teamView.layer.cornerRadius = 5;
    
    [self addShadowToCell:self.bgView];
    
    _sum = 1;
    
    _dataArray = @[@"牧场基本信息",@"新生犊牛管理",@"犊牛饲喂管理",@"犊牛疾病管理"];
    
}
- (IBAction)touchTeamAction:(id)sender {

    [self.bgView endEditing:YES];
    
    TeamControllerTableViewController * teamView = [[TeamControllerTableViewController alloc] init];
    
    teamView.SelectRowsBlock = ^(NSString *teamId, NSString *name,NSInteger idx) {
        
        _teamId = teamId;
        
        _index = idx;
        
        self.teamNameLabel.text = name;
    };
    teamView.index = _index;
    
    [self.navigationController pushViewController:teamView animated:YES];
}
- (IBAction)ranchAction:(id)sender {
    
    [self.bgView endEditing:YES];
    
    [[MOFSPickerManager shareManger] showPickerViewWithDataArray:@[@"牧场基本信息",@"新生犊牛管理",@"犊牛饲喂管理",@"犊牛疾病管理"] tag:1 title:@"牧场类型" cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(NSString *string) {
        
        [self.ranchTypeBtn setTitle:string forState:UIControlStateNormal];
        
        _sum = [_dataArray indexOfObject:string]+1;
        
    } cancelBlock:^{}];
}
- (IBAction)affirmAction:(id)sender {
    
    [self.bgView endEditing:YES];
    
    if (self.problemTextView.text.length==0) {
        
        [LCProgressHUD showInfoMsg:@"问题描述不能为空"];
        
        [self shake:self.problemTextView];
        
        return;
    }
    if (_teamId==nil) {
        
        [LCProgressHUD showInfoMsg:@"请选择专家"];
        
        [self shake:self.teamView];
        
        return;
    }
    
    [LCProgressHUD showLoading:@"上传中..."];
    
    [[RequestTool sharedRequestTool] uploadWithProblemDescript:self.problemTextView.text Tpye: Str(_sum) TeamId:_teamId Finished:^(id result, NSError *error) {
        
        if ([result[@"status_code"] integerValue] == 200) {
            
            [LCProgressHUD showMessage:@"上传成功"];
            
        }else{
            
            [LCProgressHUD showMessage:result[@"message"]];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addShadowToCell:(UIView*)bgView
{
    bgView.layer.shadowColor = [UIColor grayColor].CGColor;
    bgView.layer.shadowOpacity = 0.8f;
    bgView.layer.shadowOffset = CGSizeMake(0, 0);
    bgView.layer.shadowRadius = 5.0f;
}
- (void)shake:(UIView *)view {
    CGRect frame = view.frame;
    CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef shakePath = CGPathCreateMutable();
    CGPathMoveToPoint(shakePath, NULL, frame.origin.x+frame.size.width/2, frame.origin.y+frame.size.height/2);
    int index;
    for (index = 3; index >=0; --index) {
        CGPathAddLineToPoint(shakePath, NULL, frame.origin.x+frame.size.width/2 - frame.size.width * 0.02f * index, frame.origin.y+frame.size.height/2);
        CGPathAddLineToPoint(shakePath, NULL, frame.origin.x+frame.size.width/2 + frame.size.width * 0.02f * index, frame.origin.y+frame.size.height/2);
    }
    CGPathCloseSubpath(shakePath);
    
    shakeAnimation.path = shakePath;
    shakeAnimation.duration = 0.5f;
    shakeAnimation.removedOnCompletion = YES;
    
    [view.layer addAnimation:shakeAnimation forKey:nil];
    CFRelease(shakePath);
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
