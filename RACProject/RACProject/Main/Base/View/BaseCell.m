//
//  BaseCell.m
//  QF
//
//  Created by yuki on 2019/8/5.
//  Copyright © 2019 flowerflower. All rights reserved.
//

#import "BaseCell.h"

@implementation BaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle =  UITableViewCellSelectionStyleNone;
    }
    
    
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle =  UITableViewCellSelectionStyleNone;

    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView cellID:(NSString *)cellID{
    //获取子类名
    NSString * className =  [NSString stringWithUTF8String:object_getClassName(self)];
    
    NSString *ID = className;
    BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    //    NSLog(@"%@----------------",className);
    
    if (cell == nil) {
        cell = [[NSClassFromString(className)  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        //        NSLog(@"++++++++++++++++++++++++");
    }
    return cell;
    
}


@end
