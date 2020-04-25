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
@property (nonatomic, readwrite, copy) NSString * orderStatusColor;

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
@property (nonatomic, readwrite, copy) NSString * goodsPices;
@property (nonatomic, readwrite, copy) NSArray<NSString *>  * goodsImages;

@property (nonatomic, readwrite, assign) BOOL isSingleGoods;

@property (nonatomic, strong) HHOrderListModel * model;

@end
@implementation HHOrderListCellViewModel

- (instancetype)initWithModel:(HHOrderListModel *)model{
    
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
    RAC(self,orderStatusText) = RACObserve(self.model, statusText);
    RAC(self,orderTime) = RACObserve(self.model, deliveryTimeEnd);
    //订单状态 0：未付款 1：已付款 2：分拣中 3:配送中 4：已配送 5：已签收 6：退货早请 7：退货中 8：已退货 9：已退货入库 * 10：取消交易

       //  1待付款  0未付款
       //  2待发货 1：已付款 2：分拣中
       //  3待收货  3:配送中 4：已配送
      //   4已完成   5,6,7,8,9,11,12   评价 再次购买
    
    @weakify(self);
    [RACObserve(self.model, orderStatus) subscribeNext:^(id  _Nullable x) {
      
        switch ([x integerValue]) {
            case 0:{ // 取消 and 去付款
                
                self.button1Title = HHLocalizedString(@"取消订单");
                self.button2Title = HHLocalizedString(@"去付款");
                self.button1Color = k9Color;
                self.button2Color = kThemeColor;
                
                self.button1Hidden = NO;
                self.button2Hidden = NO;
            }
                break;
            case 1:
            case 2:
            case 7:{ //
                
                self.button1Hidden = YES;
                self.button2Hidden = YES;
                       }
                           break;
                case 5:
                case 6:
                case 8:
                case 9:
                case 11:
                case 12:{
                             self.button1Hidden = NO;
                             self.button2Hidden = NO;
                             self.button1Title = HHLocalizedString(@"评价");
                            self.button2Title = HHLocalizedString(@"再次购买");
                    self.button1Color = kThemeColor;
                         self.button2Color = kThemeColor;
            }
                break;
            case 10:{
                self.button1Hidden = YES;
                self.button2Hidden = NO;
                self.button2Color = kThemeColor;
                self.button2Title = HHLocalizedString(@"再次购买");
            }
            default:
                break;
        }
        
    }];
    
    [RACObserve(self.model, orderItems) subscribeNext:^(id  _Nullable x) {
       @strongify(self);
        self.isSingleGoods = self.model.orderItems.count == 1;
      
        if (self.model.orderItems.count >1) {
            NSMutableArray *temp = @[].mutableCopy;
            [self.model.orderItems enumerateObjectsUsingBlock:^(OrderItemsItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [temp addObject:obj.image];
            }];
            self.goodsImages = temp.copy;
            
        }else{
            
            OrderItemsItem *signleModel = [self.model.orderItems firstObject];
            RAC(self,singleGoodsName) = RACObserve(signleModel, name);
            RAC(self,singleGoodsImage) = RACObserve(signleModel, image);
            
            
        }
        
    }];
    RAC(self,goodsNum) = RACObserve(self.model, totalCount);
    self.goodsPices = [NSString stringWithFormat:@"%@",self.model.priceArea.payPriceText];
           
//    RAC(self,oderStatusText) = [RACObserve(self.model., )]
    
    
    
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


@end

@implementation HHOrderListViewModel

- (instancetype)initWithoOderStatus:(NSInteger)orderStatus{
    
    if (self  = [super init]) {
        
        _orderStatus = orderStatus;
        self.page = 1;
        self.isRefreshing = NO;
        self.isFirstLoading = YES;
        [self bindModel];
        
        
        
    }
    return self;
    
}

- (void)bindModel{
    
    @weakify(self);
    [RACObserve(self, orderStatus) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self requsetForOrderListData];
        
    }];
    
    [RACObserve(self, dataListArray) subscribeNext:^(id  _Nullable x) {
       @strongify(self);

        [self reformData];
    }];
    
    
    
}
- (void)reformData{
    
    NSMutableArray *temp = @[].mutableCopy;
    [self.dataListArray enumerateObjectsUsingBlock:^(HHOrderListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HHOrderListCellViewModel *model = [[HHOrderListCellViewModel alloc]initWithModel:obj];
        [temp addObject:model];
        
    }];
    self.orderArray = temp.copy;
    
    
    
}
- (void)requsetForOrderListData{
    
    if (!self.isRefreshing) {
        
        [self.loadingSubject sendNext:@(YES)];
        
    }
    [RACProjectApi requestForOrderListSimulationWithCompletion:^(NetworkStatus status, NSArray * _Nonnull listArr, NSDictionary * _Nonnull pageInfo) {
       
        
        NSMutableArray *tempArr= listArr.mutableCopy;
        if (status == NetworkStatusSuccess) {

            if (self.page == 1) {
                tempArr =  listArr.mutableCopy;

                if (tempArr.count) {
                    [self.noDataSubject  sendNext:@(NO)];
                }else{
                    [self.noDataSubject sendNext:@(YES)];
                }


            }else{
                [tempArr addObjectsFromArray:listArr];
            }
            
            self.dataListArray = tempArr;
//            self.page = [pageInfo[@"total"] integerValue];
//               self.isLastPage = [pageInfo[@"isLastPage"] boolValue];

        }else if( status == NetworkStatusFailed){

            [self.networkErrorSubject sendNext:@(YES)];
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

//- (NSArray<HHOrderListModel *> *)dataListArray{
//    if (!_dataListArray) {
//        _dataListArray = @[];
//    }
//    return _models;
//}
@end
