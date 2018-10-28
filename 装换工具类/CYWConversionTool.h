//
//  CYWConversionTool.h
//  OperationsAssistant
//
//  Created by 陈友文 on 2018/10/28.
//  Copyright © 2018年 陈友文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYWConversionTool : NSObject


/**
 将dict装换为dict字符串

 @param dict dict
 @return strting
 */
+(NSMutableString *)convertToJsonData:(NSDictionary *)dict;


/**
 16进制字符串转换为10进制

 @param aHexString 16进制字符
 @return 10进制NSNumber
 */
+(NSNumber *) numberHexString:(NSString *)aHexString;



/**
 十进制long loog int型转16进制字符串
 
 @param tmpid int
 @return string
 */
+(NSString *)ToHex:(long long int)tmpid;



/**
 16进制字符中转换为data

 @param hexString 16进制字符串
 @return data
 */
+(NSData*)dataForHexString:(NSString*)hexString;




/**
 蓝牙通讯中将特征值返回的date转为字符串

 @param data01 data
 @return string
 */
+(NSString *)convertDataToHexStr:(NSData *)data01;




/**
 字符串补0
 
 @param str str
 @param length 长度
 @return str
 */
+(NSString *)addZero:(NSString *)str withLength:(int)length;

@end
