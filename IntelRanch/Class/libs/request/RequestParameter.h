//
//  RequestParameter.h
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/11.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestParameter : NSObject

//注册请求参数
extern NSString *const mRegister;

//请求验证码
extern NSString *const mCaptcha;

//修改密码
extern NSString *const mReset;

//登录
extern NSString *const mLogin;

//我的牧场
extern NSString *const Owns;

//牧场基本信息界面布局
extern NSString *const  Layout;

//牧场基本信息界面数据
extern NSString *const calfInfo;

//创建牧场
extern NSString *const createRanch;

//修改牧场信息
extern NSString *const modfiyInfo;
@end
