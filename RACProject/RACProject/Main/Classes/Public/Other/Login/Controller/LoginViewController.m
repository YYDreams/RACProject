//
//  LoginViewController.m
//  RACProject
//
//  Created by flowerflower on 2020/4/23.
//  Copyright © 2020 flowerflower. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"
@interface LoginViewController ()

@property(nonatomic ,strong)UITextField *accountTextFiled;

@property(nonatomic ,strong)UITextField *passwordTextField;


@property(nonatomic ,strong)UIButton *loginBtn;

@property(nonatomic ,strong)LoginViewModel *viewModel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubView];
    
    [self bindViewModel];
    
}
- (void)bindViewModel{

    RAC(self.viewModel,account) = [RACSignal merge:@[self.accountTextFiled.rac_textSignal,RACObserve(self.accountTextFiled, text)]];
    
    RAC(self.viewModel,password) = [RACSignal merge:@[self.passwordTextField.rac_textSignal,RACObserve(self.passwordTextField, text)]];
    
    RAC(self.loginBtn, enabled)  = self.viewModel.loginBtnEnableSignal;
    
    @weakify(self);
    [RACObserve(self.loginBtn, enabled) subscribeNext:^(id  _Nullable x) {
    @strongify(self);
        [self.loginBtn setBackgroundColor:[x boolValue]?kThemeColor:[UIColor colorWithHex:0xD0D0D0]];

    }];
    
}

- (void)setupSubView{
    
    
    [self.accountTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SC_DP_375(12));
        make.right.mas_equalTo(SC_DP_375(-12));
        make.height.mas_equalTo(SC_DP_375(40));
        make.top.mas_equalTo(SC_DP_375(150));
    }];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.right.height.mas_equalTo(self.accountTextFiled);
        make.top.mas_equalTo(self.accountTextFiled.mas_bottom).mas_offset(SC_DP_375(10));
       }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.mas_equalTo(self.accountTextFiled);

        make.top.mas_equalTo(self.passwordTextField.mas_bottom).mas_offset(SC_DP_375(10));
       }];

}


- (void)loginBtnClick{
    
}

- (LoginViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[LoginViewModel alloc]init];
    }
    return _viewModel;
    
}
- (UITextField *)accountTextFiled{
    if (!_accountTextFiled) {
        _accountTextFiled = [PublicView textFieldFrame:CGRectZero placeholder:HHLocalizedString(@"请输入账户") textColor:nil font:kFont(15) returnKeyType:UIReturnKeyDefault delegate:nil addView:self.view];
        _accountTextFiled.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _accountTextFiled;
}
- (UITextField *)passwordTextField{
    if (!_passwordTextField) {
        _passwordTextField = [PublicView textFieldFrame:CGRectZero placeholder:HHLocalizedString(@"请输入账户") textColor:nil font:kFont(15) returnKeyType:UIReturnKeyDefault delegate:nil addView:self.view];
        _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
        
    }
    return _passwordTextField;
}
- (UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [PublicView ButtonFrame:CGRectZero imageName:nil selImageName:nil title:HHLocalizedString(@"登录") titleColor:[UIColor whiteColor] selTitle:nil selColor:nil target:self action:@selector(loginBtnClick) addView:self.view];
    }
    return _loginBtn;
}


@end
