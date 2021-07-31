//
//  HHOrderListModel.h
//  RACProject
//
//  Created by flowerflower on 2020/4/25.
//  Copyright © 2020 flowerflower. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN


/// ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@interface HHSpecificationsItem : BaseModel

/// 规格名称
@property (nonatomic , copy) NSString              * specTitle;

/// 规格值
@property (nonatomic , copy) NSString              * specValue;

@end


@interface HHGiftProducts :BaseModel
/// 赠送数量
@property (nonatomic , assign) NSInteger              quantity;
/// sku
@property (nonatomic , assign) NSInteger              skuId;
/// spu
@property (nonatomic , assign) NSInteger              spuId;
/// 赠品名称
@property (nonatomic , copy) NSString              *  spuTitle;
/// 赠品实际库存数
@property (nonatomic , assign) NSInteger              stockQuantity;
@end

@interface HHWarrantyExtensionList  :BaseModel
/// 延保商品的外部id(hostItem)
@property (nonatomic , copy) NSString              *  hostItem;
/// 延保价格
@property (nonatomic , assign) NSInteger              price;
/// 延保商品的内部id
@property (nonatomic , assign) NSInteger              spuId;
/// 延保商品名称
@property (nonatomic , copy) NSString              *  title;
/// 延保价格上限
@property (nonatomic , assign) NSInteger              warrantyExtensionMaxApplyPrice;
/// 延保价格下限
@property (nonatomic , assign) NSInteger              warrantyExtensionMinApplyPrice;
/// 延保展示名称
@property (nonatomic , copy) NSString              *  warrantyExtensionName;
/// 延保数量
@property (nonatomic , assign) NSInteger              warrantyExtensionNum;
/// 延保年限
@property (nonatomic , assign) NSInteger              warrantyExtensionYears;

@end



/// ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@interface HHOrderItemVOsItem :BaseModel
//是否支持7天无理由
@property (nonatomic , assign) BOOL                   sevenDaysReturn;
/// 配送标签ID，1:极速达标签,2:全球购标签,3:自提
@property (nonatomic , assign) NSInteger              deliveryTagId;

@property (nonatomic , copy)  NSArray<HHGiftProducts *>        *giftProducts;

@property (nonatomic , copy)  NSArray<HHWarrantyExtensionList *>        *warrantyExtensionList;

/// 实际价格，单位分
@property (nonatomic , assign) NSInteger              actualPrice;

/// 是否缺货1不缺货2缺货
@property (nonatomic , assign) NSInteger              outStock;

/// 实发数量
@property (nonatomic , assign) NSInteger              deliveryCount;

/// 缺货金额
@property (nonatomic , assign) NSInteger              outStockAmount;

/// 购买数量
@property (nonatomic , assign) NSInteger              buyQuantity;

/// 商品主类型
@property (nonatomic , assign) NSInteger              goodsMainType;

/// 商品名称
@property (nonatomic , copy) NSString              * goodsName;

/// 实际付款单价
@property (nonatomic , assign) NSInteger              goodsPaymentPrice;

/// 商品图片
@property (nonatomic , copy) NSString              * goodsPictureUrl;

/// 商品副类型
@property (nonatomic , assign) NSInteger              goodsViceType;

/// 订单条目ID
@property (nonatomic , assign) NSInteger              id;

/// 订单条目优惠总金额
@property (nonatomic , assign) NSInteger              itemDiscountAmount;

/// 订单条目实际支付金额
@property (nonatomic , assign) NSInteger              itemPaymentAmount;

/// 订单条目总金额，SKU数*单价
@property (nonatomic , assign) NSInteger              itemTotalAmount;

/// 订单号
@property (nonatomic , copy) NSString              * orderNo;

/// 商品原价，单位分
@property (nonatomic , assign) NSInteger              originPrice;

/// 外部商品ID
@property (nonatomic , copy) NSString              * outCode;

/// 商品SKU
@property (nonatomic , assign) NSInteger              skuId;

