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

NS_ASSUME_NONNULL_END
