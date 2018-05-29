//
//  UIImage+ResizableImage.m
//  SiChong
//
//  Created by cyw on 2017/7/31.
//  Copyright © 2017年 cyw. All rights reserved.
//

#import "UIImage+ResizableImage.h"

@implementation UIImage (ResizableImage)

+(UIImage *)cyw_resizableImage:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat w = image.size.width * 0.5;
//    CGFloat h = image.size.height * 0.5;
    return  [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, w, 0, w ) resizingMode:UIImageResizingModeTile];
}

+ (UIImage*)cyw_createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0,0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+(UIImage *)cyw_avatarImage:(UIImage *)image withRect:(CGRect)rect withBackColor:(UIColor *)bgColor{
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0);
    //背景填充颜色
    [bgColor setFill];
    UIRectFill(rect);
    //圆角
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [path addClip];
    //绘制
    [image drawInRect:rect];
    //获取图形上下文
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    return resultImage;
    
}

@end
