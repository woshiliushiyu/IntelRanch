//
//  InfoController.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/5.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "InfoController.h"
#import "RanchInfoCell.h"
#import "HerdInfoCell.h"
#import "CalfSampleCell.h"
#import "OtherAdjunctCell.h"
#import "AdjunctController.h"
#import "CalfSampleController.h"
#import "RanchInfoController.h"
#import "CattleInfoController.h"
#import "LayoutModel.h"
#import "ImageModel.h"
#import "CalfSampleModel.h"

@interface InfoController ()<AVPlayerViewControllerDelegate>
{
    CGFloat _cellHeight;
    NSString * _videoPath;
    UIImage * _defaultImg;
    NSDictionary * _ranchDict;
}
@property(nonatomic,strong)NSMutableArray * layoutArray;
@property(nonatomic,strong)NSMutableArray * calfSampleArray;
@property(nonatomic,strong)NSMutableArray * imgsArray;
@property(nonatomic,strong)NSMutableArray * getImages;
@end

@implementation InfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = BGCOLOR;
    self.navigationItem.title = @"牧场基本信息";
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.mj_header=  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getLayoutView];
    }];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView.mj_header beginRefreshing];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//获取分页面布局信息
-(void)getLayoutView
{    
    [[RequestTool sharedRequestTool] requestWithRanchBasicLayoutTo:1 FinishedBlock:^(id result, NSError *error) {
        
        if ([result[@"status_code"] integerValue] == 200) {
            
            [self.layoutArray removeAllObjects];
            
            for (NSDictionary * dic in result[@"data"][@"groups"]) {
                
                LayoutModel * model = [[LayoutModel alloc] initWithDictionary:dic error:nil];
                
                [self.layoutArray addObject:model];
            }
            
            [self getVideoData];
            
        }else{
            
            [LCProgressHUD showFailure:result[@"message"]];
        }
    }];
}
-(void)getRanchInfo
{
    [[RequestTool sharedRequestTool] requestWithRanchInfoForServerFinishedBlock:^(id result, NSError *error) {
        
        if ([result[@"status_code"] integerValue] == 200) {
         
            [LocalDataTool putDataToTableName:[NSString stringWithString:NSStringFromClass([MyRanchInfoModel class])] Data:result[@"data"]];
            
            _ranchDict = result[@"data"];
            
            [self getAverageSample];
            
        }else{
            
            [LCProgressHUD showFailure:result[@"message"]];
        }
    }];
}
//获取犊牛样本
-(void)getAverageSample
{
    [[RequestTool sharedRequestTool] requestWithSampleForServerFinishedBlock:^(id result, NSError *error) {
        
        [LCProgressHUD hide];
        
        if ([result[@"status_code"] integerValue] == 200) {
            
            [self.calfSampleArray removeAllObjects];
            
            for (NSDictionary * dic in result[@"data"]) {
                
                CalfSampleModel * model = [[CalfSampleModel alloc] initWithDictionary:dic error:nil];
                
                [self.calfSampleArray addObject:model];
            }
            
            [self getImageListData];
        }else{
            [LCProgressHUD showMessage:result[@"message"]];
        }
    }];
}
//获取图片
-(void)getImageListData
{
    [[RequestTool sharedRequestTool] requestWithImageListType:1 ModelId:nil FinishedBlock:^(id result, NSError *error) {
        
        if ([result[@"status_code"] integerValue] == 200) {
            
            [self.getImages removeAllObjects];
            
            for (NSDictionary * dic in result[@"data"]) {
                
                ImageModel * model = [[ImageModel alloc] initWithDictionary:dic error:nil];
                
                [self.getImages addObject:model.url];
            }
            
            [self.tableView reloadData];
            
            [LCProgressHUD hide];
        }else{
            
            [LCProgressHUD showMessage:result[@"message"]];
        }
        [self.tableView.mj_header endRefreshing];
    }];
}
-(void)getVideoData
{
    [[RequestTool sharedRequestTool] requestWithVideosListType:1 ModelId:nil FinishedBlock:^(id result, NSError *error) {
        
        if ([result[@"status_code"] integerValue] == 200) {
            
            NSArray * array = result[@"data"];
            
            if (array.count == 0) {
                
                [self getRanchInfo];
                
            }else{
            
                _videoPath =result[@"data"][0][@"url"];
        
                _defaultImg = [self getThumbnailImage:_videoPath];
                
//                if (_defaultImg !=nil) {
                
                     [self getRanchInfo];
//                }
            }
        }else{
            
            [LCProgressHUD showMessage:result[@"message"]];
        }
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.layoutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WeakifySelf()
    
    if (indexPath.row==0) {
        
        RanchInfoCell *cell = (RanchInfoCell *)[tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
        
            cell = [[RanchInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithString:NSStringFromClass([RanchInfoCell class])]];
        }
        cell.headerLabel.text = @"牧场信息";
        
        if (self.layoutArray.count > 0) {
            
            cell.dataDict = _ranchDict;
            
            cell.infoModel = self.layoutArray[indexPath.row];
        }
        cell.SelectRanchInfoBlock = ^{
            
            if (self.layoutArray.count>0) {
                
                [weakSelf pushNextView:[[RanchInfoController alloc] init] DataModel:self.layoutArray[indexPath.row]];
            }else{
                
                [weakSelf getLayoutView];
            }
        };
        
        return cell;
    }
    if (indexPath.row ==1) {

        HerdInfoCell *cell = (HerdInfoCell *)[tableView cellForRowAtIndexPath:indexPath];

        if (!cell) {
        
            cell = [[HerdInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithString:NSStringFromClass([HerdInfoCell class])]];
        }
        
        if (self.layoutArray.count > 0) {
            
            cell.model = self.layoutArray[indexPath.row];
        }
        
        cell.SelectSetBlock = ^{
            
            if (self.layoutArray.count>0) {
                
                [weakSelf pushNextView:[[CattleInfoController alloc] init] DataModel:self.layoutArray[indexPath.row]];
            }else{
                
                [weakSelf getLayoutView];
            }
        };
        return cell;
    }
    if (indexPath.row ==2) {

        CalfSampleCell *cell = (CalfSampleCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        if (!cell) {
        
            cell = [[CalfSampleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithString:NSStringFromClass([CalfSampleCell class])]];
        }
        
        cell.models = self.calfSampleArray;
        
        cell.PushCalfSampleViewBlock = ^{
            
            if (self.layoutArray.count>0) {
                
                [weakSelf pushNextView:[[CalfSampleController alloc] init] DataModel:self.layoutArray[indexPath.row]];
            }else{
                
                [weakSelf getLayoutView];
            }
        };
        return cell;
    }
    if (indexPath.row ==3) {

        OtherAdjunctCell *cell = (OtherAdjunctCell *)[tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
        
            cell = [[OtherAdjunctCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithString:NSStringFromClass([OtherAdjunctCell class])]];
        
        }
        
        cell.defultImg = _defaultImg;
                
        cell.imgs = self.getImages;
        
        cell.imgTitle.text = @"1.牛场的基本信息照片";
        
        cell.videoTitle.text = @"2.牧场的视频";
        
        cell.TouchAddBlock = ^{
            
            if (self.layoutArray.count>0) {
                
                [weakSelf pushNextView:[[AdjunctController alloc] init] DataModel:self.layoutArray[indexPath.row]];
            }else{
                
                [weakSelf getLayoutView];
            }
        };
        cell.TouchVideoBlock = ^{

            AVPlayerViewController *playerVc = [[AVPlayerViewController alloc] init];
            
            playerVc.delegate  = self;
            
            playerVc.player = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:_videoPath]];
            
            [self presentViewController:playerVc animated:YES completion:nil];
        };
        _cellHeight = cell.cellHeight;
        
        return cell;
    }
    return NULL;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
        
        if (self.layoutArray.count>0) {
            
            LayoutModel * model = self.layoutArray[0];
            
            return 75+(25*model.fields.count);
        }
        return 75;
    }
    if (indexPath.row ==1) {
        
        if (self.layoutArray.count>0) {
            
            return 270.0f;
        }
        return 75;
        
    }
    if (indexPath.row == 2) {
        
        if (self.layoutArray.count >0) {
            
            return 270.0f;
        }
        
        return 75.0f;
    }

    return 150.0f + _cellHeight;
}
- (BOOL)playerViewControllerShouldAutomaticallyDismissAtPictureInPictureStart:(AVPlayerViewController *)playerViewController
{
    return YES;
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
-(void)pushNextView:(UIViewController *)vc DataModel:(LayoutModel*)model
{
    if ([vc isKindOfClass:[RanchInfoController class]]) {
        
        RanchInfoController * VC = (RanchInfoController *)vc;
        
        VC.typeString = Str(1);
        
        VC.dataDict = _ranchDict;
        
        VC.navigationItem.title = @"牧场信息";
        
        VC.dataArray = model.fields.mutableCopy;
    }
    if ([vc isKindOfClass:[CattleInfoController class]]) {
        
        CattleInfoController * VC = (CattleInfoController *)vc;
        
        VC.dataArray = model.fields.mutableCopy;
        
        VC.dataDict = _ranchDict;
    }
    if ([vc isKindOfClass:[AdjunctController class]]) {
        
        AdjunctController * VC = (AdjunctController *)vc;
        
        VC.idString = nil;
        
        VC.typeString = Str(1);
        
        VC.imagesArray = self.getImages;
        
        VC.videoString = _videoPath;
    }

    [self.navigationController pushViewController:vc animated:YES];
}
-(NSMutableArray *)imgsArray
{
    if (!_imgsArray) {
        
        _imgsArray = [[NSMutableArray alloc] init];
    }
    return _imgsArray;
}
-(NSMutableArray *)calfSampleArray
{
    if (!_calfSampleArray) {
        
        _calfSampleArray = [[NSMutableArray alloc] init];
    }
    return _calfSampleArray;
}
-(NSMutableArray *)layoutArray
{
    if (!_layoutArray) {
        
        _layoutArray = [[NSMutableArray alloc] init];
    }
    return _layoutArray;
}
-(NSMutableArray *)getImages
{
    if (!_getImages) {
        
        _getImages = [[NSMutableArray alloc] init];
    }
    return _getImages;
}

@end
