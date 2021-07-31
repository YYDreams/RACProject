//
//  NSString+GoodsString.h
//  RACProject
//
//  Created by flowerflower on 2021/7/31.
//  Copyright © 2021 flowerflower. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,HHPriceStyle) { //价格显示样式
    HHPriceStyleGoodsList = 0, //商品列表大于1万则不显示小数点 且显示千位符 (eg:64410.4 实际显示64,410)
    HHPriceStyleReal = 1, //显示实际具体价格（eg:商品详情、购物车列表）且显示千位符 (eg:64410.4 实际显示64,410.4)
    HHPriceStyleDecimal = 2, //保留2位 且显示千位符
    
};

@interface NSString (GoodsString)

+ (NSString *)removeFloatAllZero:(NSString *)string style:(HHPriceStyle)style;


- (NSAttributedString *)rmbWithColor:(UIColor *)color unitFont:(UIFont *)unitFont priceFont:(UIFont *)priceFont pointSameWithUnit:(BOOL)isSameWithUnit unitString:(NSString *)unitString;
@end

NS_ASSUME_NONNULL_END
