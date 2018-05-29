//
//  CYW_Reachbility.h
//  testForCharging
//
//  Created by 陈友文 on 2017/12/12.
//  Copyright © 2017年 陈友文. All rights reserved.
//

#import "Reachability.h"

@interface CYW_Reachbility : Reachability

/**
 判断网络状态

 @return yes有网 no没网
 */
+(BOOL)cyw_NetWorkState;

@end
