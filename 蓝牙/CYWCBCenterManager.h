//
//  CYWCBCenterManager.h
//  蓝牙Manager
//
//  Created by 陈友文 on 2017/11/8.
//  Copyright © 2017年 陈友文. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>
#import <UIKit/UIKit.h>

//typedef void(^successBlock)(BOOL result);



@interface CYWCBCenterManager : CBCentralManager

/**
 mac地址
 */
@property (nonatomic,copy) NSString *macAddress;

/**
 设备ID
 */
@property (nonatomic,copy) NSString *deviceNum;

/**
 选择时间
 */
@property (nonatomic,assign) CGFloat selectTime;

@property (nonatomic,strong)NSMutableArray *peripheralArr;

@property (nonatomic,strong)CBCentralManager *mgr;

/**
 当前连接的外设
 */
@property (nonatomic,strong)CBPeripheral *currentPeripheral;

//+(instancetype)shareManager;

/**
 操作设备
 
 @param time 传入时间
 */
-(void)ControllerDevice:(CGFloat)time;

/**
 重新连接
 */
-(void)reConnectDevice;

/**
 注销
 */
-(void)regist;

@end
