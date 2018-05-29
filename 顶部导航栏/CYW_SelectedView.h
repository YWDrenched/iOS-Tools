//
//  CYW_SelectedView.h
//  01-测试
//
//  Created by 陈友文 on 2018/4/24.
//  Copyright © 2018年 cyw. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^selectBlock)(NSInteger btnTag);

@interface CYW_SelectedView : UIView
/**
 title数组
 */
@property (nonatomic,strong)NSArray<NSString *> *titleArr;
/**
 选中颜色
 */
@property (nonatomic,strong)UIColor *selectedColor;
/**
 普通颜色
 */
@property (nonatomic,strong)UIColor *normalColor;
/**
 背景图片
 */
@property (nonatomic,strong)UIColor *backColor;
/**
 下划线的颜色
 */
@property (nonatomic,strong)UIColor *lineColor;
/**
 下划线
 */
@property (nonatomic,strong)UIView *underLine;

/**
 点击按钮回调block
 */
@property (nonatomic,copy)selectBlock selectBlock;

/**
 选中按钮
 */
@property (nonatomic,assign)NSInteger selectType;
/**
 计算移动的距离

 @param i page或者i
 @param count 一般为数组长度
 @return 返回移动距离
 */
-(CGFloat)calculateMoveDistance:(NSInteger)i withCount:(NSInteger)count;

@end
