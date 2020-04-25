//
//  HHOrderListModel.h
//  RACProject
//
//  Created by flowerflower on 2020/4/25.
//  Copyright © 2020 flowerflower. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN



@interface PriceArea :NSObject
@property (nonatomic , copy) NSString              * payPriceText;
@property (nonatomic , assign) NSInteger              payPrice;

@end


@interface ButtonAreaItem :NSObject
@property (nonatomic , assign) NSInteger              key;
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , copy) NSString              * bgColor;
@property (nonatomic , copy) NSString              * foreColor;
@property (nonatomic , copy) NSString              * frameColor;
@property (nonatomic , copy) NSString              * url;
@property (nonatomic , copy) NSString              * masterId;

@end


@interface OrderItemsItem :NSObject
@property (nonatomic , copy) NSString              * sku;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , assign) NSInteger              quantity;
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , copy) NSString              * spec;

@end


@interface QualityReport :NSObject
@property (nonatomic , copy) NSString              * text;
@property (nonatomic , copy) NSString              * url;
@property (nonatomic , copy) NSString              * icon;

@end


@interface PostManInfo :NSObject

@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * phone;

@end

@interface HHOrderListModel : BaseModel
@property (nonatomic , copy) NSString              * orderId;
@property (nonatomic , copy) NSString              * orderNo;
@property (nonatomic , assign) NSInteger              totalCount;
@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , assign) NSInteger              orderType;
@property (nonatomic , copy) NSString              * status;
//订单状态 0：未付款 1：已付款 2：分拣中 3:配送中 4：已配送 5：已签收 6：退货早请 7：退货中 8：已退货 9：已退货入库 * 10：取消交易
@property (nonatomic , assign) NSInteger              orderStatus;
@property (nonatomic , copy) NSString              * statusText;
@property (nonatomic , copy) NSString              * deliveryTimeEnd;
@property (nonatomic , assign) NSInteger              overTime;
@property (nonatomic , assign) BOOL              chrome;
@property (nonatomic , assign) BOOL              evaluated;
@property (nonatomic , assign) BOOL              mryxShipped;
@property (nonatomic , assign) BOOL              isGroup;
@property (nonatomic , strong) PriceArea              * priceArea;
@property (nonatomic , strong) NSArray <ButtonAreaItem *>              * buttonArea;
@property (nonatomic , strong) NSArray <OrderItemsItem *>              * orderItems;
@property (nonatomic , strong) QualityReport              * qualityReport;
@property (nonatomic , strong) PostManInfo              * postManInfo;
@end



NS_ASSUME_NONNULL_END
