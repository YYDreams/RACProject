//
//  NSString+GoodsString.m
//  RACProject
//
//  Created by flowerflower on 2021/7/31.
//  Copyright © 2021 flowerflower. All rights reserved.
//

#import "NSString+GoodsString.h"

@implementation NSString (GoodsString)


// 去掉价格后面多余的0
+ (NSString *)removeFloatAllZero:(NSString *)string style:(HHPriceStyle)style {
    NSString * testNumber = string;
    NSString * outNumber;
    if (style == HHPriceStyleGoodsList) {
        if (testNumber.intValue/100>=10000) {
            outNumber = [NSString stringWithFormat:@"%@",@(testNumber.intValue/100)];
        }else{
            outNumber = [NSString stringWithFormat:@"%@",@(testNumber.floatValue/100.0)];
        }
    }else if(style == HHPriceStyleReal){
        outNumber = [NSString stringWithFormat:@"%@",@(testNumber.floatValue/100.0)];
    }else if (style == HHPriceStyleDecimal){
        outNumber =  [NSString stringWithFormat:@"%.2lf",[testNumber integerValue] / 100.f];
    }
    //价格格式化显示
    //结算页、订单相关（订单、订单详情）的价。都按两位小数
    //商品列表和组件按照价格规则显示
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc]init];
    if (style == HHPriceStyleDecimal) {
        formatter.positiveFormat = @"###,##0.00";
        NSString *price = [formatter  stringFromNumber:@(outNumber.floatValue)];
        return price;
    }
    formatter.maximumFractionDigits = 2;
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    NSString * formatterString = [formatter stringFromNumber:[NSNumber numberWithFloat:[outNumber doubleValue]]];
   //获取要截取的字符串位置
    NSRange range = [formatterString rangeOfString:@"."];
    if (range.length >0 ) {
        NSString * result = [formatterString substringFromIndex:range.location];
        if (result.length >= 4) {
            formatterString = [formatterString substringToIndex:formatterString.length - 1];
        }
    }
    return formatterString;
}

- (NSAttributedString *)rmbWithColor:(UIColor *)color unitFont:(UIFont *)unitFont priceFont:(UIFont *)priceFont pointSameWithUnit:(BOOL)isSameWithUnit unitString:(NSString *)unitString{
    NSString * unit = unitString.length ? unitString : @"￥";
    NSString * price = [self containsString:unit] ? [self stringByReplacingOccurrencesOfString:unit withString:unit] : self;
    NSMutableAttributedString * aprice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",unit,price]];
    [aprice addAttributes:@{NSFontAttributeName : unitFont} range:NSMakeRange(0, unit.length)];
    if (isSameWithUnit && [self containsString:@"."]) {
        NSRange pointRange = [self rangeOfString:@"."];
        NSRange integerRange = NSMakeRange(unit.length, pointRange.location - 1);
        NSRange decimalsRange = NSMakeRange(pointRange.location + 1, aprice.length - (pointRange.location + 1));
        [aprice addAttributes:@{NSFontAttributeName : priceFont} range:integerRange];
        [aprice addAttributes:@{NSFontAttributeName : unitFont} range:decimalsRange];
    }else{
        [aprice addAttributes:@{NSFontAttributeName : priceFont} range:NSMakeRange(unit.length, price.length)];
    }
    [aprice addAttributes:@{NSForegroundColorAttributeName: color} range:NSMakeRange(0, aprice.length)];
    return aprice;
}


@end
