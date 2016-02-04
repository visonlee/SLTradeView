//
//  SLInputView.h
//  支付密码界面设置
//
//  Created by 李文深 on 16/2/2.
//  Copyright © 2016年 李文深. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLTradeInputView : UIView

/** 交易名称 */
@property (nonatomic, copy)  NSString* tradeName;
/** 交易金额 */
@property (nonatomic, copy)  NSString* tradeMoney;

@end
