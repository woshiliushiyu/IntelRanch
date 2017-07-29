//
//  SelectTableView.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/13.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "SelectTableView.h"
#import "FooterBtnCell.h"
#import "SudokuFooterView.h"
@interface SelectTableViewCell : UITableViewCell
@property(nonatomic,copy)void (^SelectAddBlock)();
@property(nonatomic,copy)BOOL (^SelectRowBlock)(NSInteger line,NSInteger row);

-(void)setItemTitles:(NSArray*)titles SubTitles:(NSArray *)subTitles Bodys:(NSArray*)bodys IndexPath:(NSIndexPath *)indexPath ShowAddBtn:(BOOL)addBtn Select:(BOOL)select;

@property(nonatomic,strong)UIButton * tempBtn;
@property(nonatomic,strong)UIButton * addActionBtn;
@property(nonatomic,strong)UIView * backView;
@end
@implementation SelectTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}
-(void)setItemTitles:(NSArray *)titles SubTitles:(NSArray *)subTitles Bodys:(NSArray *)bodys IndexPath:(NSIndexPath *)indexPath ShowAddBtn:(BOOL)addBtn Select:(BOOL)select
{
    if (addBtn && self.addActionBtn ==nil) {
        
        self.addActionBtn = Button.bgColor(@"white").xywh(0,(titles.count?30:0)+(bodys.count?0:30)+(bodys.count?30:0)+subTitles.count*30+(bodys.count-1)*30,Width-60,30).str(@"+ 添加样本").color(@"252,207,134").fnt(15).onClick(^(UIButton * btn){
        
            self.SelectAddBlock();
        });
        
        [self.contentView addSubview:self.addActionBtn];
        
        
    }else{
        
        self.addActionBtn.frame = CGRectMake(0,(titles.count?30:0)+30+(bodys.count?30:0)+(subTitles.count-1)*30+(bodys.count-1)*30,Width-60,30);
    }
    
    if (titles.count ) {
        
        CGFloat width = (Width-60)/titles.count;
        
        for (int i=0; i<titles.count; i++) {
            
            UILabel * headerLabel = Label.str(titles[i]).color(@"121,121,121").xywh(i*width,0,width,30).bgColor(BGCOLOR).centerAlignment.fnt(12.0f).tg(100+i).border(0.5,@"white");
            [self.contentView addSubview:headerLabel];
        }
    }
    if (subTitles.count) {

        for (int i=0; i<subTitles.count; i++) {
            
            NSArray * array = subTitles[i];
            
            CGFloat width = (Width-60)/array.count;
            
            for (int j=0; j<array.count; j++) {
                
                UILabel * headerLabel = Label.str(array[j]).color(@"121,121,121").xywh(j*width,(i*30)+(titles.count?30:0),width,30).bgColor(BGCOLOR).centerAlignment.fnt(12.0f).tg(100+j).border(0.5,@"white");
                
                [self.contentView addSubview:headerLabel];
            }
        }
    }
    if (bodys.count) {
        
        for (int j=0; j<bodys.count; j++) {
            
            NSArray * array = bodys[j];
            
            CGFloat width = (Width-60)/array.count;
            
            for (int i=0; i<array.count; i++) {
                
                NSString * title = [array[i] isEqualToString:@""] | [array[i] isEqualToString:@"1"]?@"":array[i];
                
                UIButton * mBtn = Button.bgColor(BGCOLOR).str(title).selectedImg(@"").fnt(12.0f).color(@"121,121,121").insets(5,[title isEqualToString:@""]?(width-20)/2:0).xywh(i*width,(j*30)+(titles.count?30:0)+(subTitles.count?30:0),width,30).border(0.5,@"white").tg(100+i).onClick(^(UIButton * mBtn){
                    
                    if (select) {
                        
                        if (!self.SelectRowBlock(j+bodys.count, i+1)) {
                            
                            return;
                        }
                        
                        if (mBtn.selected) {
                            
//                            [mBtn setImage:[UIImage yy_imageWithColor:BGCOLOR] forState:UIControlStateNormal];
                            return;
                            
                        }else{
                            
                            self.tempBtn.selected = NO;
                            
                            [mBtn setImage:GetImage(@"duihao") forState:UIControlStateSelected];
                        }
    
                        mBtn.selected = !mBtn.selected;
                        
                        self.tempBtn = mBtn;
                    }
                });
                
                if ([array[i] isEqualToString:@"1"]) {
                    
                    mBtn.selected = YES;
                    
                    [mBtn setImage:GetImage(@"duihao") forState:UIControlStateSelected];
                }else{
                    
                    mBtn.selected = NO;
                }
                [self addSubview:mBtn];
            }
        }
    }
}

@end

@interface SelectTableView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * _titles;
    BOOL _select;
    BOOL _showAddBtn;
    NSArray * _footerView;
    NSArray * _titlesArray;
}
@property(nonatomic,strong)NSMutableArray * subTitles;
@property(nonatomic,strong)NSMutableArray * bodys;
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation SelectTableView

- (instancetype)initWithTitles:(NSArray*)titles SubTitles:(NSArray*)subTitles TableBody:(NSArray*)bodys Select:(BOOL)select FooterView:(NSArray *)footerView Titles:(NSArray *)titlesArray
{
    self = [super init];
    if (self) {
        
        _titles = titles;
        self.subTitles = subTitles.mutableCopy;
        self.bodys = bodys.mutableCopy;
        _titlesArray = titlesArray.mutableCopy;
        _select = select;
        _showAddBtn = YES;
        _footerView = footerView;
        
        [self addSubview:self.tableView];
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
    }
    return self;
}
-(void)setBodyArray:(NSArray *)bodyArray
{
    _bodyArray = bodyArray;
    
    [self.bodys removeAllObjects];

    [self.bodys addObjectsFromArray:bodyArray];
    
    [self.tableView reloadData];
}
-(void)setSubTitleArray:(NSArray *)subTitleArray
{
    _subTitleArray = subTitleArray;
    
    [self.subTitles addObjectsFromArray:subTitleArray];
}

-(NSMutableArray *)bodys
{
    if (!_bodys) {
        
        _bodys = [[NSMutableArray alloc] init];
    }
    return _bodys;
}
-(NSMutableArray *)subTitles
{
    if (!_subTitles) {
        
        _subTitles = [[NSMutableArray alloc] init];
    }
    return _subTitles;
}
#pragma mark ======  delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _bodys.count?1:0+_titles.count?1:0+_subTitles.count?1:0+1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakifySelf();
    
    SelectTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithString:NSStringFromClass([SelectTableViewCell class])]];
    
    if (!cell) {
        
        cell = [[SelectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithString:NSStringFromClass([SelectTableViewCell class])]];
        
    }
    [cell setItemTitles:_titles SubTitles:_subTitles Bodys:_bodys IndexPath:indexPath ShowAddBtn:_select Select:_select];
    
    cell.SelectRowBlock = ^(NSInteger line, NSInteger row) {
        
        return self.SelectRowBlock(line, row);
    };
    cell.SelectAddBlock = ^{
        
        self.SelectAddBlock();
    };

    if (self.BackHeightBlock ) {
        
        self.BackHeightBlock();
    }

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30.0f*((_bodys.count+_titles.count+_subTitles.count)-3);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return _footerView.count>0?250:0;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[SudokuFooterView alloc] initWithImgs:_footerView Titles:_titlesArray];
}
#pragma mark ======  lazy
-(UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        
    }
    return _tableView;
}
@end
