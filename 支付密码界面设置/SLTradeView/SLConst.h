//
//  SLConst.h
//  支付密码界面设置
//
//  Created by 李文深 on 16/2/2.
//  Copyright © 2016年 李文深. All rights reserved.
//

#import <UIKit/UIKit.h>

// RGB颜色
#define SLColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define SLColor_A(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

/** 屏幕的宽高 */
#define SLScreenWidth [UIScreen mainScreen].bounds.size.width
#define SLScreenHeight [UIScreen mainScreen].bounds.size.height

//默认标题配置
#define kDefaultTitleColor SLColor(106,106,106)
#define kDefaultTitleFont [UIFont systemFontOfSize:(SLScreenWidth)*0.03703]

//默认交易名称配置
#define kDefaultTradeNameColor SLColor(44,44,44)
#define kDefaultTradeNameFont [UIFont systemFontOfSize:(SLScreenWidth)*0.04444]

//默认交易金额配置
#define kDefaultTradeMoneyColor SLColor(207,59,59)
#define kDefaultTradeMoneyFont [UIFont systemFontOfSize:(SLScreenWidth)*0.06481]

//默认关闭按钮的宽高
#define kDefaultCloseButtonWH (SLScreenWidth)*0.1333

//通知的Key

//数字键盘按钮点击的Key
extern NSString *const SLTradeKeyboardNumberButtonClickKey;
//删除键盘按钮点击的Key
extern NSString *const SLTradeKeyboardDeleteButtonClickKey;
//密码完成输入的Key
extern NSString *const SLTradeKeyboardFinishInputKey;
//密码重置按钮点击的Key
extern NSString *const SLTradeViewResetPasswordButtonClickKey;
//忘记密码按钮点击的Key
extern NSString *const SLTradeViewForgetPasswordButtonClickKey;