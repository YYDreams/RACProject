//
//  HHOrderListController.m
//  RACProject
//
//  Created by flowerflower on 2020/4/25.
//  Copyright © 2020 flowerflower. All rights reserved.
//

#import "HHOrderListController.h"
#import "HHOrderListCell.h"
#import "HHOrderListViewModel.h"
@interface HHOrderListController ()



@property(nonatomic, strong)HHOrderListViewModel *viewModel;


@end
static NSString * const HHOrderListCellID = @"HHOrderListCellID";

@implementation HHOrderListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubView];
    [self bindViewModel];
    [self.viewModel refresh];
    
}

- (void)setupSubView{
    [self.tableView registerClass:[HHOrderListCell class] forCellReuseIdentifier:HHOrderListCellID];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = SC_DP_375(200);
    
    @weakify(self);
    
    self.tableView.mj_header = [HHRefreshHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self.viewModel refresh];
    }];
    
    self.tableView.mj_footer = [HHRefreshFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self.viewModel loadMore];
    }];
    
}

- (void)bindViewModel{
    
    @weakify(self);
    [RACObserve(self.viewModel, orderArray) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
    [RACObserve(self.viewModel, isLastPage) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x boolValue]) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }];
    
    [self.viewModel.loadingSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [x boolValue] ? [self showLoadingView]: [self hideLoadingView];
    }];
    
    [self.viewModel.totastSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self showToast:x];
    }];
    
    [self.viewModel.noDataSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [x boolValue] ? [self showNoDataView] : [self hideNoDataView];
    }];
    
    [self.viewModel.networkErrorSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [x boolValue] ? [self showNetworkErrorView] : [self hideNetworkErrorView];
    }];
    
    self.emptyViewTapBlock = ^{
        @strongify(self);
        [self.viewModel refresh];
    };
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.orderArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HHOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:HHOrderListCellID];
    cell.viewModel = [self.viewModel.orderArray safeObjectAtIndex:indexPath.row];
    return cell;
}
#pragma mark - JXPagingViewListViewDelegate
- (UIView *)listView {
    return self.view;
}

- (UIScrollView *)listScrollView {
    return self.tableView;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    //    self.scrollCallback = callback;
}

- (HHOrderListViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[HHOrderListViewModel alloc]initWithoOderStatus:self.selectIndex];
    }
    return _viewModel;
    
}

@end
