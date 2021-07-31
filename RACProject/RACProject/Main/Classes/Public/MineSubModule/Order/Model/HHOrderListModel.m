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
             @"buttonArea":@"ButtonAreaItem",
             @"orders": @"HHOrdersModel"
    };
}



@end

@implementation HHOrdersModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"orderItemVOs":@"HHOrderItemVOsItem",
             @"giftProducts":@"HHGiftProducts",
             @"warrantyExtensionList":@"HHWarrantyExtensionList",
             
    };
}

@end

@implementation HHOrderItemVOsItem


@end

@implementation HHSpecificationsItem


@end

@implementation HHGiftProducts


@end

@implementation HHWarrantyExtensionList


@end




