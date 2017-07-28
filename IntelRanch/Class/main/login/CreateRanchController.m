//
//  CreateRanchController.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/12.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "CreateRanchController.h"
#import "MOFSPickerManager.h"
#import "RootNaviController.h"
#import "MainViewController.h"
#import "MyRanchInfoModel.h"
@interface CreateRanchController ()
@property (strong, nonatomic) IBOutlet UIView *bgView;

@property (strong, nonatomic) IBOutlet UITextField *nameText;
@property (strong, nonatomic) IBOutlet UITextField *addressText;
@property (strong, nonatomic) IBOutlet UITextField *timeText;
@property (strong, nonatomic) IBOutlet UITextField *AreaText;

@end

@implementation CreateRanchController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSUserDefaults standardUserDefaults] setObject:@0 forKey:@"selectRanch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"创建牧场";
    self.view.backgroundColor = BGCOLOR;
    
    [self addShadowToCell:self.bgView];
    [self addSubView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(didNavBtnClick)];
}
-(void)didNavBtnClick
{
    NSLog(@"提交");
    if (self.nameText.text.length==0) {
        
        [LCProgressHUD showFailure:@"牧场名称不能为空"];
        
        [self shake:self.nameText];
        
        return;
    }
    if (self.addressText.text.length==0) {
        
        [LCProgressHUD showFailure:@"牧场地址不能为空"];
        
        [self shake:self.addressText];
        
        return;
    }
    if (self.timeText.text.length==0) {
        
        [LCProgressHUD showFailure:@"建场时间不能为空"];
        
        [self shake:self.timeText];
        
        return;
    }
    if (self.AreaText.text.length==0) {
        
        [LCProgressHUD showFailure:@"占地面积不能为空"];
        
        [self shake:self.AreaText];
        
        return;
    }
    [[RequestTool sharedRequestTool] requestWithCreateRanchName:self.nameText.text Address:self.addressText.text Time:self.timeText.text Area:self.AreaText.text FinishedBlock:^(id result, NSError *error) {
        
        if ([result[@"status_code"] integerValue] == 200) {
            
            MyRanchInfoModel * model = [[MyRanchInfoModel alloc] initWithDictionary:result[@"data"] error:nil];
            
            [LocalDataTool putDataToTableName:[NSString stringWithString:NSStringFromClass([MyRanchInfoModel class])] Data:model];
            
            AppDelegateMain.window.rootViewController = [[RootNaviController alloc] initWithRootViewController:[[MainViewController alloc] init]];
            
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:[model.id integerValue]] forKey:@"selectRanch"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }else{
         
            [LCProgressHUD showMessage:result[@"message"]];
        }
    }];
}
-(void)addSubView
{
    self.nameText.layer.masksToBounds = YES;
    self.nameText.layer.cornerRadius = 5;
    
    self.addressText.layer.masksToBounds = YES;
    self.addressText.layer.cornerRadius = 5;
    
    self.timeText.layer.masksToBounds = YES;
    self.timeText.layer.cornerRadius = 5;
    
    self.AreaText.layer.masksToBounds = YES;
    self.AreaText.layer.cornerRadius = 5;
}
- (IBAction)setRanchBtn:(id)sender {
    
    [self.bgView endEditing:YES];
    
    NSDateFormatter *df = [NSDateFormatter new];
    
    df.dateFormat = @"yyyy-MM-dd";
    
    [[MOFSPickerManager shareManger] showDatePickerWithTag:1 commitBlock:^(NSDate *date) {
        
        self.timeText.text = [df stringFromDate:date];

    } cancelBlock:^{}];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


@end
