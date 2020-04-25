//
//  HHOrderListModel.m
//  RACProject
//
//  Created by flowerflower on 2020/4/25.
//  Copyright © 2020 flowerflower. All rights reserved.
//

#import "HHOrderListModel.h"

@implementation HHOrderListModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"orderItems":@"OrderItemsItem",
             @"postManInfo":@"PostManInfo",
             @"priceArea":@"PriceArea",
             @"buttonArea":@"ButtonAreaItem"
    };
}



@end

@implementation PriceArea
@end


@implementation ButtonAreaItem
@end


@implementation OrderItemsItem
@end


@implementation QualityReport
@end


@implementation PostManInfo
@end
