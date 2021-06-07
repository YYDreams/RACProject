//
//  HHHudManager.h
//  RACProject
//
//  Created by flowerflower on 2021/5/29.
//  Copyright © 2021 flowerflower. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHHudManager : NSObject

+ (void)showHudWithText:(NSString *)text;

+ (void)showHudWithText:(NSString *)text toView:(UIView * _Nullable)view;
@end

NS_ASSUME_NONNULL_END
