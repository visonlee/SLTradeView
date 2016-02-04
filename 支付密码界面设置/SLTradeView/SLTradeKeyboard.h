//
//  SLTradeKeyboard.h
//  支付密码界面设置
//
//  Created by 李文深 on 16/2/4.
//  Copyright © 2016年 李文深. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLTradeKeyboard;
@protocol SLTradeKeyboardDelegate <NSObject>

@optional
/** 数字按钮点击 */
- (void)tradeKeyboard:(SLTradeKeyboard *)keyboard numBtnClick:(NSInteger)num;
/** 删除按钮点击 */
- (void)tradeKeyboardDeleteBtnClick;
@end

@interface SLTradeKeyboard : UIView
// 代理
@property (nonatomic, weak) id<SLTradeKeyboardDelegate> delegate;

@end