/// 规格名称列表
@property (nonatomic , strong) NSArray <HHSpecificationsItem *>              * specifications;

/// 商品SPU
@property (nonatomic , assign) NSNumber *              spuId;

@property (nonatomic, assign) NSInteger               rightStatus;

@end


/// ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

@interface HHOderPaymentVO :BaseModel

/// 金额
@property (nonatomic , assign) NSInteger              amount;

/// 第三方交易通道流水号
@property (nonatomic , copy) NSString              * channelTrxNo;

/// 币种
@property (nonatomic , copy) NSString              * currency;

/// 通道id
@property (nonatomic , copy) NSString              * interactId;

/// 支付状态
@property (nonatomic , assign) NSInteger              payStatus;

/// 支付成功时间
@property (nonatomic , copy) NSString              * paySuccessTime;

/// 支付时间
@property (nonatomic , copy) NSString              * payTime;

/// 支付类型
@property (nonatomic , assign) NSInteger              payType;

/// 支付方式
@property (nonatomic , assign) NSInteger              payWay;

/// 支付方式名称
@property (nonatomic , copy) NSString              * payWayName;

/// 支付期数
@property (nonatomic , assign) NSInteger              period;

/// 交易流水号
@property (nonatomic , copy) NSString              * traceNo;

@end

@interface SCOrderPresellVO : BaseModel
//发货时间类型preSellTimeType为1时,就取preSellDeliveryStartTime时间戳对应的时间,preSellTimeType为2时,就是preSellEffectDeliveryDay支付后 X 天内发货
@property (nonatomic , assign) NSInteger              preSellTimeType;
@property (nonatomic , assign) NSInteger              preSellDeliveryStartTime;
@property (nonatomic , assign) NSInteger              preSellEffectDeliveryDay;
@end

@interface HHOrdersModel: BaseModel

/// 来源 1-京东  0 - 系统产生
@property (nonatomic , assign) NSInteger              dataSource;
///是否更新过订购人信息
@property (nonatomic , assign) BOOL              hasUpdateBuyerInfo;
///是否可以更新订购人信息
@property (nonatomic , assign) BOOL              canUpdateBuyerInfo;
/// 是否可申请售后 是 true 否false
@property (nonatomic , assign) BOOL              canApplyRights;
/// 取消申请状态 0未申请, 1已申请
@property (nonatomic , assign) NSInteger              cancelApplyStatus;
//是否可以开发票
@property (nonatomic , assign) BOOL              canApplyInvoice;

/// 样式类型  1:配送, 2:全球购, 3:自提, 4:虚拟订单
@property (nonatomic , assign) NSInteger              styleType;
/// 40, "普通会员购卡" 45, "普通会员续费" 50, "普通会员升级" 55, "卓越会员购卡" 60, "卓越会员续费"
@property (nonatomic , assign) NSInteger              orderSubType;

/// 获取订单支付类型 支付方式需要该参数
@property (nonatomic , copy) NSString              * payOrderType;

/// 超时关闭时间
@property (nonatomic , assign) NSInteger              autoCancelTime;

/// 取消的具体原因
@property (nonatomic , copy) NSString              * cancelReason;

/// 取消类型ID，配置中心的配置关联，该字段为商家提供，为可选择取消原因列表
@property (nonatomic , assign) NSInteger              cancelReasonType;

/// 取消类型,用户、客服、商家
@property (nonatomic , assign) NSInteger              cancelType;

/// 渠道标识
@property (nonatomic , copy) NSString              * channelIdentity;

/// 渠道来源
@property (nonatomic , copy) NSString              * channelSource;

/// 渠道类型
@property (nonatomic , assign) NSInteger              channelType;

/// 优惠券金额
@property (nonatomic , assign) NSInteger              couponAmount;

/// 创建时间
@property (nonatomic , assign) NSInteger              createTime;

/// 总优惠金额
@property (nonatomic , assign) NSInteger              discountAmount;

