//
//  SLTradeView.m
//  支付密码界面设置
//
//  Created by 李文深 on 16/2/2.
//  Copyright © 2016年 李文深. All rights reserved.
//


#import "SLTradeView.h"
#import "SLTradeInputView.h"
#import "UIView+Extension.h"
#import "SLConst.h"
#import "SLTradeKeyboard.h"


#define iphone5  ([UIScreen mainScreen].bounds.size.height == 568)
#define iphone6  ([UIScreen mainScreen].bounds.size.height == 667)
#define iphone6Plus  ([UIScreen mainScreen].bounds.size.height == 736)
#define iphone4  ([UIScreen mainScreen].bounds.size.height == 480)
#define ipadMini2  ([UIScreen mainScreen].bounds.size.height == 1024)

@interface SLTradeView() {
    /** 蒙版 */
    UIView *_cover;
}
/** 输入框 */
@property (nonatomic, weak) SLTradeInputView *inputView;
/** 键盘 */
@property (nonatomic, weak) SLTradeKeyboard *keyboard;

@end

@implementation SLTradeView

#pragma mark - 初始化方法
/** 快速创建 */
+ (instancetype)tradeViewWithTradeName:(NSString *)name money:(NSString *)money competition:(void (^)(NSString *))competition
{
    return [[self alloc] initWithTradeName:name money:money /*competition:competition*/];
}

- (instancetype)initWithTradeName:(NSString *)name money:(NSString *)money /*competition:(void (^)(NSString *))competition */{
    
    self = [self initWithFrame:CGRectZero];
    
    if (self) {
        self.tradeName = name;
        self.tradeMoney = money;
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        
        /** 添加通知*/
        [self setupNote];
        /** 蒙板 */
        [self setupCover];
        /** 键盘 */
        [self setupkeyboard];
        /** 输入框 */
        [self setupInputView];
    }
    return self;
}

/** 添加通知*/
- (void)setupNote {
    //完成输入密码
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(passwordFinishNote:) name:SLTradeKeyboardFinishInputKey object:nil];
    //重置密码按钮点击
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetPwdBtnClickNote) name:SLTradeViewResetPasswordButtonClickKey object:nil];
    //忘记密码按钮点击
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(forgetPwdBtnClickNote) name:SLTradeViewForgetPasswordButtonClickKey object:nil];
}

/** 蒙板 */
- (void)setupCover
{
    UIView *cover = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self addSubview:cover];
   
    [cover setBackgroundColor:[UIColor blackColor]];
    cover.alpha = 0.4;
    _cover = cover;
   
}

/** 键盘 */
- (void)setupkeyboard
{
    SLTradeKeyboard *keyboard = [[SLTradeKeyboard alloc] init];
    [self addSubview:keyboard];
    
    self.keyboard = keyboard;
}

/** 输入框*/
- (void)setupInputView {
    SLTradeInputView *inputView = [[SLTradeInputView alloc] init];
    
    [self addSubview:inputView];
    
    self.inputView = inputView;
}

- (void)setTradeMoney:(NSString *)tradeMoney {
    _tradeMoney = tradeMoney;
    self.inputView.tradeMoney = tradeMoney;
}

- (void)setTradeName:(NSString *)tradeName {
    _tradeName = tradeName;
    self.inputView.tradeName = tradeName;
}

/** 弹出 */
- (void)show
{
    [self showInView:[UIApplication sharedApplication].windows.lastObject];
}

- (void)showInView:(UIView *)view
{
    // 浮现
    [view addSubview:self];
    
    /** 键盘起始frame */
    self.keyboard.x = 0;
    self.keyboard.y = SLScreenHeight;
    self.keyboard.width = SLScreenWidth;
    self.keyboard.height = SLScreenWidth * 0.65;
    
    /** 输入框起始frame */
    self.inputView.height = SLScreenWidth * 2 / 3;
    self.inputView.y = (self.height - self.inputView.height) * 0.5;
    self.inputView.width = SLScreenWidth * 0.94375;
    self.inputView.x = (SLScreenWidth - self.inputView.width) * 0.5;
    
    [self showKeyboard];
}

/** 键盘弹出 */
- (void)showKeyboard
{
    CGFloat marginTop = 140;
    if (iphone4) {
        marginTop = 42;
    } else if (iphone5) {
        marginTop = 100;
    } else if (iphone6) {
        marginTop = 120;
    }
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.keyboard.transform = CGAffineTransformMakeTranslation(0, -self.keyboard.height);
        self.inputView.transform = CGAffineTransformMakeTranslation(0, marginTop - self.inputView.y);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 通知回调方法
- (void)passwordFinishNote:(NSNotification *)notification {
    
    if ([self.delegate respondsToSelector:@selector(tradeView:didFinishInputPassword:)]) {
        [self.delegate tradeView:self didFinishInputPassword:notification.object];
        
        [self removeFromSuperview];
    }
}

- (void)resetPwdBtnClickNote {
    
    if ([self.delegate respondsToSelector:@selector(tradeViewResetPasswordButtonClick:)]) {
        [self.delegate tradeViewResetPasswordButtonClick:self];
    }
}

- (void)forgetPwdBtnClickNote {
    
    if ([self.delegate respondsToSelector:@selector(tradeViewForgetPasswordButtonClick:)]) {
        [self.delegate tradeViewForgetPasswordButtonClick:self];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
