//
//  RegistController.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/10.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "RegistController.h"

@interface RegistController ()
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UIView *phoneView;
@property (strong, nonatomic) IBOutlet UIView *verifyView;
@property (strong, nonatomic) IBOutlet UIView *passwordView;
@property (strong, nonatomic) IBOutlet UITextField *phoneText;
@property (strong, nonatomic) IBOutlet UITextField *verifyText;
@property (strong, nonatomic) IBOutlet UITextField *passText;

@property (strong, nonatomic) IBOutlet UIButton *verifyBtn;

@property (strong, nonatomic) IBOutlet UIButton *finishBtn;

@property(nonatomic,assign)NSUInteger timeCount;    //重发时间
@property(nonatomic,strong)NSTimer * timer;         //定时器
@end

@implementation RegistController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"注  册";
    UIImage *image = [UIImage imageNamed:@"bj_login"];
    self.bgView.layer.contents = (__bridge id _Nullable)(image.CGImage);
    self.bgView.layer.contentsRect = CGRectMake(0, 0, 1, 1);
    [self addSubView];
    
    self.timeCount = 0;
    self.timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    [self.timer setFireDate:[NSDate distantFuture]];
}
- (IBAction)finishBtn:(id)sender {
    
    [self setEditing:NO];
    
    if ([self.phoneText.text isEqualToString:@""]) {
        
        [self shake:self.phoneView];
        
        [LCProgressHUD showMessage:@"手机号为空"];
        
        return;
    }
    if (self.phoneText.text.length != 11 || [HUDHelper CheckPhoneNumInput:self.phoneText.text]) {
        
        [self shake:self.phoneView];
        
        [LCProgressHUD showMessage:@"手机号错误"];
        
        return;
    }
    if ([self.verifyText.text isEqualToString:@""] || self.verifyText.text.length !=4) {
        
        [self shake:self.verifyView];
        
        [LCProgressHUD showMessage:@"验证码错误"];
        
        return;
    }
    if ([self.passText.text isEqualToString:@""]) {
        
        [self shake:self.passwordView];
        
        [LCProgressHUD showMessage:@"密码不能为空"];
        
        return;
    }
    if (6>self.passText.text.length || self.passText.text.length>16) {
        
        [self shake:self.passwordView];
        
        [LCProgressHUD showMessage:@"密码个数只能在6~16位之间"];
        
        return;
    }

    [[RequestTool sharedRequestTool] requestWithRegisterForPhoneNumber:self.phoneText.text Password:self.passText.text Captcha:self.verifyText.text FinishedBlock:^(id result, NSError *error) {
        
        NSLog(@"请求回来的数据是===>%@",result);
        /*
         data =     {
                 "avatar_url" = "https://ymzx.asia-cloud.com/images/avatar_default.png";
                 "created_at" = "2017-07-11 10:22:36";
                 id = 7;
                 ip = "124.193.218.82";
                 mobile = 18519714533;
                 name = 18519714533;
                 "nick_name" = 18519714533;
                 password = f021f05d174c188eb44c8721de339f4c;
                 points = 0;
                 salt = 55vb8r;
                 state = 1;
                 type = 1;
                 "updated_at" = "2017-07-11 10:22:36";
         };
         */
        if ([result[@"status_code"] integerValue] == 200) {
            
            [LCProgressHUD showSuccess:@"注册成功"];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            
            [LCProgressHUD showSuccess:result[@"message"]];
        }
    }];
}
- (IBAction)getVerifyBtn:(id)sender {
    
    if ([self.phoneText.text isEqualToString:@""]) {
        
        [self shake:self.phoneView];
        
        [LCProgressHUD showMessage:@"手机号为空"];
        
        return;
    }
    if (self.phoneText.text.length != 11 || [HUDHelper CheckPhoneNumInput:self.phoneText.text]) {
        
        [self shake:self.phoneView];
        
        [LCProgressHUD showMessage:@"手机号错误"];
        
        return;
    }
    //请求接口发送验证码
    [self getSMSMessage];
    
    self.timeCount = 60;
    self.verifyBtn.enabled = NO;
    [self.timer setFireDate:[NSDate distantPast]];
    [self.phoneText resignFirstResponder];
    
}
#pragma mark================更新重发时间===============
-(void)updateTime
{
    self.timeCount--;
    self.verifyBtn.titleLabel.text=[NSString stringWithFormat:@"%lu秒后重发",(unsigned long)self.timeCount];
    [self.verifyBtn setTitle:[NSString stringWithFormat:@"%lu秒后重发",(unsigned long)self.timeCount] forState:UIControlStateNormal];
    
    if(self.timeCount==0)
    {
        self.verifyBtn.enabled = YES;
        [self.timer setFireDate:[NSDate distantFuture]];
        self.verifyBtn.titleLabel.text=@"重发验证码";
        [self.verifyBtn setTitle:@"重发验证码" forState:UIControlStateNormal];
    }
}
-(void)getSMSMessage
{
    [[RequestTool sharedRequestTool] requestWithCaptchaForPhoneNumber:self.phoneText.text Type:Str(1) FinishedBlock:^(id result, NSError *error) {
        
        if ([result[@"status_code"] integerValue] == 200) {
            
            [LCProgressHUD showSuccess:@"验证码已发送,请注意查收"];
        }
    }];
}
-(void)addSubView
{
    UIImage * bgImage = GetImage(@"bjsr");
    self.phoneView.layer.contents = (__bridge id _Nullable)(bgImage.CGImage);
    self.phoneView.layer.contentsRect = CGRectMake(0, 0, 1, 1);
    self.phoneView.layer.masksToBounds = YES;
    self.phoneView.layer.cornerRadius = 5;
    self.verifyView.layer.contents = (__bridge id _Nullable)(bgImage.CGImage);
    self.verifyView.layer.contentsRect = CGRectMake(0, 0, 1, 1);
    self.verifyView.layer.masksToBounds = YES;
    self.verifyView.layer.cornerRadius = 5;
    self.passwordView.layer.contents = (__bridge id _Nullable)(bgImage.CGImage);
    self.passwordView.layer.contentsRect = CGRectMake(0, 0, 1, 1);
    self.passwordView.layer.masksToBounds = YES;
    self.passwordView.layer.cornerRadius = 5;
        
    self.verifyBtn.layer.masksToBounds = YES;
    self.verifyBtn.layer.cornerRadius = 5;
    self.verifyBtn.layer.borderColor = RGBColor(22, 141, 205).CGColor;
    self.verifyBtn.layer.borderWidth = 1;
    [self.verifyBtn sizeToFit];
    self.verifyBtn.titleEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    
    self.phoneText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{ NSForegroundColorAttributeName: CHARCOLOR,NSFontAttributeName:[UIFont fontWithName: @"futura" size: 14]}];
    
    self.verifyText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"验证密码" attributes:@{ NSForegroundColorAttributeName: CHARCOLOR,NSFontAttributeName:[UIFont fontWithName: @"futura" size: 14]}];
    
    self.passText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{ NSForegroundColorAttributeName: CHARCOLOR,NSFontAttributeName:[UIFont fontWithName: @"futura" size: 14]}];
    
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(void)dealloc
{
    [self.timer invalidate];
}

@end
