//
//  DiseaseController.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/20.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "DiseaseController.h"
#import "AdjunctController.h"
#import "OtherAdjunctCell.h"
#import "RanchInfoCell.h"
#import "GradeViewCell.h"
#import "AssessmentModel.h"
#import "SampleCell.h"
#import "GradeTableCell.h"
#import "ImageModel.h"
#import "AdjunctController.h"
#import "RanchInfoController.h"
#import "GradeController.h"
#import "SicknessModel.h"
#import "ShitController.h"
#import "RanchInfoController.h"
#import "DiseaseListController.h"
@interface DiseaseController ()<AVPlayerViewControllerDelegate,UIGestureRecognizerDelegate>
{
    UIImage * _defaultImg;
    NSString * _videoPath;
    CGFloat _cellHeight;
    NSDictionary * _calfDict;

}
@property(nonatomic,strong)NSMutableArray * descriptArray;
@property(nonatomic,strong)NSMutableArray * getImages;
@end

@implementation DiseaseController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView.mj_header beginRefreshing];
    
    if (self._isPush) {
        
        RootNaviController * rootNav = (RootNaviController *) self.navigationController;
        
        rootNav.PopToViewController = ^BOOL{
            
            for (UIViewController *vc in self.navigationController.viewControllers) {
                
                if ([vc isKindOfClass:[DiseaseListController class]]) {
                    
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
    
    self.tableView.backgroundColor = BGCOLOR;
    self.navigationItem.title = @"犊牛疾病管理";
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (self._isPush) {
        
        self.navigationController.interactivePopGestureRecognizer.delegate  = self;
    }

    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getVideoData];
    }];
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    for (UIViewController *vc in self.navigationController.viewControllers) {
        
        if ([vc isKindOfClass:[DiseaseListController class]]) {
            
            [self.navigationController popToViewController:vc animated:YES];
            
            return NO;
        }
    }
    return YES;
}
-(void)rquestDescriptData
{
    [[RequestTool sharedRequestTool] requestWithIcknessForId:self.idString FinishedBlock:^(id result, NSError *error) {
        
        if ([result[@"status_code"] integerValue] == 200) {
            
            [self.descriptArray removeAllObjects];
            
            for (NSDictionary * entity in result[@"data"]) {
                
                SicknessModel * model = [[SicknessModel alloc] initWithDictionary:entity error:nil];
                
                [self.descriptArray addObject:model];
            }
            
            [self requestData];
            
        }else{
            [LCProgressHUD showMessage:result[@"message"]];
        }
    }];
}
-(void)requestData
{
    [[RequestTool sharedRequestTool] requestWithCalfManagerForId:self.idString Type:4 FinishedBlock:^(id result, NSError *error) {
        
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
    [[RequestTool sharedRequestTool] requestWithImageListType:4 ModelId:self.idString FinishedBlock:^(id result, NSError *error) {
        
        if ([result[@"status_code"] integerValue] == 200) {
            
            [self.getImages removeAllObjects];
            
            for (NSDictionary * dic in result[@"data"]) {
                
                ImageModel * model = [[ImageModel alloc] initWithDictionary:dic error:nil];
                
                [self.getImages addObject:model.url];
            }
            [self rquestDescriptData];
        }else{
            
            [LCProgressHUD showMessage:result[@"message"]];
        }
    }];
}
-(void)getVideoData
{
    [[RequestTool sharedRequestTool] requestWithVideosListType:4 ModelId:self.idString FinishedBlock:^(id result, NSError *error) {
        
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
-(NSMutableArray *)descriptArray
{
    if (!_descriptArray) {
        
        _descriptArray = [[NSMutableArray alloc] init];
    }
    return _descriptArray;
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
    
    LayoutModel * model = self.layoutArray[indexPath.row];
    
    if (indexPath.row == 9) {
        
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
                
                [weakSelf pushNextView:[[AdjunctController alloc] init] DataModel:self.layoutArray.lastObject];
            }
        };
        cell.defultImg = _defaultImg;
        cell.imgs = self.getImages;
        cell.imgTitle.text = @"牛舍内部照片";
        cell.videoTitle.text = @"牛舍外部视频";
        _cellHeight = cell.cellHeight;
        
        return cell;
    }
    
    if (indexPath.row == 4) {
        
        GradeTableCell * cell = [GradeTableCell setTableViewCustomCell:tableView IndexPath:indexPath];
        cell.nameLabel.text = model.title;
        LayoutInfoModel * infoModel = model.fields[0];
        cell.descriptString = _calfDict[infoModel.name];
        cell.model = model.fields[0];
        cell.SelectRowBlock = ^{
            
            RanchInfoController * ranchInfoView = [[RanchInfoController alloc] init];
            ranchInfoView.idString = self.idString;
            ranchInfoView.typeString = Str(4);
            ranchInfoView.dataDict = _calfDict;
            ranchInfoView.navigationItem.title = model.title;
            ranchInfoView.dataArray = model.fields.mutableCopy;
            [weakSelf.navigationController pushViewController:ranchInfoView animated:YES];
        };
        return cell;
    }
    
    if (indexPath.row == 1 | indexPath.row == 0) {
        LayoutInfoModel * model = self.layoutArray[indexPath.row];
        
        RanchInfoCell *cell = (RanchInfoCell *)[tableView cellForRowAtIndexPath:indexPath];
        
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
    NSArray * imgs = @[@[],@[],@[@"bja_s",@"bjb_s",@"bjc_s",@"bjd_s"],@[],@[@"bjaa_s",@"bjbb_s",@"bjcc_s",@"bjdd_s"],@[@"bjaaa_s",@"bjbbb_s",@"bjccc_s",@"bjddd_s"]];
    NSArray * lables = @[@[],@[],@[@"0分,正常水样分泌物",@"1分,单侧鼻孔少量白色分泌物",@"2分,双侧鼻孔少量白色分泌物",@"3分,双侧鼻孔大量白色分泌物"],@[],@[@"0分,耳朵状况正常",@"1分,不断晃动耳朵",@"2分,单侧耳朵耷拉",@"3分,头歪斜或双侧耳朵耷拉"],@[@"0分,明亮无任何分泌物",@"1分,眼少量分泌物",@"2分,眼多量分泌物",@"3分,双眼大量分泌物"]];
    NSArray * subTitles = @[@[@[@"温度范围",@"37.8~38.3",@"38.3~38.9",@"38.8~39.4",@">39.4"]],@[],@[],@[@[@"症状",@"无咳嗽",@"触捏喉头单",@"触捏喉头反",@"无需触捏喉头"]],@[],@[]];
    
    GradeViewCell * cell = [GradeViewCell setTableViewCustomCell:tableView IndexPath:indexPath];
    cell.nameLabel.text = model.title;
    cell.type = Str(indexPath.row);
    cell.descriptArray = self.descriptArray;
    cell.SelectRowBlock = ^(NSInteger num) {
        
        if (num == 1) {
            
            ShitController * shitView = [[ShitController alloc] init];
            shitView.idString = self.idString;
            shitView.descriptArray = self.descriptArray;
            shitView.navigationItem.title = model.title;
            [self.navigationController pushViewController:shitView animated:YES];
            return;
        }
        
        GradeController * gradeView = [[GradeController alloc]init];
        gradeView.idString = self.idString;
        gradeView.typeString = Str(num+1);
        gradeView.images = imgs[num];
        gradeView.labels = lables[num];
        gradeView.descriptArray = self.descriptArray;
        gradeView.titles = @[@"评分",@"0分",@"1分",@"2分",@"3分"];
        gradeView.subTitles = subTitles[num];
        gradeView.navigationItem.title = model.title;
        [self.navigationController pushViewController:gradeView animated:YES];
        
    };
    return cell;
 }
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 9) {
        
        return 150.0f + _cellHeight;
    }
    
    if (indexPath.row == 4) {
        
        return 345;
    }
    
    if (indexPath.row == 0 | indexPath.row ==1) {
        
        LayoutModel * model = self.layoutArray[indexPath.row];
        
        return 75+(25*model.fields.count);
    }
    
    if (indexPath.row == 8) {
        
        __block  NSInteger n = 0;
        
        [self.descriptArray enumerateObjectsUsingBlock:^(SicknessModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([model.type integerValue] == 6) {
                
                n++;
            }
        }];
        
        return 500+30*n;
    }
    if (indexPath.row == 7) {
        
        __block  NSInteger n = 0;
        
        [self.descriptArray enumerateObjectsUsingBlock:^(SicknessModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([model.type integerValue] == 5) {
                
                n++;
            }
        }];
        
        return 500+30*n;
    }
    if (indexPath.row == 5) {
        
        __block  NSInteger n = 0;
        
        [self.descriptArray enumerateObjectsUsingBlock:^(SicknessModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([model.type integerValue] == 3) {
                
                n++;

            }
        }];
        
        return 500+30*n;
    }
    if (indexPath.row == 2) {
        
       __block  NSInteger n = 0;
        
        [self.descriptArray enumerateObjectsUsingBlock:^(SicknessModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        
            if ([model.type integerValue] == 1) {
                
                n++;
            }
        }];
        
        return n*30.0f+150.f;
    }
    if (indexPath.row == 6) {
        
        __block  NSInteger n = 0;
        
        [self.descriptArray enumerateObjectsUsingBlock:^(SicknessModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([model.type integerValue] == 4) {
                
                n++;
            }
        }];
        
        return n*30.0f+150.f;
    }
    if (indexPath.row == 3) {
        
        __block  NSInteger n = 0;
        
        [self.descriptArray enumerateObjectsUsingBlock:^(SicknessModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([model.type integerValue] == 2) {
                
                n++;
            }
        }];
        
        return n*30.0f+120.f;
    }
    
    return 180;
}
#pragma mark =======私有

-(void)pushNextView:(UIViewController *)vc DataModel:(LayoutModel*)model
{
    if ([vc isKindOfClass:[RanchInfoController class]]) {
        
        RanchInfoController * VC = (RanchInfoController *)vc;
        
        VC.navigationItem.title = model.title;
        
        VC.typeString = Str(4);
        
        VC.idString = self.idString;
        
        VC.dataDict = _calfDict;
        
        VC.dataArray = model.fields.mutableCopy;
    }
    
    if ([vc isKindOfClass:[AdjunctController class]]) {
        
        AdjunctController * VC = (AdjunctController *)vc;
        
        VC.typeString = Str(4);
        
        VC.idString = self.idString;
        
        VC.imagesArray = self.getImages;
        
        VC.videoString = _videoPath;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
