//
//  AboutController.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/20.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "AboutController.h"

@interface AboutController ()
@property (strong, nonatomic) IBOutlet UILabel *presentLabel;
@property (strong, nonatomic) IBOutlet UILabel *newestLabel;
@property (strong, nonatomic) IBOutlet UITextView *descriptText;


@end

@implementation AboutController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = BGCOLOR;
    
    UIImage *image = [UIImage imageNamed:@"bj_login"];
    self.view.layer.contents = (__bridge id _Nullable)(image.CGImage);
    self.view.layer.contentsRect = CGRectMake(0, 0, 1, 1);
    
    if ([self.type isEqualToString:@"about"]) {
        
        self.descriptText.hidden = NO;
        self.descriptText.text = [self addTextData];
        
    }
    if ([self.type isEqualToString:@"updata"]) {
        
        [self showUpdata];
    }
    
}
-(void)showUpdata
{
    self.presentLabel.hidden = NO;
    self.newestLabel.hidden = NO;
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    NSMutableAttributedString *presentString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"当前版本号为: %@",[infoDictionary objectForKey:@"CFBundleShortVersionString"]]];
    NSMutableAttributedString *newrstString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"最新版本号为: %@",[infoDictionary objectForKey:@"CFBundleShortVersionString"]]];

    [presentString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,7)];
    
    [newrstString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,7)];
    
    self.presentLabel.attributedText = presentString ;
    self.newestLabel.attributedText = newrstString;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(NSString *)addTextData
{
    return @"中创云牧科技咨询（北京）有限公司成立于2015年6月，由蒙牛集团前副总裁刘卫星联合徐明、郝永清等十多位业内权,威专家、博士等共同创立。公司总部位于中国乳都内蒙古呼和浩特市，中创云牧四个字分别代表了中国、创新科技、云技术、以及云牧场四层含义；凭借其领先的技术核心优势，中创云牧在成立之初便成为国内领 先的牧场管理系统优 质服 务商。";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
