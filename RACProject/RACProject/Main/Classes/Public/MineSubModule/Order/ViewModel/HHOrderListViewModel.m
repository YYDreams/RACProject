//
//  HHOrderListViewModel.m
//  RACProject
//
//  Created by flowerflower on 2020/4/25.
//  Copyright © 2020 flowerflower. All rights reserved.
//

#import "HHOrderListViewModel.h"
#import "RACProjectApi.h"

@interface HHOrderListCellViewModel()


@property (nonatomic, readwrite, copy) NSString * orderId;
@property (nonatomic, readwrite, copy) NSString * orderNo;
@property (nonatomic, readwrite, copy) NSString * orderStatusText;
@property (nonatomic, readwrite, copy) UIColor * orderStatusColor;

@property (nonatomic, readwrite, copy) NSString * orderDate;

@property (nonatomic, readwrite, copy) NSString * button1Title;
@property (nonatomic, readwrite, copy) NSString * button2Title;

@property (nonatomic, readwrite, copy) UIColor * button1Color;

@property (nonatomic, readwrite, copy) UIColor * button2Color;

@property (nonatomic, readwrite, assign) BOOL button1Hidden;
@property (nonatomic, readwrite, assign) BOOL button2Hidden;

@property (nonatomic, readwrite, copy) NSString * singleGoodsImage;
@property (nonatomic, readwrite, copy) NSString * singleGoodsName;
@property (nonatomic, readwrite, copy) NSString * goodsNum;
@property (nonatomic, readwrite, copy) NSAttributedString * goodsPices;
@property (nonatomic, readwrite, copy) NSArray<NSString *>  * goodsImages;

@property (nonatomic, readwrite, assign) BOOL isSingleGoods;

@property (nonatomic, strong) HHOrdersModel * model;

@end
@implementation HHOrderListCellViewModel

- (instancetype)initWithModel:(HHOrdersModel *)model{
    
    if (self = [super init]) {
        
        self.model  = model;
        [self bindModel];
    }
    return self;
    
    
}
- (void)bindModel{
    
    RAC(self,orderNo) = [RACObserve(self.model, orderNo)map:^id _Nullable(id  _Nullable value) {
        return [NSString stringWithFormat:@"订单号：%@",value];
        
    }];
    
    RAC(self,orderStatusText) = RACObserve(self.model, orderStatusName);
    
    RAC(self, orderTime) = [RACObserve(self.model , createTime) map:^id _Nullable(id  _Nullable value) {
        NSDate * date = [NSDate dateWithTimeIntervalSince1970:[value integerValue] / 1000];
        NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        return [NSString stringWithFormat:@"下单时间：%@",[dateFormat stringFromDate:date]];
    }];
    
    
    //   orderStatus 订单状态 5: 待支付 10: 待发货 40：待收货 43：待取货 60：已完成 80：已取消
    
    @weakify(self);
    [RACObserve(self.model, orderStatus) subscribeNext:^(id  _Nullable x) {
        self.orderStatusColor = [UIColor colorWithHex:0x4F5356];
        
        switch ([x integerValue]) {
            case 5:{ // 取消 and 去付款
                
                self.button1Title = HHLocalizedString(@"取消订单");
                self.button2Title = HHLocalizedString(@"去付款");
                self.button1Color = k9Color;
                self.button2Color = kThemeColor;
                
                self.button1Hidden = NO;
                self.button2Hidden = NO;
            }
                break;
            case 10:
            case 2:
                break;
            default:
                break;
        }
        
    }];
    
    
    [RACObserve(self.model, orderItemVOs) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.isSingleGoods = self.model.orderItemVOs.count == 1;
        __block NSInteger number = 0;
        if (self.model.orderItemVOs.count > 1) {
            NSMutableArray * temp = @[].mutableCopy;
            NSMutableArray * tempSpuIdList = @[].mutableCopy;
            [self.model.orderItemVOs enumerateObjectsUsingBlock:^(HHOrderItemVOsItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [temp addObject:obj.goodsPictureUrl];
                [tempSpuIdList addObject:obj.spuId];
                number += obj.buyQuantity;

                //赠品数组
                [obj.giftProducts enumerateObjectsUsingBlock:^(HHGiftProducts *  _Nonnull obj1, NSUInteger idx, BOOL * _Nonnull stop) {
                    number += obj1.quantity;
                }];
                //延保数组
                [obj.warrantyExtensionList enumerateObjectsUsingBlock:^(HHWarrantyExtensionList *  _Nonnull obj2, NSUInteger idx, BOOL * _Nonnull stop) {
                    number += obj2.warrantyExtensionNum;
                }];
            }];
            self.goodsImages = temp.copy;
        }else{
            HHOrderItemVOsItem * singleModel = [self.model.orderItemVOs firstObject];
            RAC(self, singleGoodsName) = RACObserve(singleModel, goodsName);
            RAC(self, singleGoodsImage) = RACObserve(singleModel, goodsPictureUrl);
            number += singleModel.buyQuantity;
        }
        
        self.goodsNum = [NSString stringWithFormat:@"x%ld",(long)number];
        
        self.goodsPices = [[NSString removeFloatAllZero:@(self.model.paymentAmount).stringValue style:HHPriceStyleDecimal] rmbWithColor:[UIColor colorWithHex:0x222427]
                                                                           unitFont:[UIFont systemFontOfSize:13.f weight:UIFontWeightMedium]
                                                                          priceFont:[UIFont systemFontOfSize:16.f weight:UIFontWeightMedium]
                                                                  pointSameWithUnit:NO
                                                                         unitString:@""];;
        
    }];
    
    
    
}