/// 运费
@property (nonatomic , assign) NSInteger              freightFee;

/// 商品总金额
@property (nonatomic , assign) NSInteger              goodsAmount;

/// 发票文案描述
@property (nonatomic , copy) NSString              * invoiceDesc;

//发票状态：0不需要发票 1查看发票 2补开发票 3已选-公司 4已选-个人
@property (nonatomic , assign) NSInteger              invoiceStatus;

/// 发票查询URL
@property (nonatomic , copy) NSString              * invoiceUrl;

///// 发票信息
//@property (nonatomic , strong) SCInvoiceVO              * invoiceVO;
//
///// 物流日志
//@property (nonatomic , strong) NSArray<SCLogisticsNodesItem>             * logisticsLogVOS;
//
///// 物流信息
//@property (nonatomic , strong) SCLogisticsVO              * logisticsVO;
//
///// 订单条目（商品）
@property (nonatomic , strong) NSArray <HHOrderItemVOsItem *>              * orderItemVOs;

/// 订单号
@property (nonatomic , copy) NSString              * orderNo;

/// 订单状态备注
@property (nonatomic , copy) NSString              * orderSatusRemark;

/// 订单状态
@property (nonatomic , assign) NSInteger              orderStatus;

/// 订单状态名称
@property (nonatomic , copy) NSString              * orderStatusName;

/// 订单类型
@property (nonatomic , assign) NSInteger              orderType;

/// 包装费
@property (nonatomic , assign) NSInteger              packageFee;

/// 支付金额
@property (nonatomic , assign) NSInteger              paymentAmount;

///// 支付记录
//@property (nonatomic , strong) SCOderPaymentVO              * paymentVO;
//
///// 预售信息 发货时间类型preSellTimeType为1时,就取preSellDeliveryStartTime时间戳对应的时间,preSellTimeType为2时,就是preSellEffectDeliveryDay支付后 X 天内发货
//@property (nonatomic , strong) SCOrderPresellVO              * preSellVO;

/// 订单备注
@property (nonatomic , copy) NSString              * remark;

/// 售后类型
@property (nonatomic , assign) NSInteger              rightsType;

/// 商户ID
@property (nonatomic , assign) NSInteger              saasId;

/// 门店ID
@property (nonatomic , assign) NSInteger              storeId;

/// 门店名称
@property (nonatomic , copy) NSString              * storeName;

/// 订单总金额
@property (nonatomic , assign) NSInteger              totalAmount;

/// 用户ID
@property (nonatomic , copy) NSString              * uid;

//全球购订购人姓名
@property (nonatomic , copy) NSString              * buyerName;

@property (nonatomic , copy) NSString              * tmpBuyerName;
//全球购订购人身份证
@property (nonatomic , copy) NSString              * buyerId;

@property (nonatomic , copy) NSString              * tmpBuyerId;
//订单状态描述
@property (nonatomic , copy) NSString              * orderStatusDescribe;

@property (nonatomic , assign) BOOL                  isComment;
@property (nonatomic , assign) BOOL                  hasAgainComment;

//@property (nonatomic , strong) SCPayeeInfoVO * payeeInfoVO;


@property (nonatomic , assign) NSInteger declarationStatus;

@property (nonatomic , copy) NSString  * createTimeForShow;

///优惠券文案
@property (nonatomic , copy) NSString  * deliveryCouponFeeStr;

///配送说明
@property (nonatomic , copy) NSString  * deliveryDesc;

@property (nonatomic , assign) BOOL                 invoiceApplyTimeout;
@property (nonatomic , assign) BOOL                 canApplyCancel;

/// 支付时间
@property (nonatomic , assign) NSInteger               payTime;


@end




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



@property (nonatomic , assign) NSInteger              pageNum;
@property (nonatomic , assign) NSInteger              pageSize;
@property (nonatomic , assign) NSInteger              totalCount;

@property (nonatomic, copy) NSArray<HHOrdersModel *> * orders;



@end



NS_ASSUME_NONNULL_END
