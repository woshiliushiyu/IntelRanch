//
//  GradeController.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/21.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "GradeController.h"
#import "SelectTableView.h"
#import "GradeDataTool.h"
#import "TableDataTool.h"
@interface GradeController ()
{
    int i;
    BOOL _isSelect;
    NSInteger _line;
    NSInteger _stopLine;
}
@property(nonatomic,strong)NSMutableArray * tempArray;
@property (strong, nonatomic) IBOutlet UIScrollView *bgScrollView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightContent;
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UILabel *lineLabel;

@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * array;
@property(nonatomic)NSUInteger  scroe;

@property(nonatomic,strong)SelectTableView * mView;;
@end

@implementation GradeController
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [GradeDataTool deleteTableData:@"temp"];
}
-(void)setImages:(NSArray *)images
{
    _images = images;
}
-(void)setSubTitles:(NSArray *)subTitles
{
    _subTitles = subTitles;
}
-(void)setTitles:(NSArray *)titles
{
    _titles = titles;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    i=0;
    
    _isSelect = YES;
    __weak GradeController *weakSelf = self;
    
    self.tempArray = [[NSMutableArray alloc] init];
    
    _mView = [[SelectTableView alloc] initWithTitles:self.titles SubTitles:self.subTitles TableBody:self.titles.count==5?@[]:nil Select:YES FooterView:self.images];
    
    _mView.SelectRowBlock = ^(NSInteger line, NSInteger row) {
        
        if (_stopLine >= line) {
            
            return NO;
        }
        
        if (self.titles.count == 5) {
            
            [weakSelf.tempArray removeAllObjects];
            
            [weakSelf.tempArray addObjectsFromArray:@[[NSString stringWithFormat:@"样本%d",i],@"",@"",@"",@""]];
            
            [weakSelf.tempArray replaceObjectAtIndex:row-1 withObject:@"1"];
            
            [GradeDataTool insertTableData:weakSelf.tempArray Number:@"temp"];
            
            _line = line;
        }else{
            
            NSMutableArray * tempArray = [[NSMutableArray alloc] init];
            
            tempArray = [TableDataTool selectTableData:Str(0000)];
            
            if (tempArray.count>0) {
                
                //                NSMutableDictionary * sample =  [[tempArray objectAtIndex:line] toDictionary].mutableCopy;
                
                ZYInputAlertView *alertView = [ZYInputAlertView alertView];
                
                [alertView.inputTextView becomeFirstResponder];
                
                alertView.tipLabel.text = self.titles[row-1];
                
                alertView.placeholder = @"请输入修改数据";
                
                [alertView confirmBtnClickBlock:^(NSString *inputString) {
                    
                    NSLog(@"输出的数据%@",inputString);
                    
                    //                    [TableDataTool deleteTableData:Str(0000)];
                    //
                    //                    [tempArray removeObjectAtIndex:line];
                    //
                    //                    [sample setObject:inputString forKey:_titles[row-1]];
                    //
                    //                    [tempArray insertObject:[[Sample alloc] initWithDictionary:sample error:nil] atIndex:line];
                    //
                    //                    [self.tempArray addObjectsFromArray:tempArray];
                    //
                    //                    if ([TableDataTool insertTableData:tempArray Number:Str(0000)]) {
                    //
                    //                        weakSelf.ReloadDataBlcok(_index,tempArray);
                    //                    }
                }];
                [alertView show];
            }
        }
        
        NSLog(@"点击了第%ld行,第%ld列",(long)line,(long)row);
        
        NSLog(@"现在数据源是===>%@",weakSelf.tempArray);
        
        return YES;
    };
    _mView.SelectAddBlock = ^{
        
        if (!_isSelect) {
            
            [LCProgressHUD showFailure:@"请上传完成之后再次添加"];
            
            return;
        }
        
        i++;
        
        if (weakSelf.dataArray.count>0) {
            
            [weakSelf.dataArray removeLastObject];
            
            [weakSelf.dataArray addObject:[GradeDataTool selectTableData:@"temp"]];
        }
        
        if (self.titles.count == 5) {
            
            [weakSelf.dataArray addObject:@[[NSString stringWithFormat:@"样本%d",i],@"",@"",@"",@""]];
        }else{
            
            [weakSelf.dataArray addObject:@[[NSString stringWithFormat:@"%d",i],@"",@""]];
        }
        
        NSLog(@"要展示的数据源===>%@",weakSelf.dataArray);
        
        weakSelf.mView.bodyArray = weakSelf.dataArray;
        
        _isSelect = NO;
        
    };
    _mView.BackHeightBlock = ^{
        
        weakSelf.heightContent.constant += 30;
    };
    
    [self.bgView addSubview:_mView];
    
    [_mView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.bgView).offset(10);
        make.bottom.right.mas_equalTo(self.bgView).offset(-10);
    }];
    
    
    weakSelf.heightContent.constant = self.images.count==4?510:150;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = BGCOLOR;
    
    self.nameLabel.text = self.navigationItem.title;
    
    [self addShadowToCell:self.bgView];
    
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(didNavBtnClick)];
}
- (void)didNavBtnClick {
    
    NSLog(@"提交的数据====>%@",self.tempArray);
    _stopLine = _line;
    
    WeakifySelf();
    [self.tempArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx != 0 && [obj isEqualToString:@"1"]) {
            weakSelf.scroe = idx;
        }
    }];

    [[RequestTool sharedRequestTool] requestWithScoreForServer:Str(self.scroe-1) Sickness:self.idString Code:Str(arc4random()%2) Type:[self.typeString integerValue] Value1:@"" Value2:@"" FinishedBlock:^(id result, NSError *error) {
        
        if ([result[@"status_code"] integerValue] == 200) {

            _isSelect = YES;
            [LCProgressHUD showMessage:@"提交成功"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else{
            [LCProgressHUD showMessage:result[@"message"]];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(void)addShadowToCell:(UIView*)bgView
{
    bgView.layer.shadowColor = [UIColor grayColor].CGColor;
    bgView.layer.shadowOpacity = 0.8f;
    bgView.layer.shadowOffset = CGSizeMake(0, 0);
    bgView.layer.shadowRadius = 5.0f;
}

@end
