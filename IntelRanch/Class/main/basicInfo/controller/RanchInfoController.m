//
//  RanchInfoController.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/7.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "RanchInfoController.h"
#import "TopHalfInfoCell.h"
#import "BottomHalfInfoCell.h"
#import "ModifierInfoTool.h"
@interface RanchInfoController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UIView * fileView;
@property (strong, nonatomic) IBOutlet UIView *bgView;

@property(nonatomic,strong)NSMutableArray * finishArray;
@end

@implementation RanchInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.bgView.backgroundColor = BGCOLOR;
    [self.bgView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_bgView).offset(20);
        make.right.mas_equalTo(_bgView).offset(-20);
        make.bottom.top.mas_equalTo(_bgView);
    }];

    self.finishArray = [[NSMutableArray alloc] init];

    [self.dataArray enumerateObjectsUsingBlock:^(LayoutInfoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (![obj.editor.type isEqualToString:@"checkbox"] && ![obj.editor.type isEqualToString:@"select"] ) {
            
            if ([Str(self.dataDict[obj.name]) isEqualToString:@""] | (self.dataDict[obj.name] == nil)) {
                
                [self.finishArray addObject:@""];
                
            }else{
                
                [self.finishArray addObject:Str(self.dataDict[obj.name])];
            }
            
        }else{
            
//            if ([Str(self.dataDict[obj.name]) isEqualToString:@""]) {
            
                [self.finishArray addObject:@[]];
//            }else{
//                
//                if ([self.dataDict[obj.name] rangeOfString:@","].location == NSNotFound) {
//                    
//                    [self.finishArray addObject:@[Str(self.dataDict[obj.name])]];
//                }else{
//                    
//                    NSArray * array = [self.dataDict[obj.name] componentsSeparatedByString:@","];
//                    
//                    NSMutableArray * tempArr = [[NSMutableArray alloc] init];
//                    
//                    [array enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                        
//                        [tempArr addObject:obj];
//                    }];
//                    [self.finishArray addObject:tempArr];
//                }
//            }
        }
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(didNavBtnClick)];
}
- (void)didNavBtnClick {
    
    [[ModifierInfoTool sharedModifierInfoTool] requestModifierRanchInfoData:self.finishArray LayoutArray:self.dataArray Type:[self.typeString integerValue] isCreate:self.idString ModifierFinishedBlock:^{
       
        self.navigationItem.rightBarButtonItem.enabled = NO;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
}
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
    
    if ([model.editor.type isEqualToString:@"checkbox"] | [model.editor.type isEqualToString:@"select"]) {
        
        BottomHalfInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell%lu",indexPath.row]  forIndexPath:indexPath];
        cell.dataDict = self.dataDict;
        cell.isFold = [self.typeString isEqualToString:@"4"];
        
        if (cell.model == nil) {
            
            cell.model = self.dataArray[indexPath.row];
        }
        
        cell.index = indexPath.row;
    
        cell.FinishedBlock = ^(NSMutableArray *finishArray,NSInteger index) {
            
            [self.finishArray replaceObjectAtIndex:index withObject:finishArray];
        };
        return cell;
    }
    TopHalfInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell%ld",(long)indexPath.row] forIndexPath:indexPath];
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
    
        if ([self.typeString isEqualToString:@"4"]) {
            
            return (model.editor.options.count*60)+50;
        }
        
        return (model.editor.options.count*30)+50;
    }
    return indexPath.row==0?90.0f:80.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self setEditing:NO];
}
-(void)setDataDict:(NSDictionary *)dataDict
{
    _dataDict = dataDict;
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
