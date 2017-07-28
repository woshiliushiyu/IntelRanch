//
//  ProblemController.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/19.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "ProblemController.h"
#import "MyProblemController.h"
#import "CommProblemController.h"
#import "CreateProblemController.h"
#import "AnswerController.h"
#define titleHeight 40
#define titleWidth SCREEN_WIDTH/2
@interface ProblemController ()<UIScrollViewDelegate>
{
    UIButton * selectButton;
    UIView * _sliderView;
}
@property(nonatomic,strong)NSMutableArray * buttonArray;
@property(nonatomic,strong)UIButton * addProblemBtn;
@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,strong)MyProblemController * myProblemView;
@property(nonatomic,strong)CommProblemController * commProblemView;
@end

@implementation ProblemController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"常见问题";
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.addProblemBtn];
    [self.addProblemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self.view).offset(-50);
        make.height.width.mas_equalTo(70);
    }];
    [self setupScrollView];
    [self initWithTitleButton];
    
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(void)setupScrollView
{
    for (int i = 0; i < 2; i++) {
        UIView *viewcon = [[UIView alloc] init];
        
        if (i==0) {
            viewcon = self.myProblemView.view;
            viewcon.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.scrollView.frame.size.height);
        }else{
            viewcon = self.commProblemView.view;
            viewcon.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.scrollView.frame.size.height);
        }
        [self.scrollView addSubview:viewcon];
    }
}
//监听滚动事件判断当前拖动到哪一个了
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
    [self selectButton:index];
    
}
//选择某个标题
- (void)selectButton:(NSInteger)index
{
    [selectButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    selectButton = self.buttonArray[index];
    [selectButton setTitleColor:GRAY forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        _sliderView.frame = CGRectMake(titleWidth*index, titleHeight-3, titleWidth, 3);
    }];
}
- (void)initWithTitleButton
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, titleHeight)];
    titleView.backgroundColor = BGCOLOR;
    [self.view addSubview:titleView];
    titleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, titleHeight);
    NSArray * titleArray;
    
    titleArray = @[@"我的问题",@"常见问题"];

    for (int i = 0; i < titleArray.count; i++) {
        
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.frame = CGRectMake(titleWidth*i, 0, titleWidth, titleHeight);
        [titleButton setTitle:titleArray[i] forState:UIControlStateNormal];
        titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        [titleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        titleButton.tag = 100+i;
        [titleButton addTarget:self action:@selector(scrollViewSelectToIndex:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:titleButton];
        if (i == 0) {
            selectButton = titleButton;
            [selectButton setTitleColor:GRAY forState:UIControlStateNormal];
        }
        [self.buttonArray addObject:titleButton];
        
    }
    //滑块
    UIView *sliderV=[[UIView alloc]initWithFrame:CGRectMake(0, titleHeight-3, titleWidth, 3)];
    sliderV.backgroundColor = GRAY;
    [titleView addSubview:sliderV];
    _sliderView=sliderV;
    
}
- (void)scrollViewSelectToIndex:(UIButton *)button
{
    [self selectButton:button.tag-100];
    [UIView animateWithDuration:0.3 animations:^{
        _scrollView.contentOffset = CGPointMake(SCREEN_WIDTH*(button.tag-100), 0);
    }];
}
-(NSMutableArray *)buttonArray
{
    if (!_buttonArray) {
        
        _buttonArray = [[NSMutableArray alloc]init];
    }
    return _buttonArray;
}
-(MyProblemController *)myProblemView
{
    if (!_myProblemView) {
        
        WeakifySelf();
        
        _myProblemView = [[MyProblemController alloc] init];
        
        _myProblemView.SelectRowsBlock = ^(NSArray *dataArray) {
            
            AnswerController * answerView = [[AnswerController alloc] init];
            answerView.dataArray = dataArray;
            [weakSelf.navigationController pushViewController:answerView animated:YES];
        };
    }
    return _myProblemView;
}
-(CommProblemController *)commProblemView
{
    if (!_commProblemView) {
        
        _commProblemView = [[CommProblemController alloc] init];
    }
    return _commProblemView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIButton *)addProblemBtn
{
    if (!_addProblemBtn) {
        
        WeakifySelf();
        _addProblemBtn = Button.img(@"tianjiawenti").onClick(^(UIButton * btn){
            
            [weakSelf.navigationController pushViewController:[[CreateProblemController alloc] init] animated:YES];
            
        });
    }
    return _addProblemBtn;
}
-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 41, SCREEN_WIDTH, Height-103)];
        _scrollView.contentSize = CGSizeMake(2*SCREEN_WIDTH, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.backgroundColor = BGCOLOR;
 
    }
    return _scrollView;
}

@end
