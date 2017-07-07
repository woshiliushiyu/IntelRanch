//
//  AppDelegate+Extension.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/5.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "AppDelegate+Extension.h"
#import "RootNaviController.h"
#import "MainViewController.h"
@implementation AppDelegate (Extension)
-(void)setRootViewController
{
    self.window.backgroundColor = [UIColor whiteColor];

    RootNaviController * rootView = [[RootNaviController alloc] initWithRootViewController:[[MainViewController alloc] init]];
    
    self.window.rootViewController = rootView;
    
    [self.window makeKeyAndVisible];
    
}
@end
