//
//  Macros.h
//  FSDesignatedDrive
//
//  Created by 刘世玉 on 16/12/7.
//  Copyright © 2016年 liushiyu. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

//color相关
#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBColorAlpha(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

// 是否大于等于IOS8
#define isIOS8                  ([[[UIDevice currentDevice]systemVersion]floatValue] >= 8.0)
// 是否IOS8以下
#define isIOS7                  ([[[UIDevice currentDevice]systemVersion]floatValue] < 8.0)
// 是否大于IOS9
#define isIOS9                  ([[[UIDevice currentDevice]systemVersion]floatValue] >=9.0)
// 是否大于IOS10
#define isIOS10                  ([[[UIDevice currentDevice]systemVersion]floatValue] >=10.0)

//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))
// 是否空对象
#define IS_NULL_CLASS(OBJECT) ![OBJECT isKindOfClass:[NSNull class]]

//获取图片资源
#define GetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

//Library/Caches 文件路径
#define FilePath ([[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil])
//获取temp
#define kPathTemp NSTemporaryDirectory()
//获取沙盒 Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

//AppDelegate对象
#define AppDelegateInstance [[UIApplication sharedApplication] delegate]


#define GRAY RGBColor(203, 203, 203)


//打印
#ifdef DEBUG

#define YGLog(...) NSLog(__VA_ARGS__)
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define YGLog(...)
#define NSLog(...)

#endif

#endif /* Macros_h */
