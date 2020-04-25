//
//  RACProjectApi.h
//  RACProject
//
//  Created by flowerflower on 2020/4/25.
//  Copyright © 2020 flowerflower. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,NetworkStatus){
    NetworkStatusSuccess = 1,
    NetworkStatusFailed = 2,
    NetworkStatusError = 3,
    
};


NS_ASSUME_NONNULL_BEGIN

@interface RACProjectApi : NSObject


//用于模拟网络请求
+(void)requestForOrderListSimulationWithCompletion:(void(^)(NetworkStatus status,NSArray *listArr, NSDictionary *pageInfo))completion;
                                                 
@end

NS_ASSUME_NONNULL_END
