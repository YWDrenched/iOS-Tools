//
//  CYW_SelectedView.m
//  01-测试
//
//  Created by 陈友文 on 2018/4/24.
//  Copyright © 2018年 cyw. All rights reserved.
//

#import "CYW_SelectedView.h"
#import "UIView+CYWExtension.m"

// 首页的选择器的宽度
#define Default_W 60
#define Default_H 30
#define DefaultMargin 60

@interface CYW_SelectedView ()
@property (nonatomic,strong)UIButton *selBtn;

/**
 按钮数组
 */
@property (nonatomic,strong)NSMutableArray *btnArr;

@end

@implementation CYW_SelectedView

-(NSMutableArray *)btnArr{
    if (_btnArr == nil) {
        _btnArr = [NSMutableArray array];
    }
    return _btnArr;
}

- (UIView *)underLine
{
    if (!_underLine) {
        UIView *underLine = [[UIView alloc] initWithFrame:CGRectMake(DefaultMargin, self.height-4, Default_W, 2)];
        underLine.backgroundColor = [UIColor whiteColor];
        [self addSubview:underLine];
        _underLine = underLine;
    }
    return _underLine;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
}

-(void)setTitleArr:(NSArray<NSString *> *)titleArr{
    NSInteger i = 0;
    for (NSString *title in titleArr) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.6] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        CGFloat x = [self calculateMoveDistance:i withCount:titleArr.count];
        btn.frame = CGRectMake(x, (self.height-Default_H)/2, Default_W, Default_H);
        btn.tag = i+1;
        [self.btnArr addObject:btn];
        i++;
    }
}

-(CGFloat)calculateMoveDistance:(NSInteger)i withCount:(NSInteger)count{
    return DefaultMargin + Default_W*i +(self.width - 2*DefaultMargin-count*Default_W)/(count - 1)*i;
}

-(void)click:(UIButton *)sender{
    self.selBtn.selected = NO;
    sender.selected = YES;
    self.selBtn = sender;
    [UIView animateWithDuration:0.3 animations:^{
        self.underLine.x = sender.x;
    }];
    
    if (self.selectBlock) {
        self.selectBlock(sender.tag);
    }
}

-(void)setSelectType:(NSInteger)selectType{
    _selectType = selectType;
    for (UIButton *btn in self.btnArr) {
        if (btn.tag == selectType + 1) {
            [self click:btn];
        }
    }
}

-(void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor = selectedColor;
    for (UIButton *btn in self.btnArr) {
        [btn setTitleColor:selectedColor forState:UIControlStateSelected];
    }
}

-(void)setNormalColor:(UIColor *)normalColor{
    _normalColor = normalColor;
    for (UIButton *btn in self.btnArr) {
        [btn setTitleColor:normalColor forState:UIControlStateNormal];
    }
}

-(void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    self.underLine.backgroundColor = lineColor;
}

-(void)setBackColor:(UIColor *)backColor{
    _backColor = backColor;
    self.backgroundColor = backColor;
}


@end

