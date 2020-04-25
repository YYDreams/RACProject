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


//用于模拟网络请求
static NSString *kSimulationUrl =@"http://www.mocky.io/v2/5ea3c9384f00003729d9f9c1";


+(void)requestForOrderListSimulationWithCompletion:(void(^)(NetworkStatus status,NSArray *listArr, NSDictionary *pageInfo))completion{
    
//    [HTTPRequest  GET:kSimulationUrl parameter:nil success:^(id resposeObject) {
       
//        if ([resposeObject[@"code"] intValue] == 0) {
            
            NSDictionary *dic = [NSDictionary readLocalFileWithName:@"orderList"];

//            NSArray * array = dic [@"data"];
//            NSMutableArray * temp = @[].mutableCopy;
//            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                [temp addObject: [HHOrderListModel objectWithDic:obj]];
//            }];
            NSArray *list = [HHOrderListModel objectsInArray:dic[@"data"][@"results"]];
            
            
            completion(NetworkStatusSuccess,list,dic[@"page"]);
            
//        }else{
//            completion(NetworkStatusFailed,nil,nil);
//        }
//    } failure:^(NSError *error) {
//        
//        completion(NetworkStatusError,nil,nil);
//        
//       
//    }];
//    
}
@end
