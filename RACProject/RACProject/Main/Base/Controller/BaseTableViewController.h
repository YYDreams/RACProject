//
//  BaseTableViewController.h
//  QF
//
//  Created by yuki on 2019/8/5.
//  Copyright © 2019 flowerflower. All rights reserved.
//

#import "BaseUIViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewController : BaseUIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,assign)UITableViewStyle  tableViewStyle;

@end

NS_ASSUME_NONNULL_END


