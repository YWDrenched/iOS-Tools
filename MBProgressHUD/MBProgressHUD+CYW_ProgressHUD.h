//
//  MBProgressHUD+CYW_ProgressHUD.h
//  
//
//  Created by 陈友文 on 2017/12/1.
//
//

#import <MBProgressHUD/MBProgressHUD.h>

typedef void(^completion)(MBProgressHUD *hud);

@interface MBProgressHUD (CYW_ProgressHUD)
/*
 
 1.显示网络加载失败HUD 有文字 有图片 消失时间默认为2S
 
 
 
 2.显示网络加载成功HUD 有文字 有图片 消失时间默认为2S
 
 
 3.显示提示信息，只有文字（例如 短息已经发送之类的）消失时间默认为2S
 
 
 4.显示一直加载的菊花，直到完成某件任务后消失

 
 */

/**
一直转菊花
 */
+(void)cyw_showLoadingHUD;

+(void)cyw_hideLoadingHUD;

+(void)cyw_hideLoadingHUDView:(UIView *)view;

/**
 指定的View一直转菊花

 @param view 指定的View

 */
+(void)cyw_showLoadingHUDView:(UIView *)view;

/**
 显示成功HUD(默认view为nil)

 @param success 成功Str
 */
+(void)cyw_showSuccess:(NSString *)success;

/**
 显示失败HUD(默认view为nil)

 @param fail 失败Str
 */
+(void)cyw_showFail:(NSString *)fail;


/**
 显示成功HUD（指定View）

 @param success 成功Str
 @param view 指定View
 */
+(void)cyw_showSuccess:(NSString *)success withView:(UIView *)view;

/**
 显示失败HUD（指定View）
 
 @param fail 失败Str
 @param view 指定View
 */
+(void)cyw_showFail:(NSString *)fail withView:(UIView *)view;



/**
 显示自定义的MBPProgressStyle

 @param text 文字
 @param iconStr 图片
 @param view 指定View
 */
+(void)cyw_showHUDWithText:(NSString *)text withIcon:(NSString *)iconStr withView:(UIView *)view;



/**
  显示提示用户信息(默认view为nil,y轴默认为屏幕1/4处)

 @param text 提示内容
 */
+(void)cyw_showMessageHUDText:(NSString *)text;
/**
 显示提示用户信息(默认view为nil)

 @param text 提示内容
 @param y 在Y轴平移大小
 */
+(void)cyw_showMessageHUDText:(NSString *)text withOffsetY:(CGFloat)y;




@end
