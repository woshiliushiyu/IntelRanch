//
//  MainViewController.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/5.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "MainViewController.h"
#import "InfoController.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}
//牧场基本信息
- (IBAction)basicInfoBtn:(id)sender {
    [self.navigationController pushViewController:[[InfoController alloc] init] animated:YES];
}
//新生犊牛管理
- (IBAction)calfManagerBtn:(id)sender {
}
//犊牛饲料管理
- (IBAction)raisingManagerBtn:(id)sender {
}
//个人中心
- (IBAction)personInfoBtn:(id)sender {
}
//犊牛疾病管理
- (IBAction)basicManagerBtn:(id)sender {
}
//常见问题解答
- (IBAction)problemanageBtn:(id)sender {
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
