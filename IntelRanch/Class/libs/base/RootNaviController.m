//
//  RootNaviController.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/5.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "RootNaviController.h"

@interface RootNaviController ()<UIGestureRecognizerDelegate>

@end

@implementation RootNaviController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.enableRightGesture = YES;
    self.interactivePopGestureRecognizer.delegate = self;
    
    [self configureNavBarTheme];
    
}
- (void)configureNavBarTheme
{
    self.navigationBar.tintColor = [UIColor whiteColor];
    
    // 设置导航栏的标题颜色，字体
    NSDictionary* textAttrs = @{NSForegroundColorAttributeName:
                                    [UIColor blackColor],
                                NSFontAttributeName:
                                    [UIFont fontWithName:@"Helvetica"size:18.0],
                                };
    [self.navigationBar setTitleTextAttributes:textAttrs];
    
    //设置导航栏的背景图片
    [self.navigationBar setBackgroundImage:[self imageWithColor:GRAY] forBarMetrics:UIBarMetricsDefault];
    
    // 去掉导航栏底部阴影
    [self.navigationBar setShadowImage:[[UIImage alloc]init]];
    
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.viewControllers.count <= 1) {
        return NO;
    }
    return self.enableRightGesture;
}

#pragma mark - override

// override pushViewController
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count >= 1) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back2_pgnews"] style:UIBarButtonItemStylePlain target:self action:@selector(navGoBack)];
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark - action

- (void)navGoBack
{
    [self popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = (CGRect){CGPointZero,CGSizeMake(1.0, 1.0)};
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
