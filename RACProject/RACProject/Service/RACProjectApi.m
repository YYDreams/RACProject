//
//  RACProjectApi.m
//  RACProject
//
//  Created by flowerflower on 2020/4/25.
//  Copyright © 2020 flowerflower. All rights reserved.
//

#import "RACProjectApi.h"
#import "HHOrderListModel.h"

@implementation RACProjectApi



static NSString *kQueryOrderListUrl = @"http://api-qa.samsclub.cn/api/v1/sams/trade/order/queryOrderList";

+ (void)getOderListModelsWithOrderStatus:(NSInteger)orderStatus
                                 pageNum:(NSInteger)pageNum
                             orderScense:(NSInteger)orderScene
                              completion:(void(^)(NetworkStatus status,
                                                  NSString * _Nullable errorStr,
                                                  HHOrderListModel * _Nullable model))completion{
    NSDictionary *params   = orderStatus == 0 ?
    @{@"page":@{@"pageNum":@(pageNum),@"pageSize":@(20)},@"orderScene":@(orderScene)} : @{@"orderStatus": @(orderStatus),@"page":@{@"pageNum":@(pageNum),@"pageSize":@(20)},@"orderScene":@(orderScene)};;
    [HTTPRequest POST:kQueryOrderListUrl parameter:params success:^(id resposeObject) {
        NetworkResult *result = [NetworkResult objectWithDic:resposeObject];
        if ([resposeObject[@"success"] boolValue]) {
            HHOrderListModel *listModel   = [HHOrderListModel objectWithDic:resposeObject[@"data"]];
            
            completion(NetworkStatusSuccess,result.msg,listModel);
        }else{
            completion(NetworkStatusFailed,result.msg,nil);
        }
        
    } failure:^(NSError *error) {
        
    [HTTPRequest isNetworkAvailable] ? completion(NetworkStatusNonet,kNoNetworkTips,nil) :  completion(NetworkStatusError,kNetworkErrorTips,nil);
     
    }];
    
    
}

@end
