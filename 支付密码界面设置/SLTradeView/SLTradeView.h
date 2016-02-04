//
//  SLTradeView.h
//  支付密码界面设置
//
//  Created by 李文深 on 16/2/2.
//  Copyright © 2016年 李文深. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SLTradeView;
@protocol SLTradeViewDelegate <NSObject>

@optional
- (void)tradeView:(SLTradeView *)tradeView didFinishInputPassword:(NSString *)password;
- (void)tradeViewResetPasswordButtonClick:(SLTradeView *)tradeView;
- (void)tradeViewForgetPasswordButtonClick:(SLTradeView *)tradeView;

@end

@interface SLTradeView : UIView

/** 交易名称 */
@property (nonatomic, copy)  NSString* tradeName;
/** 交易金额 */
@property (nonatomic, copy)  NSString* tradeMoney;

// 代理
@property (nonatomic, weak) id<SLTradeViewDelegate> delegate;

/** 初始化方法 */
+ (instancetype)tradeViewWithTradeName:(NSString *)name money:(NSString *)money competition:(void (^)(NSString *password))competition;
- (instancetype)initWithTradeName:(NSString *)name money:(NSString *)money;

/** 弹出 */
- (void)show;
- (void)showInView:(UIView *)view;


@end
