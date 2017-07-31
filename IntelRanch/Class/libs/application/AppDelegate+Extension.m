//
//  AppDelegate+Extension.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/5.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "AppDelegate+Extension.h"
#import "RootNaviController.h"
#import "CreateRanchController.h"

#import "LoginController.h"
#import "MainViewController.h"
#import "SelectRanchController.h"
@implementation AppDelegate (Extension)
-(void)setRootViewController
{
    self.window.backgroundColor = [UIColor whiteColor];

    RootNaviController * rootView;
    
    if ([LoginInfoModel isLogin]) {
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"selectRanch"] boolValue]) {
            
            MainViewController * mainView = [[MainViewController alloc] init];
            
            mainView.ranchID = Str([[NSUserDefaults standardUserDefaults] objectForKey:@"selectRanch"]);
            
            rootView = [[RootNaviController alloc] initWithRootViewController:mainView];
            
        }else{
            
            if ([[LoginInfoModel getLoginInfoModel].type integerValue] == 2) {
                
                rootView = [[RootNaviController alloc] initWithRootViewController:[[SelectRanchController alloc] init]];
            }else{
                
                rootView = [[RootNaviController alloc] initWithRootViewController:[[CreateRanchController alloc] init]];
            }
        }
    }else{
    
        rootView = [[RootNaviController alloc] initWithRootViewController:[[LoginController alloc] init]];
    }
    
    self.window.rootViewController = rootView;
    
    [self.window makeKeyAndVisible];
    
}
-(void)popViewConteoller
{
    [[HttpToolManager sharedManager] clearLocalData];
    [LocalDataTool clearDataTableName:[NSString stringWithString:NSStringFromClass([MyRanchInfoModel class])]];
    [LoginInfoModel clearnLoginInfo];
    
    AppDelegateMain.window.rootViewController = [[RootNaviController alloc] initWithRootViewController:[[LoginController alloc] init]];
}
@end
