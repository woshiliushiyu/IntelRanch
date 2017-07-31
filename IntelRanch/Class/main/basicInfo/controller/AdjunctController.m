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
#import "HXPhotoModel.h"
#import "HXPhotoPreviewViewController.h"
#import "HXVideoPreviewViewController.h"
@interface AdjunctController ()<HXPhotoViewDelegate>
{
    NSArray * _photos;
    NSArray * _videos;
    NSString * _path;
    BOOL _isImgSuccess;
    BOOL _isVideoSuccess;
    int i;
}
@property (strong, nonatomic) IBOutlet UIView *bgView;

@property (strong, nonatomic) HXPhotoManager *manager;
@property (strong, nonatomic) HXPhotoView *photoView;
@property(nonatomic,strong)UILabel * nameLabel;

@property(nonatomic,strong)UILabel * fristLabel;
@property(nonatomic,strong)UILabel * secondLabel;
@property(nonatomic,strong)UITextField * markTextView;
@property(nonatomic,strong)UITextField * persionTextView;

@property(nonatomic,strong)NSMutableArray * tempArray;
@property(nonatomic,strong)NSMutableArray * imgsArray;
@end

@implementation AdjunctController

- (void)viewDidLoad {
    [super viewDidLoad];

    i=0;
    
    self.navigationItem.title = @"新增附件";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    if (self.videoString.length>0) {
        HXPhotoModel * model = [[HXPhotoModel alloc] init];
        model.type = HXPhotoModelMediaTypeCameraVideo;
        model.videoURL = [NSURL URLWithString:self.videoString];
        model.thumbPhoto = [self getThumbnailImage:self.videoString];
        [self.tempArray addObject:model];
    }
    
    for (NSString * urlString in self.imagesArray) {
        HXPhotoModel * model = [[HXPhotoModel alloc] init];
        model.type = HXPhotoModelMediaTypePhoto;
        model.networkPhotoUrl = urlString;
        [self.tempArray addObject:model];
    }

    HXPhotoView *photoView = [HXPhotoView photoManager:self.manager SelectData:[[self.tempArray reverseObjectEnumerator] allObjects].mutableCopy];
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
    
    [LCProgressHUD showLoading:@"正在上传..."];
    
    if (_videos.count>0) {
        
        HXPhotoModel * model = _videos[0];
        
        [[RequestTool sharedRequestTool] uploadWithMediaType:@"video" Media:model.videoURL==nil?[NSURL fileURLWithPath:_path]:model.videoURL FinishedBlock:^(id result, NSError *error) {
            
            if ([result[@"status_code"] integerValue] == 200) {
                
                [LCProgressHUD showSuccess:@"上传视频成功"];
                
                [self uploadVideo:result[@"data"]];
                
            }else{
                
                [LCProgressHUD showInfoMsg:result[@"message"]];
            }
        }];
    }
    if (_photos.count>0){
        
        [[RequestTool sharedRequestTool] uploadWithMediaType:@"image" Media:UIImageJPEGRepresentation(_photos[i], 0.1) FinishedBlock:^(id result, NSError *error) {
            
            if ([result[@"status_code"] integerValue] == 200) {
                
                [self.imgsArray addObject:result[@"data"]];
                
                if (_photos.count==1) {
                    
                    [self uploadImgs];
                }else{
                    
                    [self uploadImage];
                }
                
            }else{
                [LCProgressHUD showMessage:@"上传失败"];
            }
        }];
    }else if (self.imagesArray.count>0) {
        
        [self uploadImgs];
    }
}
-(void)uploadImage
{
    i++;
    
    [[RequestTool sharedRequestTool] uploadWithMediaType:@"image" Media:UIImageJPEGRepresentation(_photos[i], 0.1) FinishedBlock:^(id result, NSError *error) {
        
        if ([result[@"status_code"] integerValue] == 200) {

            [self.imgsArray addObject:result[@"data"]];
            
            if (_photos.count-1 == i) {
                
                [self uploadImgs];
            }else{
                [self uploadImage];
            }
        }else{
             [LCProgressHUD showFailure:@"上传失败"];
        }
    }];
}
//upload video
-(void)uploadVideo:(NSString*)video
{
    [[RequestTool sharedRequestTool] uploadWithVideosList:video Summery:self.markTextView.text Type:[self.typeString integerValue] ModelId:self.idString FinishedBlock:^(id result, NSError *error) {
        
        if ([result[@"status_code"] integerValue] == 200) {
            
            _isVideoSuccess = YES;
            
            NSArray * array = result[@"data"];
            
            if ((_isVideoSuccess && _isImgSuccess) || _photos.count ==0  || array.count==0) {
                
                [LCProgressHUD showSuccess:@"视频上传成功"];
                
                self.navigationItem.rightBarButtonItem.enabled = NO;
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }

        }else{
            
            [LCProgressHUD showInfoMsg:result[@"message"]];
        }
    }];
}
//上传图片列表
-(void)uploadImgs
{
    [[RequestTool sharedRequestTool] uploadWithImgList:self.imgsArray Summery:self.markTextView.text Type:[self.typeString integerValue] ModelId:self.idString FinishedBlock:^(id result, NSError *error) {
        
        if ([result[@"status_code"] integerValue] == 200) {
            
            _isImgSuccess = YES;
            
            NSArray * array = result[@"data"];
         
            if ((_isVideoSuccess && _isImgSuccess) || _videos.count ==0 || array.count==0) {
                
                [LCProgressHUD showSuccess:@"图片上传成功"];
                
                self.navigationItem.rightBarButtonItem.enabled = NO;
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
        }else{
            
            [LCProgressHUD showInfoMsg:result[@"message"]];
        }
    }];
}
/*********************************/
- (void)photoViewChangeComplete:(NSArray<HXPhotoModel *> *)allList Photos:(NSArray<HXPhotoModel *> *)photos Videos:(NSArray<HXPhotoModel *> *)videos Original:(BOOL)isOriginal
{
    _videos = videos;
    if (videos.count ==0 && photos.count == 0) {
        
        self.navigationItem.rightBarButtonItem = nil;
    }else{
        
        self.navigationItem.rightBarButtonItem = nil;
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"上传" style:UIBarButtonItemStylePlain target:self action:@selector(didNavBtnClick)];
    }
    
    if (videos.count>0) {
        
        [[PHImageManager defaultManager] requestPlayerItemForVideo:videos[0].asset options:nil resultHandler:^(AVPlayerItem * _Nullable playerItem, NSDictionary * _Nullable info) {
            
            _path = [info[@"PHImageFileSandboxExtensionTokenKey"] componentsSeparatedByString:@";"].lastObject;
        }];
    }
    NSMutableArray * tempPhotos = [[NSMutableArray alloc] init];
    
    [self.imgsArray removeAllObjects];
    
    [photos enumerateObjectsUsingBlock:^(HXPhotoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.networkPhotoUrl.length==0) {
            
            [tempPhotos addObject:obj];
        }else{
            
            [self.imgsArray addObject:obj.networkPhotoUrl];
        }
    }];
    
    [HXPhotoTools getImageForSelectedPhoto:tempPhotos type:HXPhotoToolsFetchHDImageType completion:^(NSArray<UIImage *> *images) {
        _photos = images;
    }];
}
- (void)photoViewUpdateFrame:(CGRect)frame withView:(HXPhotoView *)photoView
{
    NSLog(@"获取的坐标地址%@",[NSValue valueWithCGRect:frame]);
}
- (void)photoViewDeleteNetworkPhoto:(NSString *)networkPhotoUrl
{
    
}
/********************************/
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
    [self.bgView addSubview:self.markTextView];
    
    self.markTextView.backgroundColor = BGCOLOR;
    
    [self.fristLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.photoView.mas_bottom).offset(5);
        make.left.mas_equalTo(self.bgView).offset(10);
        make.height.mas_equalTo(10);
    }];
    [self.markTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(10);
        make.top.mas_equalTo(self.fristLabel.mas_bottom).offset(5);
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
        _manager.separate = YES;
        _manager.showFullScreenCamera = YES;
        _manager.photoMaxNum = 9;
        _manager.videoMaxNum = 1;
        _manager.maxNum = 10;
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
-(NSMutableArray *)imgsArray
{
    if (!_imgsArray) {
        
        _imgsArray = [[NSMutableArray alloc] init];
    }
    return _imgsArray;
}
-(NSMutableArray *)tempArray
{
    if (!_tempArray) {
        
        _tempArray = [[NSMutableArray alloc] init];
    }
    return _tempArray;
}
-(void)setImagesArray:(NSArray *)imagesArray
{
    _imagesArray = imagesArray;
}
-(UILabel *)fristLabel
{
    if (!_fristLabel) {
        
        _fristLabel = Label.str(@"备注说明").fnt(13).color(@"block").lineGap(0);
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
- (UIImage *)getThumbnailImage:(NSString *)videoURL
{
    UIImage *shotImage;
    
    NSURL *fileURL = [NSURL URLWithString:videoURL];
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:fileURL options:nil];
    
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    shotImage = [[UIImage alloc] initWithCGImage:image];
    
    NSLog(@"获取的图片===>%@",error);
    
    CGImageRelease(image);
    
    return shotImage;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
