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

@property(nonatomic ,strong)UIImageView  *imgView;

@property(nonatomic ,strong)UIButton *loginBtn;

@property(nonatomic ,strong)LoginViewModel *viewModel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubView];
    
    [self bindViewModel];
    
}
#pragma mark - bindViewModel
- (void)bindViewModel{
    
    //绑定输入框
    RAC(self.viewModel,account) = [RACSignal merge:@[self.accountTextFiled.rac_textSignal,RACObserve(self.accountTextFiled, text)]];
    RAC(self.viewModel,password) = [RACSignal merge:@[self.passwordTextField.rac_textSignal,RACObserve(self.passwordTextField, text)]];
    
    //监听button是否可用
    RAC(self.loginBtn, enabled)  = self.viewModel.loginBtnEnableSignal;
    @weakify(self);
    [RACObserve(self.loginBtn, enabled) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.loginBtn setBackgroundColor:[x boolValue]?kThemeColor:[UIColor colorWithHex:0xD0D0D0]];
        
    }];
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [HHHudManager showHudWithText:[NSString stringWithFormat:@"输入的账号为:%@\n密码为:%@",self.viewModel.account,self.viewModel.password]];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:true completion:^{}];

        });
    }];

    //显示输入长度
    [self.accountTextFiled.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        if ([x length] > 11) {
            self.accountTextFiled.text = [x substringToIndex:11];
        }
    }];
    [self.passwordTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        if ([x length] > 6) {
            self.passwordTextField.text = [x substringToIndex:6];
        }
    }];
}
- (void)setupSubView{
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.width.equalTo(110);
        make.top.mas_equalTo(SC_DP_375(50));
    }];
    
    [self.accountTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SC_DP_375(12));
        make.right.mas_equalTo(SC_DP_375(-12));
        make.height.mas_equalTo(SC_DP_375(40));
        make.top.mas_equalTo(self.imgView.mas_bottom).mas_offset(SC_DP_375(20));
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
#pragma mark - getter Methods
- (LoginViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[LoginViewModel alloc]init];
    }
    return _viewModel;
}
- (UITextField *)accountTextFiled{
    if (!_accountTextFiled) {
        _accountTextFiled = [PublicView textFieldFrame:CGRectZero placeholder:HHLocalizedString(@"请输入手机号") textColor:nil font:kFont(15) returnKeyType:UIReturnKeyDefault delegate:nil addView:self.view];
        _accountTextFiled.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _accountTextFiled;
}
- (UITextField *)passwordTextField{
    if (!_passwordTextField) {
        _passwordTextField = [PublicView textFieldFrame:CGRectZero placeholder:HHLocalizedString(@"请输入密码") textColor:nil font:kFont(15) returnKeyType:UIReturnKeyDefault delegate:nil addView:self.view];
        _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
        
    }
    return _passwordTextField;
}
- (UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc]init];
        [_loginBtn setTitle:HHLocalizedString(@"登录") forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:_loginBtn];
    }
    return _loginBtn;
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.image = [UIImage imageNamed:@"icon_bg"];
        _imgView.layer.masksToBounds = true;
        _imgView.layer.cornerRadius = 110 * 0.5;
        [self.view addSubview:_imgView];
    }
    return _imgView;
}
@end
