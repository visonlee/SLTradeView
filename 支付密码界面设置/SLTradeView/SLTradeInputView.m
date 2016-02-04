//
//  SLInputView.m
//  支付密码界面设置
//
//  Created by 李文深 on 16/2/2.
//  Copyright © 2016年 李文深. All rights reserved.
//

#import "SLTradeInputView.h"
#import "UIView+Extension.h"
#import "SLConst.h"

const NSInteger kPasswordLenth = 6;

@interface SLTradeInputView()
/** 密码数字数组 */
@property (nonatomic, strong) NSMutableArray *nums;
/** 关闭按钮 */
@property (nonatomic, weak)  UIButton* closeBtn;
/** 重置密码按钮 */
@property (nonatomic, weak)  UIButton* resetPwdBtn;
/** 忘记密码按钮 */
@property (nonatomic, weak)  UIButton* forgetPwdBtn;

@end

@implementation SLTradeInputView

#pragma mark - 懒加载
- (NSMutableArray *)nums
{
    if (_nums == nil) {
        _nums = [NSMutableArray array];
    }
    return _nums;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        /** 注册keyboard通知 */
        [self setupKeyboardNote];
        /** 添加子控件 */
        [self setupSubViews];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    // 画背景图
    UIImage *bg = [UIImage imageNamed:@"SLTradeView.bundle/pssword_bg"];
    
    [bg drawInRect:rect];
    
    //画标题
    NSString *title = @"输入交易密码";
    NSMutableDictionary *titleAttrs = [NSMutableDictionary dictionary];
    titleAttrs[NSFontAttributeName] = kDefaultTitleFont;
    
    CGSize titleSize =  [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:titleAttrs context:nil].size;
    
    CGFloat titleW = titleSize.width;
    CGFloat titleH = titleSize.height;
    CGFloat titleX = (self.width - titleW) * 0.5;
    CGFloat titleY = SLScreenHeight * 0.03125;
    CGRect titleRect = CGRectMake(titleX, titleY, titleW, titleH);
    titleAttrs[NSForegroundColorAttributeName] = kDefaultTitleColor;
    [title drawInRect:titleRect withAttributes:titleAttrs];
    
    //画交易名称
    NSString *tradeName = self.tradeName ? self.tradeName : @"";
    NSMutableDictionary *tradeNameAttrs = [NSMutableDictionary dictionary];
    tradeNameAttrs[NSFontAttributeName] = kDefaultTradeNameFont;
    CGSize tradeNameSize =  [tradeName boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:tradeNameAttrs context:nil].size;
    CGFloat tradeNameW = tradeNameSize.width;
    CGFloat tradeNameH = tradeNameSize.height;
    CGFloat tradeNameX = (self.width - tradeNameW) * 0.5;
    CGFloat tradeNameY = SLScreenWidth * 0.17333;//SLScreenWidth * 0.40625 * 0.5;
    CGRect tradeNameRect = CGRectMake(tradeNameX, tradeNameY, tradeNameW, tradeNameH);
    tradeNameAttrs[NSForegroundColorAttributeName] = kDefaultTradeNameColor;
    [tradeName drawInRect:tradeNameRect withAttributes:tradeNameAttrs];
    
    //画交易金额
    NSString *tradeMoney = self.tradeMoney ? self.tradeMoney : @"";
    NSMutableDictionary *tradeMoneyAttrs = [NSMutableDictionary dictionary];
    tradeMoneyAttrs[NSFontAttributeName] = kDefaultTradeMoneyFont;
    CGSize tradeMoneySize =  [tradeMoney boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:tradeMoneyAttrs context:nil].size;
    CGFloat tradeMoneyW = tradeMoneySize.width;
    CGFloat tradeMoneyH = tradeMoneySize.height;
    CGFloat tradeMoneyX = (self.width - tradeMoneyW) * 0.5;
    CGFloat tradeMoneyY = CGRectGetMaxY(tradeNameRect) + SLScreenWidth *0.03518;
    CGRect tradeMoneyRect = CGRectMake(tradeMoneyX, tradeMoneyY, tradeMoneyW, tradeMoneyH);
    
    tradeMoneyAttrs[NSForegroundColorAttributeName] = kDefaultTradeMoneyColor;
    [tradeMoney drawInRect:tradeMoneyRect withAttributes:tradeMoneyAttrs];
    
    //画密码输入框
    UIImage *field = [UIImage imageNamed:@"SLTradeView.bundle/password_in"];
    CGFloat fieldW =  SLScreenWidth * 0.846875;
    CGFloat fieldH =  SLScreenWidth * 0.121875;
    CGFloat fieldX = (rect.size.width - fieldW) * 0.5;
    CGFloat fieldY =  CGRectGetMaxY(tradeMoneyRect) + SLScreenWidth *0.0703;;
    CGRect fieldRect = CGRectMake(fieldX, fieldY, fieldW, fieldH);
    [field drawInRect:fieldRect];
    
    //画点
    UIImage *pointImage = [UIImage imageNamed:@"SLTradeView.bundle/yuan"];
    CGFloat pointW = SLScreenWidth * 0.05;
    CGFloat pointH = pointW;
    CGFloat pointY = CGRectGetMidY(fieldRect) - pointH*0.5;
    CGFloat pointX;
    CGFloat margin = SLScreenWidth * 0.0484375;
    CGFloat padding = SLScreenWidth * 0.045578125;
    for (int i = 0; i < self.nums.count; i++) {
        pointX = margin + padding + i * (pointW + 2 * padding);
        [pointImage drawInRect:CGRectMake(pointX, pointY, pointW, pointH)];
    }
}

