//
//  GradeViewCell.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/13.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "GradeViewCell.h"
#import "SelectTableView.h"
#import "SicknessModel.h"
@interface GradeViewCell ()
@property (strong, nonatomic) IBOutlet UIView *bgRootView;
@property(nonatomic,strong)NSMutableArray * tempArray;
@property(nonatomic,strong)NSMutableArray * bexArray;
@property(nonatomic,strong)NSMutableArray * noseArray;
@property(nonatomic,strong)NSMutableArray * eyeArray;
@property(nonatomic,strong)NSMutableArray * earArray;
@property(nonatomic,strong)NSMutableArray * shitArray;
@property (strong, nonatomic) IBOutlet UIView *bgView;
@end

@implementation GradeViewCell
+(GradeViewCell *)setTableViewCustomCell:(UITableView*)tableView IndexPath:(NSIndexPath*)indexPath
{
    GradeViewCell * cell  = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithString:NSStringFromClass([self class])]];
    
    if (!cell) {
        
        cell = [[GradeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithString:NSStringFromClass([self class])]];
    }
    
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self = [[NSBundle mainBundle] loadNibNamed:[NSString stringWithString:NSStringFromClass([self class])] owner:self options:nil].firstObject;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addShadowToCell:self.bgRootView];
    }
    return self;
}
-(void)setDescriptArray:(NSMutableArray *)descriptArray
{
    _descriptArray = descriptArray;

    __block NSInteger n=1;
    
    [descriptArray enumerateObjectsUsingBlock:^(SicknessModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([model.type integerValue] == 1) {
            
            NSMutableArray * array = [[NSMutableArray alloc] initWithArray:@[[NSString stringWithFormat:@"样本"],@"",@"",@"",@""]];

            [array replaceObjectAtIndex:[model.score integerValue]+1 withObject:@"1"];
            
            [self.tempArray addObject:array];
           
            n++;
        }
        if ([model.type integerValue] == 4) {
            
            NSMutableArray * array = [[NSMutableArray alloc] initWithArray:@[[NSString stringWithFormat:@"样本"],@"",@"",@"",@""]];
            
            [array replaceObjectAtIndex:[model.score integerValue]+1 withObject:@"1"];
            
            [self.bexArray addObject:array];
            
            n++;
        }
        if ([model.type integerValue] == 3) {
            
            NSMutableArray * array = [[NSMutableArray alloc] initWithArray:@[[NSString stringWithFormat:@"样本"],@"",@"",@"",@""]];
            
            [array replaceObjectAtIndex:[model.score integerValue]+1 withObject:@"1"];
            
            [self.noseArray addObject:array];
            
            n++;
        }
        if ([model.type integerValue] == 5) {
            
            NSMutableArray * array = [[NSMutableArray alloc] initWithArray:@[[NSString stringWithFormat:@"样本"],@"",@"",@"",@""]];
            
            [array replaceObjectAtIndex:[model.score integerValue]+1 withObject:@"1"];
            
            [self.eyeArray addObject:array];
            
            n++;
        }
        if ([model.type integerValue] == 6) {
            
            NSMutableArray * array = [[NSMutableArray alloc] initWithArray:@[[NSString stringWithFormat:@"样本"],@"",@"",@"",@""]];
            
            [array replaceObjectAtIndex:[model.score integerValue]+1 withObject:@"1"];
            
            [self.earArray addObject:array];
            
            n++;
        }
        if ([model.type integerValue] == 2) {
            
            NSMutableArray * array = [[NSMutableArray alloc] initWithArray:@[[NSString stringWithFormat:@"样本"],@"",@""]];
            
            [array replaceObjectAtIndex:1 withObject:model.value1];
            [array replaceObjectAtIndex:2 withObject:model.value2];
            
            [self.shitArray addObject:array];
            
            n++;
        }
    }];
    [self addSubViewToself];
}
-(void)addSubViewToself
{
    if ([_type isEqualToString:@"2"]) {
        
        SelectTableView * mView = [[SelectTableView alloc] initWithTitles:@[@"评分",@"0分",@"1分",@"2分",@"3分"] SubTitles:@[@[@"温度范围",@"37.8~38.3",@"38.3~38.9",@"38.8~39.4",@">39.4"]] TableBody:[[self.tempArray reverseObjectEnumerator] allObjects] Select:NO FooterView:nil Titles:nil];
        
        mView.SelectRowBlock = ^(NSInteger line, NSInteger row) {
            return YES;
        };
        
        [self.bgView addSubview:mView];
        [mView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(_bgView);
        }];
    }
    if ([_type isEqualToString:@"6"]) {
        
        SelectTableView * mView = [[SelectTableView alloc] initWithTitles:@[@"评分",@"0分",@"1分",@"2分",@"3分"] SubTitles:@[@[@"症状",@"无咳嗽",@"触捏喉头单",@"触捏喉头反",@"无需触捏喉头"]] TableBody:[[self.bexArray reverseObjectEnumerator] allObjects]  Select:NO FooterView:nil Titles:nil];
        
        mView.SelectRowBlock = ^(NSInteger line, NSInteger row) {
            return YES;
        };
        
        [self.bgView addSubview:mView];
        [mView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(_bgView);
        }];
    }
    if ([_type isEqualToString:@"5"]) {
        
        NSArray * imgs = @[@[@"bja_s",@"bjb_s",@"bjc_s",@"bjd_s"],@[@"bjaa_s",@"bjbb_s",@"bjcc_s",@"bjdd_s"],@[@"bjaaa_s",@"bjbbb_s",@"bjccc_s",@"bjddd_s"]];
        NSArray * lables = @[@[@"0分,正常水样分泌物",@"1分,单侧鼻孔少量白色分泌物",@"2分,双侧鼻孔少量白色分泌物",@"3分,双侧鼻孔大量白色分泌物"],@[@"0分,耳朵状况正常",@"1分,不断晃动耳朵",@"2分,单侧耳朵耷拉",@"3分,头歪斜或双侧耳朵耷拉"],@[@"0分,明亮无任何分泌物",@"1分,眼少量分泌物",@"2分,眼多量分泌物",@"3分,双眼大量分泌物"]];
        
        NSArray * imags = imgs[[_type isEqualToString:@"5"]?0:[_type isEqualToString:@"7"]?1:2];
        NSArray * label = lables[[_type isEqualToString:@"5"]?0:[_type isEqualToString:@"7"]?1:2];
        
        SelectTableView * mView = [[SelectTableView alloc] initWithTitles:@[@"犊牛评估",@"0分",@"1分",@"2分",@"3分"] SubTitles:nil TableBody:[[self.noseArray reverseObjectEnumerator] allObjects] Select:NO FooterView:imags Titles:label];
        
        mView.SelectRowBlock = ^(NSInteger line, NSInteger row) {
            return YES;
        };
        
        [self.bgView addSubview:mView];
        [mView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(_bgView);
        }];
    }
    if ([_type isEqualToString:@"7"]) {
        
        NSArray * imgs = @[@[@"bja_s",@"bjb_s",@"bjc_s",@"bjd_s"],@[@"bjaa_s",@"bjbb_s",@"bjcc_s",@"bjdd_s"],@[@"bjaaa_s",@"bjbbb_s",@"bjccc_s",@"bjddd_s"]];
        NSArray * lables = @[@[@"0分,正常水样分泌物",@"1分,单侧鼻孔少量白色分泌物",@"2分,双侧鼻孔少量白色分泌物",@"3分,双侧鼻孔大量白色分泌物"],@[@"0分,明亮无任何分泌物",@"1分,眼少量分泌物",@"2分,眼多量分泌物",@"3分,双眼大量分泌物"],@[@"0分,耳朵状况正常",@"1分,不断晃动耳朵",@"2分,单侧耳朵耷拉",@"3分,头歪斜或双侧耳朵耷拉"]];
        
        NSArray * imags = imgs[[_type isEqualToString:@"5"]?0:[_type isEqualToString:@"7"]?1:2];
        NSArray * label = lables[[_type isEqualToString:@"5"]?0:[_type isEqualToString:@"7"]?1:2];
        
        SelectTableView * mView = [[SelectTableView alloc] initWithTitles:@[@"犊牛评估",@"0分",@"1分",@"2分",@"3分"] SubTitles:nil TableBody:[[self.eyeArray reverseObjectEnumerator] allObjects] Select:NO FooterView:imags Titles:label];
        
        mView.SelectRowBlock = ^(NSInteger line, NSInteger row) {
            return YES;
        };
        
        [self.bgView addSubview:mView];
        [mView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(_bgView);
        }];
    }
    if ([_type isEqualToString:@"8"]) {
        
        NSArray * imgs = @[@[@"bja_s",@"bjb_s",@"bjc_s",@"bjd_s"],@[@"bjaa_s",@"bjbb_s",@"bjcc_s",@"bjdd_s"],@[@"bjaaa_s",@"bjbbb_s",@"bjccc_s",@"bjddd_s"]];
        NSArray * lables = @[@[@"0分,正常水样分泌物",@"1分,单侧鼻孔少量白色分泌物",@"2分,双侧鼻孔少量白色分泌物",@"3分,双侧鼻孔大量白色分泌物"],@[@"0分,明亮无任何分泌物",@"1分,眼少量分泌物",@"2分,眼多量分泌物",@"3分,双眼大量分泌物"],@[@"0分,耳朵状况正常",@"1分,不断晃动耳朵",@"2分,单侧耳朵耷拉",@"3分,头歪斜或双侧耳朵耷拉"]];
        
        NSArray * imags = imgs[[_type isEqualToString:@"5"]?0:[_type isEqualToString:@"7"]?1:2];
        NSArray * label = lables[[_type isEqualToString:@"5"]?0:[_type isEqualToString:@"7"]?1:2];
        
        SelectTableView * mView = [[SelectTableView alloc] initWithTitles:@[@"犊牛评估",@"0分",@"1分",@"2分",@"3分"] SubTitles:nil TableBody:[[self.earArray reverseObjectEnumerator] allObjects] Select:NO FooterView:imags Titles:label];
        
        mView.SelectRowBlock = ^(NSInteger line, NSInteger row) {
            return YES;
        };
        
        [self.bgView addSubview:mView];
        [mView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(_bgView);
        }];
    }
    if ([_type isEqualToString:@"3"]) {
        
        SelectTableView * mView = [[SelectTableView alloc] initWithTitles:@[@"序号",@"气味",@"颜色"] SubTitles:[[self.shitArray reverseObjectEnumerator] allObjects] TableBody:nil Select:NO FooterView:nil Titles:nil];
        
        mView.SelectRowBlock = ^(NSInteger line, NSInteger row) {
            return YES;
        };
        
        [self.bgView addSubview:mView];
        [mView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(_bgView);
        }];
    }
}
-(void)setType:(NSString *)type
{
    _type = type;
    

}
- (IBAction)touchPush:(id)sender {
    
    NSInteger num = 0;
    
    if ([_type isEqualToString:@"2"]  |  [_type isEqualToString:@"3"]) {
        num = [_type integerValue]-2;
    }
    if ([_type isEqualToString:@"5"]  |  [_type isEqualToString:@"6"] | [_type isEqualToString:@"7"]  |  [_type isEqualToString:@"8"]) {
        num = [_type integerValue]-3;
    }    
    self.SelectRowBlock(num);
}
-(NSMutableArray *)tempArray
{
    if (!_tempArray) {
        
        _tempArray = [[NSMutableArray alloc] init];
    }
    return _tempArray;
}
-(NSMutableArray *)bexArray
{
    if (!_bexArray) {
        
        _bexArray = [[NSMutableArray alloc] init];
    }
    return _bexArray;
}
-(NSMutableArray *)noseArray
{
    if (!_noseArray) {
        
        _noseArray = [[NSMutableArray alloc] init];
    }
    return _noseArray;
}
-(NSMutableArray *)eyeArray
{
    if (!_eyeArray) {
        
        _eyeArray = [[NSMutableArray alloc] init];
    }
    return _eyeArray;
}
-(NSMutableArray *)earArray
{
    if (!_earArray) {
        
        _earArray = [[NSMutableArray alloc] init];
    }
    return _earArray;
}
-(NSMutableArray *)shitArray
{
    if (!_shitArray) {
        
        _shitArray = [[NSMutableArray alloc] init];
    }
    return _shitArray;
}
-(void)addShadowToCell:(UIView*)bgView
{
    bgView.layer.shadowColor = [UIColor grayColor].CGColor;
    bgView.layer.shadowOpacity = 0.8f;
    bgView.layer.shadowOffset = CGSizeMake(0, 0);
    bgView.layer.shadowRadius = 5.0f;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
