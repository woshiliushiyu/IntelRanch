//
//  MineController.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/19.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "MineController.h"
#import "SDWebImageManager.h"
#import "MyRanchInfoModel.h"
#import "AccountController.h"
#import "LoginController.h"
#import "RootNaviController.h"
#import "AboutController.h"
#import "SelectRanchController.h"
@interface MineController ()
{
    SDWebImageManager *web;
}
@property (strong, nonatomic) IBOutlet UILabel *memoryLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topHeight;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ranchListHeight;
@property (strong, nonatomic) IBOutlet UILabel *ranchLabel;

@end

@implementation MineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"个人中心";
    
    if ([[LoginInfoModel getLoginInfoModel].type integerValue] == 1) {
        self.topHeight.constant = 0;
        self.ranchListHeight.constant = 0;
        self.ranchLabel.hidden = YES;
    }

    CGFloat cacheSize = web.imageCache.getSize;
    self.memoryLabel.text = [NSString stringWithFormat:@"%.2fM", cacheSize/1024.f/1024.f];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)abountUsAction:(id)sender {
    
    AboutController * aboutView = [[AboutController alloc] init];
    aboutView.navigationItem.title = @"关于我们";
    aboutView.type = @"about";
    [self.navigationController pushViewController:aboutView animated:YES];
}
- (IBAction)accountAction:(id)sender {
    
    [self.navigationController pushViewController:[[AccountController alloc] init] animated:YES];
}
- (IBAction)upDataAction:(id)sender {
    
    AboutController * aboutView = [[AboutController alloc] init];
    aboutView.navigationItem.title = @"版本更新";
    aboutView.type = @"updata";
    [self.navigationController pushViewController:aboutView animated:YES];
}
- (IBAction)clearMeneoryAction:(id)sender {
    
    CGFloat cacheSize = web.imageCache.getSize;
    NSString * memoryString = [NSString stringWithFormat:@"%.2fM", cacheSize/1000.f/1000.f];
    
    if ([memoryString isEqualToString:@"0.00M"]) {
        
        [LCProgressHUD showMessage:@"系统很干净,无需清理"];
        
        return;
    }

    [web.imageCache clearMemory];
    [LCProgressHUD showLoading:@"清理中..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LCProgressHUD showSuccess:@"清理完成"];
        self.memoryLabel.text = [NSString stringWithFormat:@"%.2fM", cacheSize/1000.f/1000.f];
    });
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (IBAction)pushRanchList:(id)sender {
    
    [self.navigationController pushViewController:[[SelectRanchController alloc] init] animated:YES];
}

- (IBAction)loginOutAction:(id)sender {
        
    Alert.title(@"确认退出?").action(@"确认", ^{
        
        [[HttpToolManager sharedManager] clearLocalData];
        [LocalDataTool clearDataTableName:[NSString stringWithString:NSStringFromClass([MyRanchInfoModel class])]];
        [LoginInfoModel clearnLoginInfo];
        
        AppDelegateMain.window.rootViewController = [[RootNaviController alloc] initWithRootViewController:[[LoginController alloc] init]];
        
    }).action(@"取消", ^{
        
    }).show();
}


@end
