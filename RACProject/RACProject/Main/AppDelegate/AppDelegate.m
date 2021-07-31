//
//  AppDelegate.m
//  QF
//
//  Created by flowerflower on 2020/4/23.
//  Copyright © 2019 flowerflower. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarViewController.h"
#import "LoginViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [[BaseTabBarViewController alloc]init];

    
    return YES;
}



@end
