//
//  MBProgressHUD+CYW_ProgressHUD.m
//  
//
//  Created by 陈友文 on 2017/12/1.
//
//

#import "MBProgressHUD+CYW_ProgressHUD.h"

#define kHUDTitleFont(s) [UIFont systemFontOfSize:s]
#define kHUDTextFont(s) [UIFont systemFontOfSize:s]
#define kHideHUDTime 2.f
#define kHUDMessageOffsetY -([UIScreen mainScreen].bounds.size.height / 4)
#define kSuccessImage @""
#define kFailImage @""

@implementation MBProgressHUD (CYW_ProgressHUD)

+(void)cyw_showLoadingHUD{
    [self cyw_showLoadingHUDView:nil];
}

+(void)cyw_hideLoadingHUD{
    [self cyw_hideLoadingHUDView:nil];
}

+(void)cyw_hideLoadingHUDView:(UIView *)view{
    if (view== nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    [MBProgressHUD hideHUDForView:view animated:YES];
}

+(void)cyw_showLoadingHUDView:(UIView *)view{
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    [MBProgressHUD showHUDAddedTo:view animated:YES];
    
}

+(void)cyw_showSuccess:(NSString *)success{
//    [self cyw_hideLoadingHUD];
    [self cyw_showSuccess:success withView:nil];
}

+(void)cyw_showFail:(NSString *)fail{
//    [self cyw_hideLoadingHUD];
    [self cyw_showFail:fail withView:nil];
    
}

+(void)cyw_showSuccess:(NSString *)success withView:(UIView *)view{
    [MBProgressHUD cyw_showHUDWithText:success withIcon:kSuccessImage withView:view];
}

+(void)cyw_showFail:(NSString *)fail withView:(UIView *)view{
    [MBProgressHUD cyw_showHUDWithText:fail withIcon:kFailImage withView:view];
    
}

+(void)cyw_showHUDWithText:(NSString *)text withIcon:(NSString *)iconStr withView:(UIView *)view{
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    提示框背景颜色
    hud.bezelView.color = [UIColor blackColor];
//    背景覆盖模式
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.label.text = text;
    hud.label.font = kHUDTitleFont(14);
//    bezelView大小
    hud.margin = 10;
    [hud showAnimated:YES];
    [view addSubview:hud];
    [hud hideAnimated:YES afterDelay:kHideHUDTime];
    hud.removeFromSuperViewOnHide = YES;
//    自定义模式
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconStr]];
    
}

+(void)cyw_showMessageHUDText:(NSString *)text{
    [self cyw_showMessageHUDText:text withOffsetY:kHUDMessageOffsetY];
}

+(void)cyw_showMessageHUDText:(NSString *)text withOffsetY:(CGFloat)y{
    [self cyw_showMessageHUDText:text withOffsetY:y withView:nil];
}

+(void)cyw_showMessageHUDText:(NSString *)text withOffsetY:(CGFloat)y withView:(UIView *)view{
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [view addSubview:hud];
    hud.bezelView.color = [UIColor blackColor];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    hud.label.textColor = [UIColor whiteColor];
    hud.label.font = kHUDTitleFont(12);
    hud.margin = 10;
    hud.removeFromSuperViewOnHide = YES;
//    y轴平移位置 在MBProgress1.0.0中废弃该属性了
    hud.yOffset = y;
    [hud hideAnimated:YES afterDelay:kHideHUDTime];
    
    
}

@end
