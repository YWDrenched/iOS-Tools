//
//  UIImage+ResizableImage.h
//  SiChong
//
//  Created by cyw on 2017/7/31.
//  Copyright © 2017年 cyw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ResizableImage)


/**
 剪切图片

 @param imageName 传入的imagem名字
 @return 返回image
 */
+(UIImage *)cyw_resizableImage:(NSString *)imageName;

/**
 color转image

 @param color 颜色
 @return image
 */
+ (UIImage*)cyw_createImageWithColor: (UIColor*) color;
/**
 image切圆角
 
 @param image image
 @param rect rect
 @param bgColor 背景颜色
 @return 返回的Image
 */
+(UIImage *)cyw_avatarImage:(UIImage *)image withRect:(CGRect)rect withBackColor:(UIColor *)bgColor;

@end
