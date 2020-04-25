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

@implementation HHOrderListController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupSubView];
    [self bindViewModel];
    

    
}

- (void)setupSubView{
    [self.tableView registerClass:[HHOrderListCell class] forCellReuseIdentifier:@"UITableViewCell"];

    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = SC_DP_375(200);
    
}

- (void)bindViewModel{

    @weakify(self);
    [RACObserve(self.viewModel, orderArray) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        
        [self.tableView reloadData];
    }];
    
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.orderArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HHOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.viewModel = self.viewModel.orderArray[indexPath.row];
    
//    cell.textLabel.text = @"2";
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

- (void)listWillAppear {
    NSLog(@"%@:%@", self.title, NSStringFromSelector(_cmd));
}

- (void)listDidAppear {
    NSLog(@"%@:%@", self.title, NSStringFromSelector(_cmd));
}

- (void)listWillDisappear {
    NSLog(@"%@:%@", self.title, NSStringFromSelector(_cmd));
}

- (void)listDidDisappear {
    NSLog(@"%@:%@", self.title, NSStringFromSelector(_cmd));
}


- (HHOrderListViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[HHOrderListViewModel alloc]initWithoOderStatus:self.selectIndex];
    }
    return _viewModel;
    
}

@end
