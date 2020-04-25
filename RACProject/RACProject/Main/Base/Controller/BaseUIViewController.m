//
//  BaseUIViewController.m
//  QF
//
//  Created by yuki on 2019/8/5.
//  Copyright © 2019 flowerflower. All rights reserved.
//

#import "BaseUIViewController.h"

@interface BaseUIViewController ()

@end

@implementation BaseUIViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBgColor;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //隐藏导航栏
    if (self.isHiddenNavBar==YES){
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //显示导航栏
    if (self.isHiddenNavBar==YES){
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }
}

#pragma mark - loadData
//加载网络数据 子类需要重写
- (void)loadDataFromNetwork{
    
}

#pragma mark - setupUI
//子类重写 自定义导航栏
- (void)setupNav{
    
}

//子类重写
- (void)setupSubView{
    
}

//网络从无网状态变为有网状态回调这个方法
- (void)autoDoRetryRequest{
    
}

- (void)bindViewModel{
    
}

- (void)backItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)needResetBackItem{    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateHighlighted];
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    btn.size = CGSizeMake(40, 30);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.contentMode = UIRectCornerTopLeft;
    [btn addTarget:self action:@selector(backItemClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
    NSLog(@"dealloc----- %@",NSStringFromClass([self class]));
    
}

@end
