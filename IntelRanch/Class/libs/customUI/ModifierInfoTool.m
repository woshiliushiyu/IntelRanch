//
//  ModifierInfoTool.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/20.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "ModifierInfoTool.h"
#import "LayoutInfoModel.h"
#import "FeedInfoModel.h"
#import "CalfManagerModel.h"
#import "DiseaseInfoModel.h"
@implementation ModifierInfoTool
singleton_implementation(ModifierInfoTool);

-(void)requestModifierRanchInfoData:(NSMutableArray *)dataArray LayoutArray:(NSMutableArray *)layoutArray Type:(NSInteger)type isCreate:(NSString *)isCreate ModifierFinishedBlock:(ModifierFinishedBlock)modifierFinishedBlock CreateFinishedBlock:(CreateFinishedBlock)createFinishedBlock
{
    NSMutableDictionary * dataDict = [[NSMutableDictionary alloc] init];
    
    for (NSInteger i=0; i<layoutArray.count;i++) {
        
        LayoutInfoModel * model = layoutArray[i];
        
        NSDictionary * dic;
        
        id entity = dataArray[i];
        
        if ([entity isKindOfClass:[NSArray class]]) {
            
            NSMutableString * temString = [[NSMutableString alloc] init];
            
            NSArray * array = entity;
            
            int j=1;
            
            for (NSString * res in array) {
                
                if (array.count == j) {
                    
                    [temString appendFormat:@"%@",res];
                }else{
                    
                    [temString appendFormat:@"%@,",res];
                }
                j++;
            }
            
            dic = @{model.name:temString};
            
        }else{
            
            dic  = @{model.name:dataArray[i]};
        }
        
        [dataDict addEntriesFromDictionary:dic];
    }
    
    if (isCreate==nil && type !=1) {
        
        NSArray * portArray = @[@"pastures/create",@"newborn/logs/create",@"feeding/logs/create",@"sickness/logs/create"];
        
        NSString * URLString = [NSString stringWithFormat:@"%@?token=%@",portArray[type -1],[LoginInfoModel getLoginInfoModel].token];
        
        MyRanchInfoModel * model = [[MyRanchInfoModel alloc] initWithDictionary:[LocalDataTool getDataToDataName:[NSString stringWithString:NSStringFromClass([MyRanchInfoModel class])]] error:nil];
        
        [dataDict addEntriesFromDictionary:@{@"pasture_id":model.id}];
        
        [[HttpToolManager sharedManager] requestWithMethod:kPOST URLString:URLString parameters:dataDict Upload:YES option:BcRequestCenterCachePolicyCacheAndLocal finished:^(id result, NSError *error) {
            
            if ([result[@"status_code"] integerValue] == 200) {
                
                if (type == 3) {
                    
                    FeedInfoModel * model = [[FeedInfoModel alloc] initWithDictionary:result[@"data"] error:nil];
                    
                    createFinishedBlock(model.id);
                }
                if (type == 2) {
                    
                    CalfManagerModel * model = [[CalfManagerModel alloc] initWithDictionary:result[@"data"] error:nil];
                    
                    createFinishedBlock(model.id);
                }
                if (type == 4) {
                    
                    DiseaseInfoModel * model = [[DiseaseInfoModel alloc] initWithDictionary:result[@"data"] error:nil];
                    
                    createFinishedBlock(model.id);
                }
                return;
                
            }else{
                
                [LCProgressHUD showMessage:result[@"message"]];
            }
        }];
    }else{
        
        NSArray * portArray = @[@"pastures/modify",@"newborn/logs/modify",@"feeding/logs/modify",@"sickness/logs/modify"];
        
        MyRanchInfoModel * model = [[MyRanchInfoModel alloc] initWithDictionary:[LocalDataTool getDataToDataName:[NSString stringWithString:NSStringFromClass([MyRanchInfoModel class])]] error:nil];
        
        if (type != 1) {
            
            [dataDict addEntriesFromDictionary:@{@"pasture_id":model.id}];
        }
        
        [[RequestTool sharedRequestTool] requestWithRanchInfoToServerPort:portArray[type-1] InfoId:type==1?model.id:isCreate Body:dataDict FinishedBlock:^(id result, NSError *error) {
            
            
            NSLog(@"获取的数据====>%@",result);
            
            if ([result[@"status_code"] integerValue] == 200) {
                
                [LCProgressHUD showMessage:@"修改完成"];
                
                modifierFinishedBlock();
                
                return;
            }
            [LCProgressHUD showFailure:result[@"message"]];
        }];
    }
}
@end
