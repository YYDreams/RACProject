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


- (void)showNetworkErrorView;

- (void)hideNetworkErrorView;

- (void)showNoDataView;

- (void)hideNoDataView;

- (void)showNoDataText:(NSString  * _Nullable)text;


- (void)showNoDataImageStr:(NSString  *_Nullable)imageStr;


- (void)showNoDataText:(NSString  * _Nullable)text imageStr:(NSString  *_Nullable)imageStr;


- (void)showLoadingView;

- (void)hideLoadingView;

- (void)showToast:(NSString *)text;


@end


NS_ASSUME_NONNULL_END


