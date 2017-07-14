//
//  SelectTableView.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/13.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "SelectTableView.h"
#import "FooterBtnCell.h"
@interface SelectTableViewCell : UITableViewCell
@property(nonatomic,copy)void (^SelectAddBlock)();
@property(nonatomic,copy)void (^SelectRowBlock)(NSInteger line,NSInteger row);

-(void)setItemTitles:(NSArray*)titles SubTitles:(NSArray *)subTitles Bodys:(NSArray*)bodys IndexPath:(NSIndexPath *)indexPath ShowAddBtn:(BOOL)addBtn Select:(BOOL)select;

@property(nonatomic,strong)UIButton * tempBtn;
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
    if (addBtn) {
        
        UIButton * addBtn = Button.bgColor(@"white").xywh(0,(titles.count?30:0)+(subTitles.count?30:0)+(bodys.count?30:0),Width-60,30).str(@"+ 添加样本").color(@"252,207,134").fnt(15).onClick(^(UIButton * btn){
        
            self.SelectAddBlock();
        });
        [self.contentView addSubview:addBtn];
    }
    
    if (titles.count ) {
        
        CGFloat width = (Width-60)/titles.count;
        
        for (int i=0; i<titles.count; i++) {
            
            UILabel * headerLabel = Label.str(titles[i]).color(@"186,186,188").xywh(i*width,0,width,30).bgColor(BGCOLOR).centerAlignment.fnt(12.0f).tg(100+i).border(0.5,@"white");
            [self.contentView addSubview:headerLabel];
        }
    }
    if (subTitles.count) {
        
        CGFloat width = (Width-60)/subTitles.count;
        
        for (int i=0; i<subTitles.count; i++) {
            
            UILabel * headerLabel = Label.str(subTitles[i]).color(@"186,186,188").xywh(i*width,titles.count?30:0,width,30).bgColor(BGCOLOR).centerAlignment.fnt(12.0f).tg(100+i).border(0.5,@"white");
            [self.contentView addSubview:headerLabel];
        }
    }
    if (bodys.count) {
        
        for (int j=0; j<bodys.count; j++) {
            
            NSArray * array = bodys[j];
            
            CGFloat width = (Width-60)/array.count;
            
            for (int i=0; i<array.count; i++) {
                
                UIButton * mBtn = Button.bgColor(BGCOLOR).selectedImg(@"").insets(5,(width-20)/2).xywh(i*width,(j*30)+(titles.count?30:0)+(subTitles.count?30:0),width,30).border(0.5,@"white").tg(100+i).onClick(^(UIButton * mBtn){
                    
                    if (select) {
                        
                        if (mBtn.selected) {
                            
                            [mBtn setImage:[UIImage yy_imageWithColor:BGCOLOR] forState:UIControlStateNormal];
                            
                        }else{
                            
                            self.tempBtn.selected = NO;
                            
                            [mBtn setImage:GetImage(@"mima") forState:UIControlStateSelected];
                        }
                        
                        self.SelectRowBlock(j+1, i+1);
                        
                        mBtn.selected = !mBtn.selected;
                        
                        self.tempBtn = mBtn;
                    }
                });
                
                if (!select) {
                    
                    if ([array[i] isEqualToString:@"1"]) {
                        
                        mBtn.selected = YES;
                        
                        [mBtn setImage:GetImage(@"mima") forState:UIControlStateSelected];
                    }else{
                        
                        mBtn.selected = NO;
                    }
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
    NSArray * _subTitles;
    NSArray * _bodys;
    BOOL _select;
    BOOL _showAddBtn;
    UIView * _footerView;
}
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation SelectTableView

- (instancetype)initWithTitles:(NSArray*)titles SubTitles:(NSArray*)subTitles TableBody:(NSArray*)bodys Select:(BOOL)select FooterView:(UIView *)footerView
{
    self = [super init];
    if (self) {
        
        _titles = titles;
        _subTitles = subTitles;
        _bodys = bodys;
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
    SelectTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithString:NSStringFromClass([SelectTableViewCell class])]];
    
    if (!cell) {
        
        cell = [[SelectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithString:NSStringFromClass([SelectTableViewCell class])]];
        
    }
    [cell setItemTitles:_titles SubTitles:_subTitles Bodys:_bodys IndexPath:indexPath ShowAddBtn:_select Select:_select];
    
    cell.SelectRowBlock = ^(NSInteger line, NSInteger row) {
        
        self.SelectRowBlock(line, row);
    };
    cell.SelectAddBlock = ^{
        
        self.SelectAddBlock();
    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30.0f*(_bodys.count+_titles.count+_subTitles.count);
}
#pragma mark ======  lazy
-(UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = _footerView;
        _tableView.scrollEnabled = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        
    }
    return _tableView;
}
@end
