//
//  HomeViewController.m
//  RACProject
//
//  Created by flowerflower on 2020/4/23.
//  Copyright © 2020 flowerflower. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor redColor];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    LoginViewController *vc = [[LoginViewController alloc]init];
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:vc animated:true completion:nil];
}


@end
