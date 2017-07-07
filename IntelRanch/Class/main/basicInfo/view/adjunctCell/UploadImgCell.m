//
//  UploadImgCell.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/6.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "UploadImgCell.h"
#import "HXPhotoViewController.h"
#import "HXPhotoView.h"
@interface UploadImgCell ()<HXPhotoViewDelegate>
{
    CGFloat cellHeight;
}
@property (strong, nonatomic) HXPhotoManager *manager;
@property (strong, nonatomic) HXPhotoView *photoView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation UploadImgCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self = [[NSBundle mainBundle] loadNibNamed:[NSString stringWithString:NSStringFromClass([self class])] owner:self options:nil].firstObject;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.userInteractionEnabled = YES;
        HXPhotoView *photoView = [HXPhotoView photoManager:self.manager];
        photoView.delegate = self;
        photoView.backgroundColor = [UIColor whiteColor];
        [self addSubview:photoView];
        [photoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
            make.right.mas_equalTo(-10);
            make.left.mas_equalTo(10);
            make.height.mas_equalTo(0);
        }];
        self.photoView = photoView;
    }
    return self;
}
- (void)didNavBtnClick {
    [self.photoView goPhotoViewController];
}
- (void)photoViewChangeComplete:(NSArray<HXPhotoModel *> *)allList Photos:(NSArray<HXPhotoModel *> *)photos Videos:(NSArray<HXPhotoModel *> *)videos Original:(BOOL)isOriginal
{
    NSLog(@"所有:%ld - 照片:%ld - 视频:%ld",allList.count,photos.count,videos.count);
    [HXPhotoTools getImageForSelectedPhoto:photos type:HXPhotoToolsFetchHDImageType completion:^(NSArray<UIImage *> *images) {
        NSLog(@"%@",images);
    }];
    
    self.cellHeight = cellHeight;
    
}
- (void)photoViewDeleteNetworkPhoto:(NSString *)networkPhotoUrl {
    NSLog(@"%@",networkPhotoUrl);
}

- (void)photoViewUpdateFrame:(CGRect)frame withView:(HXPhotoView *)photoView
{
    NSLog(@"%@",NSStringFromCGRect(frame));
    cellHeight = frame.size.height;
    
}
// 压缩视频并写入沙盒文件
- (void)compressedVideoWithURL:(id)url success:(void(^)(NSString *fileName))success failure:(void(^)())failure
{
    AVURLAsset *avAsset;
    if ([url isKindOfClass:[NSURL class]]) {
        avAsset = [AVURLAsset assetWithURL:url];
    }else if ([url isKindOfClass:[AVAsset class]]) {
        avAsset = (AVURLAsset *)url;
    }
    
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
        
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
        
        NSString *fileName = @""; // 这里是自己定义的文件路径
        
        NSDate *nowDate = [NSDate date];
        NSString *dateStr = [NSString stringWithFormat:@"%ld", (long)[nowDate timeIntervalSince1970]];
        
        NSString *numStr = [NSString stringWithFormat:@"%d",arc4random()%10000];
        fileName = [fileName stringByAppendingString:dateStr];
        fileName = [fileName stringByAppendingString:numStr];
        
        // ````` 这里取的是时间加上一些随机数  保证每次写入文件的路径不一样
        fileName = [fileName stringByAppendingString:@".mp4"]; // 视频后缀
        NSString *fileName1 = [NSTemporaryDirectory() stringByAppendingString:fileName]; //文件名称
        exportSession.outputURL = [NSURL fileURLWithPath:fileName1];
        exportSession.outputFileType = AVFileTypeMPEG4;
        exportSession.shouldOptimizeForNetworkUse = YES;
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            
            switch (exportSession.status) {
                case AVAssetExportSessionStatusCancelled:
                    break;
                case AVAssetExportSessionStatusCompleted:
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (success) {
                            success(fileName1);
                        }
                    });
                }
                    break;
                case AVAssetExportSessionStatusExporting:
                    break;
                case AVAssetExportSessionStatusFailed:
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (failure) {
                            failure();
                        }
                    });
                }
                    break;
                case AVAssetExportSessionStatusUnknown:
                    break;
                case AVAssetExportSessionStatusWaiting:
                    break;
                default:
                    break;
            }
        }];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (HXPhotoManager *)manager
{
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
        _manager.openCamera = YES;
        _manager.outerCamera = YES;
        _manager.showFullScreenCamera = YES;
        _manager.photoMaxNum = 8;
        _manager.videoMaxNum = 1;
        _manager.maxNum = 9;
    }
    return _manager;
}
@end
