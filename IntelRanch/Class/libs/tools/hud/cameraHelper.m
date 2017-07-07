//
//  cameraHelper.m
//  MobileProject
//
//  Created by wujunyang on 16/7/20.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "cameraHelper.h"
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAssetRepresentation.h>

@import AVFoundation;

@implementation cameraHelper

+ (BOOL)checkPhotoLibraryAuthorizationStatus
{
        ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
            if (ALAuthorizationStatusDenied == authStatus ||
                ALAuthorizationStatusRestricted == authStatus) {
                [LCProgressHUD showFailure:@"请在iPhone的“设置->隐私->照片”中打开本应用的访问权限"];
                return NO;
        }
    return YES;
}

+ (BOOL)checkCameraAuthorizationStatus
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [LCProgressHUD showFailure:@"该设备不支持拍照"];
        return NO;
    }

    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)]) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (AVAuthorizationStatusDenied == authStatus ||
            AVAuthorizationStatusRestricted == authStatus) {
            [LCProgressHUD showFailure:@"请在iPhone的“设置->隐私->相机”中打开本应用的访问权限"];
            return NO;
        }
    }
    return YES;
}

@end
