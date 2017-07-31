//
//  ModifierInfoTool.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/20.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <Foundation/Foundation.h>

// .h
#define singleton_interface(class) + (instancetype)shared##class;

// .m
#define singleton_implementation(class) \
static class *_instance; \
\
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
\
return _instance; \
} \
\
+ (instancetype)shared##class \
{ \
if (_instance == nil) { \
_instance = [[class alloc] init]; \
} \
\
return _instance; \
}

typedef void(^ModifierFinishedBlock)();
typedef void(^CreateFinishedBlock)(NSString * idString);

@interface ModifierInfoTool : NSObject
singleton_interface(ModifierInfoTool);

/**
 修改接口

 @param dataArray 数据
 @param type 类型(1:牧场基本信息, 2:新生犊牛管理, 3:犊牛饲喂管理, 4:犊牛疾病管理)
 @param modifierFinishedBlock 回调
 */
-(void)requestModifierRanchInfoData:(NSMutableArray*)dataArray LayoutArray:(NSMutableArray*)layoutArray Type:(NSInteger)type isCreate:(NSString *)isCreate ModifierFinishedBlock:(ModifierFinishedBlock)modifierFinishedBlock CreateFinishedBlock:(CreateFinishedBlock)createFinishedBlock;
@end
