//
//  DetailController.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/14.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "DetailController.h"

#import "SelectTableView.h"
@interface DetailController ()
@property (strong, nonatomic) IBOutlet UIScrollView *bgScrollView;

@end

@implementation DetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = BGCOLOR;
    
//    SudokuItemView * suView =  [[SudokuItemView alloc] initWithFrame:CGRectMake(0, 0, Width, 40)];
    
    UIView * bgView = View.bgColor(@"red").wh(Width-40,50);
    
    SelectTableView * sView = [[SelectTableView alloc] initWithTitles:@[@"评分",@"0分",@"0分",@"0分"] SubTitles:@[@"温度范围",@"37.8~38.8",@"37.8~38.8",@"37.8~38.8"] TableBody:@[@[@"",@"1",@"",@""]] Select:NO FooterView:bgView];
    
    [self.bgScrollView addSubview:sView];
    [sView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.mas_equalTo(self.view).offset(20);
        make.bottom.right.mas_equalTo(self.view).offset(-20);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
