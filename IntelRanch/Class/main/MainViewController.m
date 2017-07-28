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
#import "CalfManagerListController.h"
#import "ProblemController.h"
#import "MineController.h"
#import "FoodListController.h"
#import "DiseaseListController.h"


#import "SelectTableView.h"
@interface MainViewController ()
@property (strong, nonatomic) IBOutlet UIView *bgBottemView;


@property (strong, nonatomic) IBOutlet NSLayoutConstraint *top;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *right;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *rHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *rWidth;


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
    
    if (Width == 414) {
        
        _top.constant = 23.0f;
        _right.constant = 14.0f;
        _rHeight.constant = 60.0f;
        _rWidth.constant = 60.0f;
        
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
    return UIStatusBarStyleLightContent;
}
//牧场基本信息
- (IBAction)basicInfoBtn:(id)sender {
    [self.navigationController pushViewController:[[InfoController alloc] init] animated:YES];
}
//新生犊牛管理
- (IBAction)calfManagerBtn:(id)sender {
    
    [self.navigationController pushViewController:[[CalfManagerListController alloc] init] animated:YES];
}
//犊牛饲料管理
- (IBAction)raisingManagerBtn:(id)sender {
    
    [self.navigationController pushViewController:[[FoodListController alloc] init] animated:YES];
}
//个人中心
- (IBAction)personInfoBtn:(id)sender {
    
    [self.navigationController pushViewController:[[MineController alloc] init] animated:YES];
}
//犊牛疾病管理
- (IBAction)basicManagerBtn:(id)sender {
    
    [self.navigationController pushViewController:[[DiseaseListController alloc] init] animated:YES];
}
//常见问题解答
- (IBAction)problemanageBtn:(id)sender {
    
    [self.navigationController pushViewController:[[ProblemController alloc] init] animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
