//
//  HHMyOrderController.m
//  RACProject
//
//  Created by flowerflower on 2020/4/25.
//  Copyright © 2020 flowerflower. All rights reserved.
//

#import "HHMyOrderController.h"
#import "HHOrderCategoryController.h"
@interface HHMyOrderController ()

@property (nonatomic, strong) HHOrderCategoryController * categoryVC;

@end

@implementation HHMyOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    
}
- (void)setupView{

        [self addchildVC:self.categoryVC];
        [self.categoryVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    
}

- (void)addchildVC:(UIViewController *)vc{
    [self.view addSubview:vc.view];
    [self addChildViewController:vc];
    [vc endAppearanceTransition];
    [vc didMoveToParentViewController:self];
}
- (HHOrderCategoryController *)categoryVC{
    if (!_categoryVC) {
        _categoryVC = [[HHOrderCategoryController alloc] initWithSelectedIndex:self.selectIndex];
    }
    return _categoryVC;
}

@end
