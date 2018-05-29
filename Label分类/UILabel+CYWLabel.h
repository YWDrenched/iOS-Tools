//
//  UILabel+CYWLabel.h
//  SensorCharging
//
//  Created by 陈友文 on 2017/11/10.
//  Copyright © 2017年 cyw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (CYWLabel)

/**
 普通label

 @return label
 */
+(UILabel *)cyw_normalLabel;


/**
 带字label

 @param str str
 @return label
 */
+(UILabel *)cyw_LabelWithTitle:(NSString *)str;


/**
 带字 字体Label

 @param str str
 @param font 字体
 @return label
 */
+(UILabel *)cyw_LabelWithTitle:(NSString *)str withFont:(UIFont *)font;


/**
 带字 字体 字体颜色Label

 @param str str
 @param font 字体
 @param color 字体颜色
 @return Label
 */
+(UILabel *)cyw_LabelWithTitle:(NSString *)str withFont:(UIFont *)font withColor:(UIColor *)color;


/**
  带字 字体 字体颜色 FrameLabel

 @param str str
 @param font 字体
 @param color 字体颜色
 @param frame frame
 @return label
 */
+(UILabel *)cyw_LabelWithTitle:(NSString *)str withFont:(UIFont *)font withColor:(UIColor *)color withFrame:(CGRect)frame;

/**
 带字 字体 字体颜色 Frame行数 Label

 @param str str
 @param font 字体
 @param color 字体颜色
 @param frame frame
 @param numOfLine 行数
 @return Label
 */
+(UILabel *)cyw_LabelWithTitle:(NSString *)str withFont:(UIFont *)font withColor:(UIColor *)color withFrame:(CGRect)frame withLine:(NSInteger )numOfLine;

@end
