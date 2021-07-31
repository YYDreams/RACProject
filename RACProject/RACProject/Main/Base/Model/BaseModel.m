
//
//  BaseModel.m
//  QF
//
//  Created by yuki on 2019/8/5.
//  Copyright © 2019 flowerflower. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel



+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"ID":@"id"};
}

+ (instancetype)objectWithDic:(NSDictionary *)dic
{
    //容错处理
    if (![dic isKindOfClass:[NSDictionary class]]||!dic)
    {
        return nil;
    }
    
    //获取子类名
    NSString * className =  [NSString stringWithUTF8String:object_getClassName(self)];
    
    return [NSClassFromString(className) mj_objectWithKeyValues:dic];
}

+ (NSMutableArray*)objectsInArray:(id)arr
{
    //获取子类名
    NSString * className =  [NSString stringWithUTF8String:object_getClassName(self)];
    
    return [NSClassFromString(className) mj_objectArrayWithKeyValuesArray:arr];
}


@end


@implementation NetworDataModel

@end


@implementation NetworkResult

@end
