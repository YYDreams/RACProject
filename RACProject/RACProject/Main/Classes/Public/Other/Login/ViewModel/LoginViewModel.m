//
//  LoginViewModel.m
//  RACProject
//
//  Created by flowerflower on 2020/4/24.
//  Copyright © 2020 flowerflower. All rights reserved.
//

#import "LoginViewModel.h"
@interface LoginViewModel()

@property (nonatomic , readwrite, copy) NSString * account;
@property (nonatomic , readwrite, copy) NSString * password;

@end
@implementation LoginViewModel

- (instancetype)init{
    
    if ( self = [super init]) {
        [self bindModel];
    }
    return self;
    
}

- (void)bindModel{}
- (RACSignal *)loginBtnEnableSignal{
    if (!_loginBtnEnableSignal) {
        _loginBtnEnableSignal = [RACSignal combineLatest:@[RACObserve(self, account),RACObserve(self, password)] reduce:^id _Nonnull{
            return @(self.account.length && self.password.length);
        }];
    }
    return _loginBtnEnableSignal;
}

@end
