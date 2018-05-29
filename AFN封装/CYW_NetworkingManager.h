//
//  CYW_NetworkingManager.h
//  testForCharging
//
//  Created by 陈友文 on 2017/12/12.
//  Copyright © 2017年 陈友文. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
//#import <AFNetworking.h>

/**
 请求类型

 - CYW_NetWorkTypeGET: GET
 - CYW_NetWorkTypePOST: POST
 */
typedef NS_ENUM(NSInteger, NetWorkType) {
    NetWorkTypeGET = 1,
    NetWorkTypePOST = 2,
};

typedef void(^successBlock)(id result);
typedef void(^failBlock)(NSError *error);

@interface CYW_NetworkingManager : AFHTTPSessionManager
+(instancetype)shareManager;

/**
 发送请求

 @param type 请求类型
 @param URLString urlString
 @param parameters 参数
 @param successBlcok 成功回调
 @param failBlock 失败回调
 */
-(void)cyw_networkType:(NetWorkType)type withURLString:(NSString *)URLString withParameters:(id)parameters withSuccessBlock:(successBlock)successBlcok withFailBlock:(failBlock)failBlock;


/**
 上传图片

 @param URLString URLString
 @param parameter 参数
 @param imageArr 图片数组
 @param successBlock 成功回调
 @param FailBlcok 失败回调
 */
-(void)upImageWithUrl:(NSString *)URLString Parameter:(NSDictionary *)parameter ImageArr:(NSArray *)imageArr SuccessBlock:(successBlock)successBlock FailBlock:(failBlock)FailBlcok;
@end

//enum
//{
//    NSURLErrorUnknown = -1,
//    NSURLErrorCancelled = -999,
//    NSURLErrorBadURL = -1000,
//    NSURLErrorTimedOut = -1001,
//    NSURLErrorUnsupportedURL = -1002,
//    NSURLErrorCannotFindHost = -1003,
//    NSURLErrorCannotConnectToHost = -1004,
//    NSURLErrorDataLengthExceedsMaximum = -1103,
//    NSURLErrorNetworkConnectionLost = -1005,
//    NSURLErrorDNSLookupFailed = -1006,
//    NSURLErrorHTTPTooManyRedirects = -1007,
//    NSURLErrorResourceUnavailable = -1008,
//    NSURLErrorNotConnectedToInternet = -1009,
//    NSURLErrorRedirectToNonExistentLocation = -1010,
//    NSURLErrorBadServerResponse = -1011,
//    NSURLErrorUserCancelledAuthentication = -1012,
//    NSURLErrorUserAuthenticationRequired = -1013,
//    NSURLErrorZeroByteResource = -1014,
//    NSURLErrorCannotDecodeRawData = -1015,
//    NSURLErrorCannotDecodeContentData = -1016,
//    NSURLErrorCannotParseResponse = -1017,
//    NSURLErrorInternationalRoamingOff = -1018,
//    NSURLErrorCallIsActive = -1019,
//    NSURLErrorDataNotAllowed = -1020,
//    NSURLErrorRequestBodyStreamExhausted = -1021,
//    NSURLErrorFileDoesNotExist = -1100,
//    NSURLErrorFileIsDirectory = -1101,
//    NSURLErrorNoPermissionsToReadFile = -1102,
//    NSURLErrorSecureConnectionFailed = -1200,
//    NSURLErrorServerCertificateHasBadDate = -1201,
//    NSURLErrorServerCertificateUntrusted = -1202,
//    NSURLErrorServerCertificateHasUnknownRoot = -1203,
//    NSURLErrorServerCertificateNotYetValid = -1204,
//    NSURLErrorClientCertificateRejected = -1205,
//    NSURLErrorClientCertificateRequired = -1206,
//    NSURLErrorCannotLoadFromNetwork = -2000,
//    NSURLErrorCannotCreateFile = -3000,
//    NSURLErrorCannotOpenFile = -3001,
//    NSURLErrorCannotCloseFile = -3002,
//    NSURLErrorCannotWriteToFile = -3003,
//    NSURLErrorCannotRemoveFile = -3004,
//    NSURLErrorCannotMoveFile = -3005,
//    NSURLErrorDownloadDecodingFailedMidStream = -3006,
//    NSURLErrorDownloadDecodingFailedToComplete = -3007
//}



