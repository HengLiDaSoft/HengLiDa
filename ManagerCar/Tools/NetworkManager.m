//
//  NetworkManager.m
//  ManagerCar
//
//  Created by wanshaoyong on 2019/10/23.
//  Copyright © 2019 Henanhld. All rights reserved.
//

#import "NetworkManager.h"
#import <AFNetworking.h>

@implementation NetworkManager
+ (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id))success
                  failure:(void (^)(NSError *))failure{
    
    
    AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    /*
     //申明请求的数据是json类型
     manager.requestSerializer=[AFJSONRequestSerializer serializer];
     //[manager.requestSerializer setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
     [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
     
     NSString *tokenStr = [@"BasicAuth " stringByAppendingString:[Tools UserDefaultObjectForKey:@"Token"]];
     [manager.requestSerializer setValue:tokenStr forHTTPHeaderField:@"Authorization"];
     */
    
    
    //申明请求的数据是json类型
    AFHTTPRequestSerializer *request = [AFHTTPRequestSerializer serializer];
    //实例:Content-Type: application/x-www-form-urlencoded
    //[request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSString *tokenStr = [@"BasicAuth " stringByAppendingString:[Tools UserDefaultObjectForKey:@"Token"]];
    [manager.requestSerializer setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    
    
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    
    //发送请求
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}



+ (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(id))success
                 failure:(void (^)(NSError *))failure{
    
    //AFHTTPRequestSerializer *request = [AFHTTPRequestSerializer serializer];
    
    /*
     [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
     [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Accept"];
     */
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc]init];
    [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    [securityPolicy setAllowInvalidCertificates:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setSecurityPolicy:securityPolicy];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    
    [manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}


@end
