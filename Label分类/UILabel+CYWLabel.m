//
//  UILabel+CYWLabel.m
//  SensorCharging
//
//  Created by 陈友文 on 2017/11/10.
//  Copyright © 2017年 cyw. All rights reserved.
//

#import "UILabel+CYWLabel.h"

@implementation UILabel (CYWLabel)

+(UILabel *)cyw_normalLabel{
    UILabel *label = [[UILabel alloc] init];
    return label;
}

+(UILabel *)cyw_LabelWithTitle:(NSString *)str{
    UILabel *label = [UILabel cyw_normalLabel];
    label.text = str;
    return label;
    
}

+(UILabel *)cyw_LabelWithTitle:(NSString *)str withFont:(UIFont *)font{
    UILabel *label = [UILabel cyw_LabelWithTitle:str];
    label.font = font;
    return label;
}

+(UILabel *)cyw_LabelWithTitle:(NSString *)str withFont:(UIFont *)font withColor:(UIColor *)color{
    UILabel *label = [UILabel cyw_LabelWithTitle:str
                                        withFont:font];
    label.textColor = color;
    return label;
}

+(UILabel *)cyw_LabelWithTitle:(NSString *)str withFont:(UIFont *)font withColor:(UIColor *)color withFrame:(CGRect)frame{
    UILabel *label = [UILabel cyw_LabelWithTitle:str
                                        withFont:font
                                       withColor:color];
    
    if (CGRectEqualToRect(frame, CGRectZero)) {
        return label;
    }
    label.frame = frame;
    return label;
}

+(UILabel *)cyw_LabelWithTitle:(NSString *)str withFont:(UIFont *)font withColor:(UIColor *)color withFrame:(CGRect)frame withLine:(NSInteger)numOfLine{
    UILabel *label = [UILabel cyw_LabelWithTitle:str
                                        withFont:font
                                       withColor:color
                                       withFrame:frame];
    label.numberOfLines = numOfLine;
    return label;
}

@end
