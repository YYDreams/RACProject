//
//  HTTPRequest.m
//  Headline
//
//  Created by 花花 on 2017/2/14.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "HTTPRequest.h"

#import <AFNetworking/AFNetworking.h>
#import "AFHTTPSessionManager+Config.h"
#import "HTTPRequest+NotLogin.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
//#import "Reachability.h"
@implementation LYRequestModel

+ (LYRequestModel *)newWithTask:(id)task{
    LYRequestModel * model = [[LYRequestModel alloc]init];
    model.task = task;
    return  model;
}

- (BOOL)isFinish{
    NSURLSessionDataTask *task = self.task;
    return task.state == NSURLSessionTaskStateCompleted;
}

- (void)cancel{
    NSURLSessionDataTask *task = self.task;
    [task cancel];
}

@end

@implementation HTTPRequest

#pragma mark - 单例
+(AFHTTPSessionManager *)requestManager{
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        [manager configSetting];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.requestSerializer.HTTPShouldHandleCookies = YES;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"image/jpeg",@"image/png", nil];
    });
    
    //检测网络状态的改变
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                //                YSLog(@"未知");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                //                YSLog(@"3G");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                //                YSLog(@"WIFI");
                break;
            default:
                break;
        }
    }];
    
    //3.开始监听
    [manager.reachabilityManager startMonitoring];
    return manager;
}

//返回网络状态
+ (AFNetworkReachabilityStatus)networkReachabilityStatus{
    return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
}


+ (BOOL)isNetworkAvailable{
    if ([HTTPRequest networkReachabilityStatus] == AFNetworkReachabilityStatusReachableViaWiFi || [HTTPRequest networkReachabilityStatus] == AFNetworkReachabilityStatusReachableViaWWAN  ) {
        return YES;
    }else{
        return NO;
    }
    return NO;
}

#pragma mark - host管理
+ (NSString *)InterfaceUrl:(NSString *)url{
//    NSString *urlstring = [NSString stringWithFormat:@"%@/%@",MAIN_URL,url];
    return url;
}

#pragma mark - 网络请求
+ (LYRequestModel *)GET:(NSString *)urlString parameter:(NSDictionary *)parameter success:(requestSuccessCallBack)success failure:(requestErrorCallBack)failue
{
    AFHTTPSessionManager *manager = [HTTPRequest requestManager];
    // 如果已有Cookie, 则把你的cookie符上
//    NSString *cookie = [[NSUserDefaults standardUserDefaults] objectForKey:@"Cookie"];
//    if (cookie != nil) {
//        [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
//    }
    
    //配置公共参数
    parameter = [AFHTTPSessionManager configBaseParmars:parameter];
    NSURLSessionDataTask *task =   [manager GET:[HTTPRequest InterfaceUrl:urlString] parameters:parameter headers:[HTTPRequest requestHeader] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       NSLog(@"urlString: %@ --\n parameter%@",urlString,parameter);
              
              NSString *response = nil;
              if ([responseObject isKindOfClass:[NSData class]]) {
                  response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                  NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
                  id dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                  
                  if ([dic isKindOfClass:[NSArray class]]) {
                      dic = [dic firstObject];
                  }
                  [HTTPRequest handelSuccessRequest:task responseObject:dic success:success fail:failue];
                  return;
              }
              
              if (responseObject&&[responseObject isKindOfClass:[NSDictionary class]]){
                  [HTTPRequest handelSuccessRequest:task responseObject:responseObject success:success fail:failue];
              }
              else if (responseObject&&[responseObject isKindOfClass:[NSArray class]]){
                  [HTTPRequest handelSuccessRequest:task responseObject:responseObject success:success fail:failue];
              }
              else {
                  NSError * error = [NSError errorWithDomain:@"服务器出错了" code:-100 userInfo:@{@"message":@"服务器返回的不是json或者是空对象"}];
                  [HTTPRequest handelFailRequest:task err:error fail:failue];
              }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       [HTTPRequest handelFailRequest:task err:error fail:failue];

    }];

    LYRequestModel *requestModel = [LYRequestModel newWithTask:task];
    return requestModel;
}

/*POST请求*/
+ (LYRequestModel *)POST:(NSString *)urlString  parameter:(NSDictionary *)parameter  success:(requestSuccessCallBack)success failure:(requestErrorCallBack)failue{
    
    AFHTTPSessionManager *manager = [HTTPRequest requestManager];
    
    //配置公共参数
    parameter = [AFHTTPSessionManager configBaseParmars:parameter];
    
    [HTTPRequest showActive];
    NSURLSessionDataTask *task =   [manager POST:[HTTPRequest InterfaceUrl:urlString] parameters:parameter headers:[HTTPRequest requestHeader] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"urlString: %@ --\n parameter%@",urlString,parameter);
        
        
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSString * response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSData * data = [response dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            [HTTPRequest handelSuccessRequest:task responseObject:dic success:success fail:failue];
            return;
        }

        if (responseObject&&[responseObject isKindOfClass:[NSDictionary class]]) {
            [HTTPRequest handelSuccessRequest:task responseObject:responseObject success:success fail:failue];
        }
        else{
            NSError * error = [NSError errorWithDomain:@"服务器出错了" code:-100 userInfo:@{@"message":@"服务器返回的不是json或者是空对象"}];
            [HTTPRequest handelFailRequest:task err:error fail:failue];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [HTTPRequest handelFailRequest:task err:error fail:failue];
    }];
    
    LYRequestModel *requestModel = [LYRequestModel newWithTask:task];
    return requestModel;
}

#pragma mark - 请求处理
+ (void)handelSuccessRequest:(NSURLSessionDataTask * _Nonnull)task responseObject:(id _Nullable)responseObject success:(requestSuccessCallBack)success fail:(requestErrorCallBack)fail{
    
    [HTTPRequest hideActive];
    
    
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
    NSInteger statusCode = response.statusCode;
    NSLog(@"success statusCode %ld===============",statusCode);
    
    if (statusCode == resultCode_1032) {  //您的登录地址发生了改变，请通过短信验证码登录'
        
        BOOL isSingle  =  [HTTPRequest singleLoginWithResult:statusCode msg:responseObject[@"msg"]];
        if (isSingle){
            return;
        }
    }else{
        if (success) {
            success(responseObject);
        }
    }
}


+ (void)handelFailRequest:(NSURLSessionDataTask * _Nonnull)task err:(NSError * _Nullable)err fail:(requestErrorCallBack)fail{
    [self hideActive];
    
    if (fail) {
        fail(err);
    }
    
}


#pragma mark - 状态栏网络请求图标
+ (void)showActive {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

+ (void)hideActive {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

+ (NSDictionary *)requestHeader{
    
    return @{
             @"apptype":@"ios",
             @"device-type":@"ios",
             @"tpg":@"1",
             @"system-language":@"CN",
             @"auth-token":@"331723dee4112c07887498beba0e1b8b1859cbaf3a942c063cdfb99b40b9923f",
             @"app-version" : @"5.0.5387.5387",
             @"device-id" : @"ed9d2f2303adb733953a4c0e000010914c02",
             @"device-os-version":@"14.2.1",
             @"device-name":@"iPhone_12",
             @"latitude":@"31.239974",
             @"longitude":@"121.519385"};
}
@end

