//
//  FeedController.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/20.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "FeedController.h"
#import "LayoutModel.h"
#import "RanchInfoCell.h"
#import "RanchInfoController.h"
#import "OtherAdjunctCell.h"
#import "FoodListController.h"
#import "ImageModel.h"
#import "AdjunctController.h"
@interface FeedController ()<AVPlayerViewControllerDelegate,UIGestureRecognizerDelegate>
{
    UIImage * _defaultImg;
    NSString * _videoPath;
    CGFloat _cellHeight;
    NSDictionary * _calfDict;
}

@property(nonatomic,strong)NSMutableArray * getImages;
@end

@implementation FeedController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView.mj_header beginRefreshing];
    
    if (self._isPush) {
        
        RootNaviController * rootNav = (RootNaviController *) self.navigationController;
        
        rootNav.PopToViewController = ^BOOL{
            
            for (UIViewController *vc in self.navigationController.viewControllers) {
                
                if ([vc isKindOfClass:[FoodListController class]]) {
                    
                    [self.navigationController popToViewController:vc animated:YES];
                    
                    return YES;
                }
            }
            return NO;
        };
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"犊牛饲养管理";
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = BGCOLOR;
    
    if (self._isPush) {
        
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getVideoData];
    }];
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    for (UIViewController *vc in self.navigationController.viewControllers) {
        
        if ([vc isKindOfClass:[FoodListController class]]) {
            
            [self.navigationController popToViewController:vc animated:YES];
            
            return NO;
        }
    }
    return YES;
}
-(void)requestData
{
    [[RequestTool sharedRequestTool] requestWithCalfManagerForId:self.idString Type:3 FinishedBlock:^(id result, NSError *error) {
        
        if ([result[@"status_code"] integerValue] == 200) {
            
            _calfDict = result[@"data"];
            
            [LCProgressHUD hide];
            
            [self.tableView reloadData];
            
        }else{
            [LCProgressHUD showMessage:result[@"message"]];
        }
        [self.tableView.mj_header endRefreshing];
    }];
}
//获取图片
-(void)getImageListData
{
    [[RequestTool sharedRequestTool] requestWithImageListType:3 ModelId:self.idString FinishedBlock:^(id result, NSError *error) {
        
        if ([result[@"status_code"] integerValue] == 200) {
            
            [self.getImages removeAllObjects];
            
            for (NSDictionary * dic in result[@"data"]) {
                
                ImageModel * model = [[ImageModel alloc] initWithDictionary:dic error:nil];
                
                [self.getImages addObject:model.url];
            }
            [self requestData];
        }else{
            
            [LCProgressHUD showMessage:result[@"message"]];
        }
    }];
}
-(void)getVideoData
{
    [[RequestTool sharedRequestTool] requestWithVideosListType:3 ModelId:self.idString FinishedBlock:^(id result, NSError *error) {
        
        if ([result[@"status_code"] integerValue] == 200) {
            
            NSArray * array = result[@"data"];
            
            if (array.count == 0) {
                
                [self getImageListData];
            }else{
                
                _videoPath =result[@"data"][0][@"url"];
                
                _defaultImg = [self getThumbnailImage:_videoPath];
                
                if (_defaultImg != nil) {
                    
                    [self getImageListData];
                }
            }
        }else{
            
            [LCProgressHUD showMessage:result[@"message"]];
        }
    }];
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
    
    CGImageRelease(image);
    
    return shotImage;
}
-(void)setLayoutArray:(NSMutableArray *)layoutArray
{
    _layoutArray = layoutArray;
}
-(NSMutableArray *)getImages
{
    if (!_getImages) {
        
        _getImages = [[NSMutableArray alloc] init];
    }
    return _getImages;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _calfDict==nil?0:self.layoutArray.count-1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeakifySelf();
    
    LayoutInfoModel * model = self.layoutArray[indexPath.row];
    
    if (![model.name isEqualToString:@"image"]&&![model.name isEqualToString:@"video"]) {
        
        RanchInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithString:NSStringFromClass([RanchInfoCell class])]];
        
        if (!cell) {
            
            cell = [[RanchInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithString:NSStringFromClass([RanchInfoCell class])]];
        }
        cell.headerLabel.text = model.title;
        
        if (self.layoutArray.count > 0) {
            
            cell.dataDict = _calfDict;
            
            cell.infoModel = self.layoutArray[indexPath.row];
        }
        cell.SelectRanchInfoBlock = ^{
            
            if (self.layoutArray.count>0) {
                
                [weakSelf pushNextView:[[RanchInfoController alloc] init] DataModel:self.layoutArray[indexPath.row]];
            }
        };
        
        return cell;
    }
    OtherAdjunctCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithString:NSStringFromClass([OtherAdjunctCell class])]];
    
    if (!cell) {
        cell = [[OtherAdjunctCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:[NSString stringWithString:NSStringFromClass([OtherAdjunctCell class])]];
    }
    cell.TouchVideoBlock = ^{
        
        AVPlayerViewController *playerVc = [[AVPlayerViewController alloc] init];
        
        playerVc.delegate  = self;
        
        playerVc.player = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:_videoPath]];
        
        [self presentViewController:playerVc animated:YES completion:nil];
    };
    cell.TouchAddBlock = ^{
        
        if (self.layoutArray.count>0) {
            
            [weakSelf pushNextView:[[AdjunctController alloc] init] DataModel:self.layoutArray[indexPath.row]];
        }
    };
    cell.defultImg = _defaultImg;
    cell.imgs = self.getImages;
    cell.imgTitle.text = @"牛舍内部照片";
    cell.videoTitle.text = @"牛舍外部视频";
    _cellHeight = cell.cellHeight;
    
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LayoutInfoModel * model = self.layoutArray[indexPath.row];
    
    if ([model.name isEqualToString:@"image"] | [model.name isEqualToString:@"video"]) {
        
        return 150.f+_cellHeight;
    }
    
    if (self.layoutArray.count>0) {
        
        LayoutModel * model = self.layoutArray[indexPath.row];
        
        return 75+(25*model.fields.count);
    }
    return 75;
}
#pragma mark =======私有
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(void)pushNextView:(UIViewController *)vc DataModel:(LayoutModel*)model
{
    if ([vc isKindOfClass:[RanchInfoController class]]) {
        
        RanchInfoController * VC = (RanchInfoController *)vc;
        
        VC.navigationItem.title = model.title;
        
        VC.typeString = Str(3);
        
        VC.idString = self.idString;
        
        VC.dataDict = _calfDict;
        
        VC.dataArray = model.fields.mutableCopy;
    }
    
    if ([vc isKindOfClass:[AdjunctController class]]) {
        
        AdjunctController * VC = (AdjunctController *)vc;
        
        VC.typeString = Str(3);
        
        VC.idString = self.idString;
        
        VC.imagesArray = self.getImages;
        
        VC.videoString = _videoPath;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}
@end
