//
//  RACProjectApi.h
//  RACProject
//
//  Created by flowerflower on 2020/4/25.
//  Copyright © 2020 flowerflower. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHOrderListModel.h"
#import "HHConst.h"
NS_ASSUME_NONNULL_BEGIN

@interface RACProjectApi : NSObject

+ (void)getOderListModelsWithOrderStatus:(NSInteger)orderStatus
                                 pageNum:(NSInteger)pageNum
                             orderScense:(NSInteger)orderScene
                              completion:(void(^)(NetworkStatus status,
                                                  NSString * _Nullable errorStr,
                                                  HHOrderListModel * _Nullable model))completion;


@end

NS_ASSUME_NONNULL_END