@end



@interface HHOrderListViewModel()

@property(nonatomic ,readwrite , copy)NSArray <HHOrderListCellViewModel *> * orderArray;

@property(nonatomic ,assign)NSInteger orderStatus;

@property(nonatomic ,assign)NSInteger page;

@property(nonatomic ,readwrite, assign)BOOL isLastPage;


@property(nonatomic ,assign) BOOL isFirstLoading;

@property(nonatomic ,assign) BOOL isRefreshing;

@property(nonatomic, strong)NSArray <HHOrderListModel  *>*dataListArray;


@property (nonatomic, copy) NSArray<HHOrdersModel *> * models;


@end

@implementation HHOrderListViewModel

- (instancetype)initWithoOderStatus:(NSInteger)orderStatus{
    
    if (self  = [super init]) {
        self.orderStatus = orderStatus;
        self.page = 1;
        self.isRefreshing = NO;
        [self bindModel];
        
        
    }
    return self;
    
}

- (void)bindModel{
    
    @weakify(self);
    
    [[RACObserve(self, orderStatus) skip:1] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self requsetForOrderListData];
    }];
    
    
    [RACObserve(self, models) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self reformData];
    }];
    
    
    
}
- (void)reformData{
    
    NSMutableArray *temp = @[].mutableCopy;
    [self.models enumerateObjectsUsingBlock:^(HHOrdersModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HHOrderListCellViewModel *model = [[HHOrderListCellViewModel alloc]initWithModel:obj];
        [temp addObject:model];
        
    }];
    self.orderArray = temp.copy;
    
}
- (void)requsetForOrderListData{
    
    if (!self.isRefreshing) {
        [self.loadingSubject sendNext:@(YES)];
        
    }
    @weakify(self);
    [RACProjectApi getOderListModelsWithOrderStatus:self.orderStatus pageNum:_page orderScense:0 completion:^(NetworkStatus status, NSString * _Nullable errorStr, HHOrderListModel * _Nullable model) {
        @strongify(self);
        NSMutableArray * temp =  self.models.mutableCopy ;
        switch (status) {
            case NetworkStatusSuccess:
                if (self.page == 1) {
                    temp = model.orders.mutableCopy;
                }else{
                    [temp addObjectsFromArray:model.orders.copy];
                }
                self.models = temp.copy;
                self.page = model.pageNum + 1;
                self.isLastPage = model.totalCount == self.models.count;
                [self.noDataSubject sendNext:(model.orders.count <= 0)? @(YES):@(NO)];
                break;
            case NetworkStatusFailed:
                [self.totastSubject sendNext:errorStr];
                break;
            case NetworkStatusError:
                [self.connectingSubject sendNext:@(YES)];
                break;
            case NetworkStatusNonet:
                [self.networkErrorSubject sendNext:@(YES)];
                break;
            default:
                break;
        }
        if (!self.isRefreshing) {
            [self.loadingSubject sendNext:@(NO)];
        }
    }];
}

- (void)refresh{
    self.page = 1;
    self.isRefreshing = YES;
    [self requsetForOrderListData];
}

- (void)loadMore{
    self.isRefreshing = YES;
    [self requsetForOrderListData];
    
    
}
#pragma mark - getter

- (NSArray<HHOrdersModel *> *)models{
    if (!_models) {
        _models = @[];
    }
    return _models;
}

@end
