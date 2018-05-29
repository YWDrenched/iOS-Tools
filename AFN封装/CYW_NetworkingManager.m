//
//  CYW_NetworkingManager.m
//  testForCharging
//
//  Created by 陈友文 on 2017/12/12.
//  Copyright © 2017年 陈友文. All rights reserved.
//

#import "CYW_NetworkingManager.h"

#define kTimeOut 8



@implementation CYW_NetworkingManager
+(instancetype)shareManager{
    
    static CYW_NetworkingManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

-(void)cyw_networkType:(NetWorkType)type
         withURLString:(NSString *)URLString
        withParameters:(id)parameters
      withSuccessBlock:(successBlock)successBlcok
         withFailBlock:(failBlock)failBlock{
    
    [self settingAFNetworking];
    
    if (type == NetWorkTypeGET) {//GET请求
        [self GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            successBlcok(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failBlock(error);
        }];
    }else if (type == NetWorkTypePOST){//POST请求
        [self POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            successBlcok(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failBlock(error);
        }];
    }
}

-(void)upImageWithUrl:(NSString *)URLString Parameter:(NSDictionary *)parameter ImageArr:(NSArray *)imageArr SuccessBlock:(successBlock)successBlock FailBlock:(failBlock)FailBlcok{
    [self settingAFNetworking];
    
    [self POST:URLString parameters:URLString constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSInteger i = 0; i < imageArr.count; i++) {
            NSData *imageData = UIImageJPEGRepresentation(imageArr[i - 1], 1.0);
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"image%zd",i] fileName:@"image" mimeType:@"image/jpg"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        FailBlcok(error);
    }];
    
    
}


-(void)settingAFNetworking{
    
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    [self.requestSerializer setTimeoutInterval:kTimeOut];
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html",@"application/javascript",@"application/json", nil];
}
@end
