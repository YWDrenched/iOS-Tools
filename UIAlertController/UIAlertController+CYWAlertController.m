//
//  UIAlertController+CYWAlertController.m
//  SensorCharging
//
//  Created by 陈友文 on 2018/5/28.
//  Copyright © 2018年 cyw. All rights reserved.
//

#import "UIAlertController+CYWAlertController.h"

@implementation UIAlertController (CYWAlertController)

+(instancetype)alertBaseMsg:(NSString *)msg{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
    [alertVC addAction:ac1];
    return alertVC;
}


+(instancetype)alertBaseMsg:(NSString *)msg wtihCompletion:(completion)completion{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *ac2 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completion(action);
    }];
    [alertVC addAction:ac1];
    [alertVC addAction:ac2];
    return alertVC;
}

@end
