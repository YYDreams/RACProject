//
//  BaseModel.h
//  QF
//
//  Created by yuki on 2019/8/5.
//  Copyright © 2019 flowerflower. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseModel : NSObject
@property(nonatomic,copy) NSString *ID;  //











+ (instancetype)objectWithDic:(NSDictionary*)dic;

+ (NSMutableArray*)objectsInArray:(id)array;


@end


@interface NetworDataModel: BaseModel

@property(nonatomic,assign) NSInteger pageNum;

@property(nonatomic,assign) NSInteger pageSize;

@property(nonatomic,assign) NSInteger totalCount;


@end

@interface NetworkResult : BaseModel


@property(nonatomic,strong) NetworDataModel *data;


@property(nonatomic,copy) NSString *code;

@property(nonatomic,copy) NSString *msg;

@property(nonatomic,copy) NSString *traceId;

@property(nonatomic,copy) NSString *requestId;

@property(nonatomic,copy) NSString *clientIp;

@property(nonatomic,assign) NSInteger rt;

@property(nonatomic,assign) BOOL success;


@end






NS_ASSUME_NONNULL_END
