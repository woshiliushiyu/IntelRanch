//
//  CattleInfoController.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/7.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "CattleInfoController.h"
#import "TopHalfInfoCell.h"
#import "BottomHalfInfoCell.h"
#import "ModifierInfoTool.h"
@interface CattleInfoController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *bgView;

@property(nonatomic,strong)NSMutableArray * finishArray;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UIView * fileView;
@property(nonatomic,assign)NSInteger zongSum;
@property(nonatomic,assign)NSInteger sum;
@end

@implementation CattleInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"牛群信息";
    self.bgView.backgroundColor = BGCOLOR;
    [self.bgView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_bgView).offset(20);
        make.right.mas_equalTo(_bgView).offset(-20);
        make.top.mas_equalTo(_bgView);
        make.bottom.mas_equalTo(_bgView);
    }];
    
    self.finishArray = [[NSMutableArray alloc] init];
    
    [self.dataArray enumerateObjectsUsingBlock:^(LayoutInfoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (![obj.editor.type isEqualToString:@"checkbox"] && ![obj.editor.type isEqualToString:@"select"] ) {
            
            if ([Str(self.dataDict[obj.name]) isEqualToString:@""]) {
                
                [self.finishArray addObject:@""];
            }else{
                
                [self.finishArray addObject:Str(self.dataDict[obj.name])];
            }
            
        }else{
            [self.finishArray addObject:@[]];
        }
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(didNavBtnClick)];
}
- (void)didNavBtnClick {
    
    WeakifySelf();
    self.zongSum = 0;
    
    [self.finishArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx != 0) {
            
            if (idx == 1) {
                
                weakSelf.sum = [obj integerValue];
            }else{
                
                weakSelf.zongSum += [obj integerValue];
            }
        }
    }];
    if (weakSelf.sum != weakSelf.zongSum) {
        
        [LCProgressHUD showFailure:@"总头数与各头数不匹配"];
        
        return;
    }
    
    [[ModifierInfoTool sharedModifierInfoTool] requestModifierRanchInfoData:self.finishArray LayoutArray:self.dataArray Type:1 isCreate:@"" ModifierFinishedBlock:^{
        
        self.navigationItem.rightBarButtonItem.enabled = NO;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
}
#pragma mark === delegate  ====
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LayoutInfoModel * model = self.dataArray[indexPath.row];
    
    if ([model.editor.type isEqualToString:@"checkbox"] || [model.editor.type isEqualToString:@"select"]) {
    
        BottomHalfInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell%lu",indexPath.row]   forIndexPath:indexPath];

        if (cell.model == nil) {
            
            cell.model = self.dataArray[indexPath.row];
        }
        cell.index = indexPath.row;
        
        cell.FinishedBlock = ^(NSMutableArray *finishArray,NSInteger index) {
            
            [self.finishArray replaceObjectAtIndex:index withObject:finishArray];
        };
        
        return cell;
    }
    TopHalfInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell%lu",indexPath.row]   forIndexPath:indexPath];
    cell.dataDict = self.dataDict;
    cell.indexPath = indexPath;
    cell.model = self.dataArray[indexPath.row];
    cell.FinishedBlock = ^(NSString *finishString,NSInteger index) {
        
        if (finishString) {
            
            [self.finishArray replaceObjectAtIndex:index withObject:finishString];
        }
    };
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LayoutInfoModel * model = self.dataArray[indexPath.row];
    
    if ([model.editor.type isEqualToString:@"checkbox"] | [model.editor.type isEqualToString:@"select"]) {
        
        return (model.editor.options.count*30)+50;
    }
    return indexPath.row==0?90.0f:80.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self setEditing:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark === lazy
-(void)setDataArray:(NSMutableArray<LayoutInfoModel *> *)dataArray
{
    _dataArray = dataArray;
}
-(UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = self.fileView;
        _tableView.tableHeaderView = self.fileView;
        _tableView.backgroundColor = BGCOLOR;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.dataArray enumerateObjectsUsingBlock:^(LayoutInfoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (![obj.editor.type isEqualToString:@"checkbox"] && ![obj.editor.type isEqualToString:@"select"] ) {
                
                [_tableView registerClass:[TopHalfInfoCell class] forCellReuseIdentifier:[NSString stringWithFormat:@"cell%lu",(unsigned long)idx]];
            }else{
                
                [_tableView registerClass:[BottomHalfInfoCell class] forCellReuseIdentifier:[NSString stringWithFormat:@"cell%lu",(unsigned long)idx]];
            }
        }];
        [self addShadowToCell:_tableView];
    }
    return _tableView;
}
-(UIView *)fileView
{
    if (!_fileView) {
        
        _fileView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 20)];
        _fileView.backgroundColor = BGCOLOR;
    }
    return _fileView;
}
-(void)addShadowToCell:(UIView*)bgView
{
    bgView.layer.shadowColor = [UIColor grayColor].CGColor;
    bgView.layer.shadowOpacity = 0.8f;
    bgView.layer.shadowOffset = CGSizeMake(0, 0);
    bgView.layer.shadowRadius = 5.0f;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
