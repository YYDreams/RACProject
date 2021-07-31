//
//  Foundation+SCCategory.h
//  SamClub
//
//  Created by zoyagzhou on 2019/12/19.
//  Copyright © 2019 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<ObjectType> (SCCategory)

- (id)safeObjectAtIndex:(NSUInteger)index;

@end




@interface NSDictionary(SCCategory)
// 读取本地JSON文件
+ (NSDictionary *)readLocalFileWithName:(NSString *)name;

@end



NS_ASSUME_NONNULL_END
