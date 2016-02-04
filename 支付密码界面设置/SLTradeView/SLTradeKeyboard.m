//
//  SLTradeKeyboard.m
//  支付密码界面设置
//
//  Created by 李文深 on 16/2/4.
//  Copyright © 2016年 李文深. All rights reserved.
//

#import "SLTradeKeyboard.h"
#import "SLConst.h"

const NSInteger kButtonsCount = 12;

@interface SLTradeKeyboard()
// 所有数字按钮的数组
@property (nonatomic, strong) NSMutableArray *numBtns;

@end

@implementation SLTradeKeyboard

/** 懒加载 */
- (NSMutableArray *)allBtns {
    if (_numBtns == nil) {
        _numBtns = [NSMutableArray array];
    }
    
    return _numBtns;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        /** 添加所有按键 */
        [self setupAllBtns];
    }
    return self;
}

/** 添加所有按键 */
- (void)setupAllBtns
{
    for (int i = 0; i < kButtonsCount; i++) {
        // 创建按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self addSubview:btn];
        // 按钮公共属性
        [btn setBackgroundImage:[UIImage imageNamed:@"SLTradeView.bundle/number_bg"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        if (i == 9) {  // 确定按钮
            btn.enabled = NO;
            [btn setBackgroundColor:[UIColor clearColor]];
        } else if (i == 10) {  // 0 按钮
            [btn setTitle:@"0" forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:SLScreenWidth * 0.06875];
            btn.tag = 0;
            [btn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.numBtns addObject:btn];
        } else if (i == 11) {  // 删除按钮
            [btn setTitle:@"删除" forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:SLScreenWidth * 0.046875];
            [btn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
        } else {  // 其他数字按钮
            [btn setTitle:[NSString stringWithFormat:@"%d", i + 1] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:SLScreenWidth * 0.06875];
            btn.tag = i + 1;
            [btn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.numBtns addObject:btn];
        }
    }
}

#pragma mark - Private方法,按钮监听
/** 删除按钮点击 */
- (void)deleteBtnClick
{
    if ([self.delegate respondsToSelector:@selector(tradeKeyboardDeleteBtnClick)]) {
        [self.delegate tradeKeyboardDeleteBtnClick];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:SLTradeKeyboardDeleteButtonClickKey object:nil];
}

/** 数字按钮点击 */
- (void)numBtnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(tradeKeyboard:numBtnClick:)]) {
        [self.delegate tradeKeyboard:self numBtnClick:btn.tag];
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:SLTradeKeyboardNumberButtonClickKey object:@(btn.tag)];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 定义总列数
    NSInteger totalCol = 3;
    
    // 定义间距
    CGFloat pad = SLScreenWidth * 0.015625;
    
    // 定义x y w h
    CGFloat x;
    CGFloat y;
    CGFloat w = SLScreenWidth * 0.3125;
    CGFloat h = SLScreenWidth * 0.14375;
    
    // 列数 行数
    NSInteger row;
    NSInteger col;
    for (int i = 0; i < kButtonsCount; i++) {
        row = i / totalCol;
        col = i % totalCol;
        x = pad + col * (w + pad);
        y = row * (h + pad) + pad;
        UIButton *btn = self.subviews[i];
        btn.frame = CGRectMake(x, y, w, h);
    }
}

@end
