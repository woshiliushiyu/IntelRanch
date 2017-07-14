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
@interface CattleInfoController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger m;
}
@property (strong, nonatomic) IBOutlet UIView *bgView;

@property(nonatomic,strong)NSMutableArray * selectArray;
@property(nonatomic,strong)NSMutableArray * finishArray;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UIView * fileView;
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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(didNavBtnClick)];
}
- (void)didNavBtnClick {
    
    NSLog(@"上传");
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
    
    if ([model.editor.type isEqualToString:@"checkbox"]) {
        
        BottomHalfInfoCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (!cell) {
            cell = [[BottomHalfInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithString:NSStringFromClass([BottomHalfInfoCell class])]];
        }
        cell.model = self.dataArray[indexPath.row];
        
        cell.index = indexPath.row;
        
        cell.FinishedBlock = ^(NSMutableArray *finishArray,NSInteger index) {
            
            [self.selectArray replaceObjectAtIndex:index-m withObject:finishArray];
            
            NSLog(@"选取的数据===>%@",self.selectArray);
        };
        
        return cell;
    }
    
    TopHalfInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithString:NSStringFromClass([TopHalfInfoCell class])]];
    if (!cell) {
        cell = [[TopHalfInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithString:NSStringFromClass([TopHalfInfoCell class])]];
    }
    cell.indexPath = indexPath;
    cell.model = self.dataArray[indexPath.row];
    cell.FinishedBlock = ^(NSString *finishString) {
        
        if (finishString) {
            
            if (![finishString isEqualToString:@""]) {
                
                [self.finishArray addObject:finishString];
            }
        }
    };
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LayoutInfoModel * model = self.dataArray[indexPath.row];
    
    if ([model.editor.type isEqualToString:@"checkbox"]) {
        
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
-(NSMutableArray *)finishArray
{
    if (!_finishArray) {
        
        _finishArray = [[NSMutableArray alloc] init];
    }
    return _finishArray;
}
-(NSMutableArray *)selectArray
{
    if (!_selectArray) {
        
        _selectArray = [[NSMutableArray alloc] init];
        
        for (LayoutInfoModel * model in self.dataArray) {
            
            if ([model.editor.type isEqualToString:@"checkbox"]) {
                
                [_selectArray addObject:@[]];
            }else{
                m++;
            }
        }
    }
    return _selectArray;
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


@end
