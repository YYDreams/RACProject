//
//  LoginViewModel.h
//  RACProject
//
//  Created by flowerflower on 2020/4/24.
//  Copyright © 2020 flowerflower. All rights reserved.
//

#import "BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : BaseViewModel

@property (nonatomic , readonly, copy) NSString * account;
@property (nonatomic , readonly, copy) NSString * password;
@property (nonatomic , strong) RACSignal *loginBtnEnableSignal;

@end

NS_ASSUME_NONNULL_END
