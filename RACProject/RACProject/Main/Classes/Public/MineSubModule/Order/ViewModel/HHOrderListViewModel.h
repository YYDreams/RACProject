//
//  HHOrderListViewModel.h
//  RACProject
//
//  Created by flowerflower on 2020/4/25.
//  Copyright © 2020 flowerflower. All rights reserved.
//

#import "BaseViewModel.h"
#import "HHOrderListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HHOrderListCellViewModel : BaseViewModel

// 订单号
@property (nonatomic, readonly, copy) NSString * orderNo;
// 订单状态
@property (nonatomic, readonly, copy) NSString * orderStatusText;
// 订单状态样色
@property (nonatomic, readonly, copy) UIColor * orderStatusColor;
//下单时间
@property (nonatomic, readonly, copy) NSString * orderTime;

@property (nonatomic, readonly, copy) NSString * button1Title;
@property (nonatomic, readonly, copy) NSString * button2Title;

@property (nonatomic, readonly, copy) UIColor * button1Color;
@property (nonatomic, readonly, copy) UIColor * button2Color;


@property (nonatomic, readonly, assign) BOOL button1Hidden;
@property (nonatomic, readonly, assign) BOOL button2Hidden;

@property (nonatomic, readonly, copy) NSString * singleGoodsImage;
@property (nonatomic, readonly, copy) NSString * singleGoodsName;
@property (nonatomic, readonly, copy) NSString * goodsNum;
@property (nonatomic, readonly, copy) NSAttributedString * goodsPices;
@property (nonatomic, readonly, copy) NSArray<NSString *> * goodsImages;

@property (nonatomic, readonly, assign) BOOL isSingleGoods;

@end
@interface HHOrderListViewModel : BaseViewModel

@property(nonatomic ,readonly , copy)NSArray <HHOrderListCellViewModel *> * orderArray;

@property(nonatomic ,readonly, assign)BOOL isLastPage;

- (instancetype)initWithoOderStatus:(NSInteger)orderStatus;

- (void)refresh;

- (void)loadMore;


@end

NS_ASSUME_NONNULL_END
