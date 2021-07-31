//
//  BaseTableViewController.m
//  QF
//
//  Created by yuki on 2019/8/5.
//  Copyright © 2019 flowerflower. All rights reserved.
//

#import "BaseTableViewController.h"
#import "UIScrollView+EmptyDataSet.h"
@interface BaseTableViewController ()
@property (nonatomic, weak)UITableView * targetTableView;
@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (instancetype)init{
    
    if (self = [super init]) {
        
        _tableViewStyle = UITableViewStyleGrouped;
    }
    return self;
}

- (void)setTableViewStyle:(UITableViewStyle)tableViewStyle{

    _tableViewStyle = tableViewStyle;
    
}


-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.tableViewStyle];
        _tableView.backgroundColor = kBgColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = kSeparatedLineColor;
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.1)];
        
#ifdef __IPHONE_11_0
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
            if ([self respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
                if (@available(iOS 11.0, *)) {
                    _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
                } else {
                    // Fallback on earlier versions
                }
            }
        #endif
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        self.succeedEmptyStr = @"";
        
        self.succeedEmptyImage = [UIImage imageNamed:@"not_data"];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(self.view);
            
            if (@available (iOS 11.0, *)) {
                make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            }else{
                make.bottom.equalTo(self.view);

            }
        }];
    }
    
    return _tableView;
}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}



- (void)showNetworkErrorView{
    self.currentPageStatus = PageStatusError;
    
    
}

- (void)hideNetworkErrorView{
    self.currentPageStatus = PageStatusError;
}

- (void)showNoDataView{
    
    [self showNoDataText:nil imageStr:nil];
}

- (void)hideNoDataView{
    self.currentPageStatus = PageStatusSucceed;
    self.succeedEmptyStr = @"";
    self.succeedEmptyImage = [UIImage imageNamed:@""];
}

- (void)showNoDataText:(NSString  * _Nullable)text{
    
    [self showNoDataText:text imageStr:nil];
}
- (void)showNoDataImageStr:(NSString  *_Nullable)imageStr{
    
    [self showNoDataText:nil imageStr:imageStr];
}

- (void)showNoDataText:(NSString  * _Nullable)text imageStr:(NSString  *_Nullable)imageStr{
    self.currentPageStatus = PageStatusSucceed;
    self.succeedEmptyStr = text.length > 0 ? text :@"暂无数据";
    self.succeedEmptyImage = [UIImage imageNamed:imageStr.length > 0 ? imageStr : @"mine_background"];
    [self.tableView reloadEmptyDataSet];
}

- (void)showLoadingView{
    
}

- (void)hideLoadingView{
    
}

- (void)showToast:(NSString *)text{
    
    if (!text.length) {return;}
    
    
}

@end


