//
//  MineViewController.m
//  RACProject
//
//  Created by flowerflower on 2020/4/23.
//  Copyright © 2020 flowerflower. All rights reserved.
//

#import "MineViewController.h"
#import "MineOrderView.h"
#import "HHMyOrderController.h"
@interface MineViewController ()

@property(nonatomic ,strong)MineOrderView *orderView;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.tableHeaderView = self.orderView;
    self.tableView.tableHeaderView.height  = SC_DP_375(130);
}
- (MineOrderView *)orderView{
    if (!_orderView) {
        _orderView = [[MineOrderView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width,  SC_DP_375(130))];
        [_orderView setHandlerOrderBtnBlock:^(NSInteger index) {
            HHMyOrderController *vc = [[HHMyOrderController alloc]init];
            vc.selectIndex  = index;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
    }
    return _orderView;
    
}





@end
