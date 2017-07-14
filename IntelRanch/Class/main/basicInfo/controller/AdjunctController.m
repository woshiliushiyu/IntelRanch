//
//  AdjunctController.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/7.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "AdjunctController.h"
#import "HXPhotoViewController.h"
#import "HXPhotoView.h"
@interface AdjunctController ()<HXPhotoViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) HXPhotoManager *manager;
@property (strong, nonatomic) HXPhotoView *photoView;
@property(nonatomic,strong)UILabel * nameLabel;

@property(nonatomic,strong)UILabel * fristLabel;
@property(nonatomic,strong)UILabel * secondLabel;
@property(nonatomic,strong)UITextField * markTextView;
@property(nonatomic,strong)UITextField * persionTextView;
@end

@implementation AdjunctController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.bgView addSubview:self.nameLabel];
    self.navigationItem.title = @"新增附件";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = YES;
    HXPhotoView *photoView = [HXPhotoView photoManager:self.manager];
    photoView.frame = CGRectMake(10, CGRectGetMaxY(self.nameLabel.frame)+10, Width - 60, 0);
    photoView.delegate = self;
    photoView.backgroundColor = [UIColor whiteColor];
    [self.bgView addSubview:photoView];
    self.photoView = photoView;
    [self addChildView];
    
    [self addShadowToCell:self.bgView];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"上传" style:UIBarButtonItemStylePlain target:self action:@selector(didNavBtnClick)];
}
- (void)didNavBtnClick {
    
    NSLog(@"上传");
}
- (void)photoViewChangeComplete:(NSArray<HXPhotoModel *> *)allList Photos:(NSArray<HXPhotoModel *> *)photos Videos:(NSArray<HXPhotoModel *> *)videos Original:(BOOL)isOriginal
{
    NSLog(@"所有:%ld - 照片:%ld - 视频:%ld",allList.count,photos.count,videos.count);
    [HXPhotoTools getImageForSelectedPhoto:photos type:HXPhotoToolsFetchHDImageType completion:^(NSArray<UIImage *> *images) {
        NSLog(@"%@",images);
    }];
}
- (void)photoViewDeleteNetworkPhoto:(NSString *)networkPhotoUrl {
    NSLog(@"%@",networkPhotoUrl);
}

- (void)photoViewUpdateFrame:(CGRect)frame withView:(HXPhotoView *)photoView
{
    NSLog(@"%@===%f",NSStringFromCGRect(frame),Height);
    
    if (frame.size.height>=300 && Height<=568) {
//        self.bgScrollView.contentSize = CGSizeMake(Width, Height+200);
    }
}
-(void)addShadowToCell:(UIView*)bgView
{
    bgView.layer.shadowColor = [UIColor grayColor].CGColor;
    bgView.layer.shadowOpacity = 0.8f;
    bgView.layer.shadowOffset = CGSizeMake(0, 0);
    bgView.layer.shadowRadius = 5.0f;
}
-(void)addChildView
{
    [self.bgView addSubview:self.fristLabel];
    [self.bgView addSubview:self.secondLabel];
    [self.bgView addSubview:self.markTextView];
    [self.bgView addSubview:self.persionTextView];
    
    self.markTextView.backgroundColor = BGCOLOR;
    self.persionTextView.backgroundColor = BGCOLOR;
    
    [self.fristLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.photoView.mas_bottom).offset(10);
        make.left.mas_equalTo(self.bgView).offset(10);
    }];
    [self.markTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(10);
        make.top.mas_equalTo(self.fristLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(30);
    }];
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(10);
        make.top.mas_equalTo(self.markTextView.mas_bottom).offset(10);
    }];
    [self.persionTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(10);
        make.top.mas_equalTo(self.secondLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(30);
    }];
}
- (HXPhotoManager *)manager
{
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
        _manager.openCamera = YES;
        _manager.outerCamera = YES;
        _manager.showFullScreenCamera = YES;
        _manager.photoMaxNum = 9;
        _manager.videoMaxNum = 1;
        _manager.maxNum = 9;
    }
    return _manager;
}
-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        
        _nameLabel = Label.str(@"选择附件").color(@"block").fnt(18).xywh(10,10,Width,20).lineGap(10);
    }
    return _nameLabel;
}
#pragma mark ======lazy
-(UILabel *)fristLabel
{
    if (!_fristLabel) {
        
        _fristLabel = Label.str(@"备注说明").fnt(18).color(@"block").lineGap(10);
    }
    return _fristLabel;
}
-(UILabel *)secondLabel
{
    if (!_secondLabel) {
        
        _secondLabel = Label.str(@"上传人").fnt(18).color(@"block");
    }
    return _secondLabel;
}
-(UITextField *)markTextView
{
    if (!_markTextView) {
        
        _markTextView = TextField.hint(@"备注...").color(@"block").fnt(@"15").onChange(^(NSString *text){
            
            NSLog(@"这是备注输入%@",text);
            
        }).borderRadius(5).insets(0,5,0,0).doneReturnKey.onFinish(^(NSString *text){
            
            NSLog(@"完成是的获取%@",text);
        });
    }
    return _markTextView;
}
-(UITextField *)persionTextView
{
    if (!_persionTextView) {
        
        _persionTextView = TextField.hint(@"上传人").color(@"block").fnt(@"15").onChange(^(NSString *text){
            
            NSLog(@"这是上传输入%@",text);
            
        }).borderRadius(5).insets(0,5,0,0).doneReturnKey.onFinish(^(NSString *text){
        
            NSLog(@"完成时的获取%@",text);
        });
    }
    return _persionTextView;
}


@end
