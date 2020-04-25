//
//  BaseTabBarViewController.m
//  QF
//
//  Created by yuki on 2019/8/5.
//  Copyright © 2019 flowerflower. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "BaseNavViewController.h"
#import "BaseUIViewController.h"

@interface BaseTabBarViewController ()
@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupControllers];
    
}

- (void)setupControllers{
    
    NSArray *controllerViews = @[@"HomeViewController",@"HomeViewController",@"MineViewController"];
    //TabBar图片
    NSArray *normalImageNames = @[@"tabar_software_normal", @"tabar_choice_normal", @"tabar_personalcenter_normal"];
    //TabBar选中的图片
    NSArray *selectImageNames = @[@"tabar_software_selected", @"tabar_choice_selected", @"tabar_personalcenter_selected"];
    
    //TabBarItem标题
    NSArray *titles = @[@"首页",@"精选",@"我的"];
    
    
    for (int i = 0; i< controllerViews.count; i++){
        //1.获取类名字符串
        NSString *className= controllerViews[i];
        //2。获取类名
        Class class = NSClassFromString(className);
        //3.创建对象
        BaseUIViewController * viewController  = [[class alloc] init];
        viewController.title = titles[i];
//        viewController.tabBarItem.image = [[UIImage imageNamed:normalImageNames[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        viewController.tabBarItem.selectedImage =  [[UIImage imageNamed:selectImageNames[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        BaseNavViewController *Nav = [[BaseNavViewController alloc]initWithRootViewController:viewController];
        self.tabBar.tintColor = kThemeColor;
       [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
         Nav.navigationBar.translucent = NO;
        [self addChildViewController:Nav];
        
    }
    //默认选中第一个
    self.selectedIndex = 2;
    
}


@end
