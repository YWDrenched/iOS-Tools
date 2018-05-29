//
//  CYW_Reachbility.m
//  testForCharging
//
//  Created by 陈友文 on 2017/12/12.
//  Copyright © 2017年 陈友文. All rights reserved.
//

#import "CYW_Reachbility.h"
#import "Reachability.h"

#define kHostName @"www.baidu.com"

@implementation CYW_Reachbility

+(BOOL)cyw_NetWorkState{
    BOOL isConnect = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:kHostName];
    switch ([reach currentReachabilityStatus]) {
            //没有网络连接
        case NotReachable:
            isConnect = NO;
            break;
            //Wifi连接
        case ReachableViaWiFi:
            isConnect = YES;
            break;
            //手机流量
        case ReachableViaWWAN:
            isConnect = YES;
            break;
            
        default:
            break;
    }
    if (isConnect) {
        return YES;
    }
    
    return NO;
    
}


@end
