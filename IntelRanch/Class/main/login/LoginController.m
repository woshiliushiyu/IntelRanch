//
//  LoginController.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/10.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "LoginController.h"
#import "RegistController.h"
#import "ForgetPassController.h"
#import "SelectRanchController.h"
#import "MainViewController.h"
#import "RootNaviController.h"
#import "CreateRanchController.h"
#import "MyRanchInfoModel.h"
@interface LoginController ()
{
    LoginInfoModel * _model;
}
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UIView *usernameBgView;
@property (strong, nonatomic) IBOutlet UIView *passwordBgView;
@property (strong, nonatomic) IBOutlet UITextField *nameText;
@property (strong, nonatomic) IBOutlet UITextField *passText;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;

@property (strong, nonatomic) IBOutlet UIButton *touchLogin;
@property (strong, nonatomic) IBOutlet UIButton *casualLoginBtn;


@end

@implementation LoginController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
#ifdef DEBUG
self.nameText.text = @"18519714533";
self.passText.text = @"123456";
#endif
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"登  录";
    UIImage *image = [UIImage imageNamed:@"bj_login"];
    UIImage * bgImage = GetImage(@"bjsr");
    self.bgView.layer.contents = (__bridge id _Nullable)(image.CGImage);
    self.bgView.layer.contentsRect = CGRectMake(0, 0, 1, 1);
    self.usernameBgView.layer.contents = (__bridge id _Nullable)(bgImage.CGImage);
    self.usernameBgView.layer.contentsRect = CGRectMake(0, 0, 1, 1);
    self.usernameBgView.layer.masksToBounds = YES;
    self.usernameBgView.layer.cornerRadius = 5;
    self.passwordBgView.layer.contents = (__bridge id _Nullable)(bgImage.CGImage);
    self.passwordBgView.layer.contentsRect = CGRectMake(0, 0, 1, 1);
    self.passwordBgView.layer.masksToBounds = YES;
    self.passwordBgView.layer.cornerRadius = 5;
    
    self.nameText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{ NSForegroundColorAttributeName: CHARCOLOR,NSFontAttributeName:[UIFont fontWithName: @"futura" size: 14]}];
    
    self. passText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{ NSForegroundColorAttributeName: CHARCOLOR,NSFontAttributeName:[UIFont fontWithName: @"futura" size: 14]}];
    
    self.casualLoginBtn.layer.masksToBounds = YES;
    self.casualLoginBtn.layer.cornerRadius = 6.0f;
    self.casualLoginBtn.layer.borderWidth = 1;
    self.casualLoginBtn.layer.borderColor = RGBColor(180, 180, 180).CGColor;
    self.casualLoginBtn.titleEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (IBAction)registBtn:(id)sender {
    
    [self.navigationController pushViewController:[[RegistController alloc] init] animated:YES];
}
- (IBAction)forgetPassBtn:(id)sender {
    
    [self.navigationController pushViewController:[[ForgetPassController alloc] init] animated:YES];
}
- (IBAction)loginBtn:(id)sender {
    
    [self setEditing:NO];
    
    if ([self.nameText.text isEqualToString:@""]) {
        
        [self shake:self.usernameBgView];
        
        [LCProgressHUD showMessage:@"手机号不能为空"];
        
        return;
    }
    if (self.nameText.text.length !=11 || [HUDHelper CheckPhoneNumInput:self.nameText.text]) {
        
        [self shake:self.usernameBgView];
        
        [LCProgressHUD showMessage:@"手机号错误"];
        
        return;
    }
    if ([self.passText.text isEqualToString:@""]) {
        
        [self shake:self.passwordBgView];
        
        [LCProgressHUD showMessage:@"密码不能为空"];
        
        return;
    }
    if (self.passText.text.length<6 || self.passText.text.length>16) {
        
        [self shake:self.passwordBgView];
        
        [LCProgressHUD showMessage:@"密码错误"];
        
        return;
    }
    [[RequestTool sharedRequestTool] requestWithLoginPhoneNumber:self.nameText.text Password:self.passText.text FinishedBlock:^(id result, NSError *error) {
        
        NSLog(@"登录信息返回==>%@",result);
        
        if ([result[@"status_code"] integerValue] == 200) {
            
//            2==>是多个    1==>是一个
            
            _model = [[LoginInfoModel alloc] initWithDictionary:result[@"data"] error:nil];
            
            [LoginInfoModel saveLoginInfo:result[@"data"]];
            
            [self requestMyRanchData];

        }else{
            
            [LCProgressHUD showFailure:result[@"message"]];
            
            return;
        }
    }];
}
-(void)requestMyRanchData
{
    [[RequestTool sharedRequestTool] requestWithPasturesForOwnsFinishedBlock:^(id result, NSError *error) {
        
        if ([result[@"status_code"] integerValue] == 200) {
            
            NSMutableArray * dataArray = [[NSMutableArray alloc] init];

            for (NSDictionary * dic in result[@"data"]) {

                MyRanchInfoModel * model = [[MyRanchInfoModel alloc] initWithDictionary:dic error:nil];
                
                [dataArray addObject:model];
            }
            
            if ([_model.type isEqualToString:@"2"]) {
                
                SelectRanchController * selectRanchView = [[SelectRanchController alloc] init];
                
                selectRanchView.dataArray = dataArray;
                
                AppDelegateMain.window.rootViewController = [[RootNaviController alloc] initWithRootViewController:selectRanchView];
                
            }else{
                
                if (dataArray.count >0) {
                    
                    MyRanchInfoModel * models = dataArray[0];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:[models.id integerValue]] forKey:@"selectRanch"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    [LocalDataTool putDataToTableName:[NSString stringWithString:NSStringFromClass([MyRanchInfoModel class])] Data:dataArray[0]];
                    
                    AppDelegateMain.window.rootViewController = [[RootNaviController alloc] initWithRootViewController:[[MainViewController alloc] init]];
                    
                    return;
                }
            
                CreateRanchController * createRanchView = [[CreateRanchController alloc] init];
                
                createRanchView.dataArray = dataArray;
                
                AppDelegateMain.window.rootViewController = [[RootNaviController alloc] initWithRootViewController:createRanchView];
            }
        }else{
            
            [LCProgressHUD showFailure:result[@"message"]];
        }
    }];
}
#pragma mark ======  暂停使用 ===
- (IBAction)weixinLoginBtn:(id)sender {
}
- (IBAction)weiboLoginBtn:(id)sender {
}
- (IBAction)qqLoginBtn:(id)sender {
}
- (IBAction)casualLoginBtn:(id)sender {
}
- (IBAction)touchLoginBtn:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
@end