- (void)setupSubViews {
    /** 关闭按钮 */
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:closeBtn];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"SLTradeView.bundle/password_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.closeBtn = closeBtn;
  
    /** 重置密码按钮 */
    UIButton *resetPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    resetPwdBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [resetPwdBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [resetPwdBtn setTitle:@"重置密码" forState:UIControlStateNormal];
    [resetPwdBtn addTarget:self action:@selector(resetPwdBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:resetPwdBtn];
    self.resetPwdBtn = resetPwdBtn;
    
    /** 忘记密码按钮 */
    UIButton *forgetPWdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPWdBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [forgetPWdBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [forgetPWdBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPWdBtn addTarget:self action:@selector(forgetPwdBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:forgetPWdBtn];
    self.forgetPwdBtn = forgetPWdBtn;
}

- (void)resetPwdBtnClick {
    [[NSNotificationCenter defaultCenter] postNotificationName:SLTradeViewResetPasswordButtonClickKey object:nil];
}

- (void)forgetPwdBtnClick {
    [[NSNotificationCenter defaultCenter] postNotificationName:SLTradeViewForgetPasswordButtonClickKey object:nil];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    /** 关闭按钮 */
    CGFloat closeX = 5;
    CGFloat closeY = 5;
    CGFloat closeW = kDefaultCloseButtonWH;
    CGFloat closeH = kDefaultCloseButtonWH;
    self.closeBtn.frame = CGRectMake(closeX, closeY, closeW, closeH);
    
    /** 重置密码按钮 */
    CGFloat resetW = 100;
    CGFloat resetH = 30;
    CGFloat resetX = 20;
    CGFloat resetY = self.height - resetH - 5;
    self.resetPwdBtn.frame = CGRectMake(resetX, resetY, resetW, resetH);
    
    /** 忘记密码按钮 */
    CGFloat forgetW = 100;
    CGFloat forgetH = 30;
    CGFloat forgetX = self.width - forgetW - 20;
    CGFloat forgetY = self.height - forgetH - 5;
    self.forgetPwdBtn.frame = CGRectMake(forgetX, forgetY, forgetW, forgetH);
}

#pragma mark  按钮点击监听
/** 关闭按钮点击 */
- (void)closeBtnClicked:(UIButton *)closeBtn {
    
    [closeBtn.superview.superview removeFromSuperview];
}

/** 数字按钮点击 */
- (void)numberBtnKeyDown:(NSNotification *)notification {
    
    if (self.nums.count >= kPasswordLenth) {
        return;
    }
    
    [self.nums addObject:notification.object];
    [self setNeedsDisplay];
    
    if (self.nums.count == kPasswordLenth) {
        
        NSString *password = [self.nums componentsJoinedByString:@""];
        [[NSNotificationCenter defaultCenter] postNotificationName:SLTradeKeyboardFinishInputKey object:password];
    }
}

/** 删除按钮点击 */
- (void)deleteBtnKeyDown:(NSNotification *)notification {
    
    if (self.nums.count <= 0) {
        return;
    }
    
    [self.nums removeLastObject];
    [self setNeedsDisplay];
}

/** 注册keyboard通知 */
- (void)setupKeyboardNote
{
    // 数字通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(numberBtnKeyDown:) name:SLTradeKeyboardNumberButtonClickKey object:nil];
    // 删除通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteBtnKeyDown:) name:SLTradeKeyboardDeleteButtonClickKey object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
