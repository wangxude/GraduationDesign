//
//  TLNewWorkService.m
//  基于ios平台的图灵机器人
//
//  Created by 王旭 on 2018/1/9.
//  Copyright © 2018年 kys-5. All rights reserved.
//

#import "TLNewWorkService.h"

#import <AFNetworking/AFNetworking.h>

@implementation TLNewWorkService

+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    [session.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];
    // [self setHTTPHeader];  // 可在此处设置Http头信息
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //1.拼接完整字符串
   NSString* url = [NSString stringWithFormat:@"%@%@",@"https://api.douban.com",URLString];
    [session POST:[NSString stringWithFormat:@"%@",url] parameters:parameters progress: ^(NSProgress *progress)
     {
         
     }
          success:^(NSURLSessionDataTask *task, id responseObject)
     {
         if (success) {
             
             success(responseObject);
             
         }
     }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              if (failure) {
                  failure(error);
              }
          }];
}

+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure{
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    [session.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];
    // [self setHTTPHeader];  // 可在此处设置Http头信息
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [session GET:[NSString stringWithFormat:@"%@",URLString] parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        
    }];
    
}

@end
