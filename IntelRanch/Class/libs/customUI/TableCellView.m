//
//  TableCellView.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/8.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "TableCellView.h"
#import "FooterBtnCell.h"
@interface TableCellViewCell : UITableViewCell
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,copy)void (^SelectRowSectionBlock)(NSInteger line,NSInteger list);

-(void)addObjects:(NSArray*)objects Tags:(NSArray*)tags Index:(NSInteger)index Font:(NSInteger)font Heights:(CGFloat)heights;

-(void)addTitles:(NSArray*)titles Index:(NSInteger)index Font:(NSInteger)font Heights:(CGFloat)heights;

@end
@implementation TableCellViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
-(void)addObjects:(NSArray *)objects Tags:(NSArray *)tags Index:(NSInteger)index Font:(NSInteger)font Heights:(CGFloat)heights
{
    CGFloat width = (Width-60)/tags.count;
    
    for (int i=0; i<tags.count; i++) {
        
        _nameLabel = Label.str([[objects objectAtIndex:index] valueForKey:[tags objectAtIndex:i]]).xywh(i*width,0,width,heights).bgColor(BGCOLOR).color(@"121,121,121").centerAlignment.fnt(font).tg(100+i).border(1,@"white").onClick(^(UILabel * lab){
            
            NSLog(@"获取位置 第%ld行  第%ld列",(long)index,lab.tag-99);
            
            if (self.SelectRowSectionBlock && lab.tag>100) {
                
                self.SelectRowSectionBlock(index, lab.tag-99);
            }
        });
        [self addSubview:self.nameLabel];
    }
}
-(void)addTitles:(NSArray*)titles Index:(NSInteger)index Font:(NSInteger)font Heights:(CGFloat)heights
{
    CGFloat width = (Width -60)/titles.count;
    
    for (int i=0; i<titles.count; i++) {
        
        UILabel * nameLabel = Label.str(titles[i]).xywh(i*width,0,width,heights).bgColor(BGCOLOR).color(@"121,121,121").centerAlignment.fnt(font).border(0.5,@"white");
        
        [self addSubview:nameLabel];
    }
}
@end

@interface TableCellView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray * titles;
@property(nonatomic,strong)NSArray * objects;
@property(nonatomic,strong)NSArray * tags;


@property(nonatomic,strong)UITableView * tableView;
@end

@implementation TableCellView
- (instancetype)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {}
    return self;
}
-(void)setTitles:(NSArray *)titles andObjects:(NSArray *)objects withTags:(NSArray *)tags
{

    _titles = titles;
    self.dataArray = objects.mutableCopy;
    _tags = tags;
    
    [self addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}
#pragma mark ====
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count+2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==self.dataArray.count+1) {
        
        FooterBtnCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithString:NSStringFromClass([FooterBtnCell class])]];
        if (!cell) {
            
            cell = [[FooterBtnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithString:NSStringFromClass([FooterBtnCell class])]];
        }
        
        [cell.addBtn addTarget:self action:@selector(selectAddRow) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    
    TableCellViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithString:NSStringFromClass([TableCellViewCell class])]];
    
    if (!cell) {
        
        cell = [[TableCellViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithString:NSStringFromClass([TableCellViewCell class])]];
    }

    if (indexPath.row == 0) {
        
        [cell addTitles:_titles Index:indexPath.row Font:[self fontWithTextFont] Heights:[self setRowHeight]];
        
        return cell;
    }
    
    [cell addObjects:self.dataArray Tags:_tags Index:indexPath.row-1 Font:[self fontWithTextFont] Heights:[self setRowHeight]];
    
    cell.SelectRowSectionBlock = ^(NSInteger line, NSInteger list) {
        
        if ([_delegate respondsToSelector:@selector(selectRowSection:List:)]) {
            
            [self.delegate selectRowSection:line List:list];
        }
    };
    
    return cell;
}
-(void)selectAddRow
{
    if ([_delegate respondsToSelector:@selector(selectAddBtn)]) {

        [self.delegate selectAddBtn];
        
        [self.tableView reloadData];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self setRowHeight];
}
#pragma mark === 实现 ===
-(NSInteger)fontWithTextFont
{
    if ([_delegate respondsToSelector:@selector(fontWithRowText)]) {
        
        return [self.delegate fontWithRowText];
    }else{
        
        return 8.0f;
    }
}
-(CGFloat)setRowHeight
{
    if ([_delegate respondsToSelector:@selector(setRowHeight)]) {
        
        return [self.delegate setRowHeight];
    }else{
        
        return 30.0f;
    }
}
-(void)reloadView
{
    [self.tableView reloadData];
}
#pragma mark === lazy  ===
-(void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
}
-(UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}
@end
