//
//  UIAlertController+CYWAlertController.h
//  SensorCharging
//
//  Created by 陈友文 on 2018/5/28.
//  Copyright © 2018年 cyw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^completion)(UIAlertAction *action);

@interface UIAlertController (CYWAlertController)

+(instancetype)alertBaseMsg:(NSString *)msg;

+(instancetype)alertBaseMsg:(NSString *)msg wtihCompletion:(completion)completion;






@end
