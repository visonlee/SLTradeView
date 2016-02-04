//
//  ViewController.m
//  支付密码界面设置
//
//  Created by 李文深 on 16/2/2.
//  Copyright © 2016年 李文深. All rights reserved.
//

/**
 UIKeyboardAnimationCurveUserInfoKey = 7;
 UIKeyboardAnimationDurationUserInfoKey = "0.25";
 UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {414, 226}}";
 UIKeyboardCenterBeginUserInfoKey = "NSPoint: {207, 849}";
 UIKeyboardCenterEndUserInfoKey = "NSPoint: {207, 623}";
 UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 736}, {414, 226}}";
 UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 510}, {414, 226}}";
 UIKeyboardIsLocalUserInfoKey = 1;
 */

#import "ViewController.h"
#import "SLTradeView.h"


@interface ViewController ()<SLTradeViewDelegate>



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 注册取消按钮点击的通知 */
//    [CYNotificationCenter addObserver:self selector:@selector(cancel) name:CYPasswordViewCancleButtonClickNotification object:nil];
//    [CYNotificationCenter addObserver:self selector:@selector(forgetPWD) name:CYPasswordViewForgetPWDButtonClickNotification object:nil];
}

- (IBAction)shanglianPay:(id)sender {
    
//    SLTradeView *tradeView = [[SLTradeView alloc] initWithTradeName:@"猴子" money:@"666" competition:^(NSString *password) {
//        NSLog(@"在控制器回调,密码为:%@",password);
//    }];
    
    SLTradeView *tradeView = [[SLTradeView alloc] initWithTradeName:@"买买买😄" money:@"666"];
    tradeView.delegate = self;
    [tradeView show];
}

- (void)tradeView:(SLTradeView *)tradeView didFinishInputPassword:(NSString *)password {
    NSLog(@"在控制器回调,密码为:%@",password);
}

- (void)tradeViewResetPasswordButtonClick:(SLTradeView *)tradeView {
    NSLog(@"在控制器回调,重置密码按钮被点击");
}

- (void)tradeViewForgetPasswordButtonClick:(SLTradeView *)tradeView {
    NSLog(@"在控制器回调,忘记密码按钮被点击");
}




@end
