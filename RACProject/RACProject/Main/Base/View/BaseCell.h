//
//  BaseCell.h
//  QF
//
//  Created by yuki on 2019/8/5.
//  Copyright © 2019 flowerflower. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView cellID:(NSString *)cellID;

@end

NS_ASSUME_NONNULL_END
