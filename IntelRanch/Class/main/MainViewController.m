//
//  MainViewController.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/5.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "MainViewController.h"
#import "InfoController.h"
#import "MyRanchInfoModel.h"
#import "CalfManageController.h"
@interface MainViewController ()
@property (strong, nonatomic) IBOutlet UIView *bgBottemView;


@property (strong, nonatomic) IBOutlet NSLayoutConstraint *top;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *right;

@end

@implementation MainViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage * image = GetImage(@"bjaa");
    self.view.layer.contents = (__bridge id _Nullable)(image.CGImage);
    self.view.layer.contentsRect = CGRectMake(0, 0, 1, 1);

    [self setupPersonCenter];
    
    
    NSLog(@"获取的数据 %@",[LocalDataTool getDataToDataName:[NSString stringWithString:NSStringFromClass([MyRanchInfoModel class])]]);

}
-(void)setupPersonCenter
{
    if (Width == 415) {
        
        _top.constant = 20.0f;
        _right.constant = 18.0f;
        
    }else if (Width == 375){
        
        _top.constant = 27.0f;
        _right.constant = 14.0f;
        
    }else{
        
        _top.constant = 28.0f;
        _right.constant = 7.0f;
        
    }
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
    
    [self.navigationController pushViewController:[[CalfManageController alloc] init] animated:YES];
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
