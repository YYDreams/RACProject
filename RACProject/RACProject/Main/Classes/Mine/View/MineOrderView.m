//
//  MineOrderView.m
//  RACProject
//
//  Created by flowerflower on 2020/4/25.
//  Copyright © 2020 flowerflower. All rights reserved.
//

#import "MineOrderView.h"
@interface MineOrderView()

@property(nonatomic ,strong) UIView *mineOderView;

@property(nonatomic ,strong) UILabel *titleLabel;

@property(nonatomic ,strong) UIButton *allOrderBtn;


@property(nonatomic ,strong) UIButton *btn1;

@property(nonatomic ,strong) UIButton *btn2;

@property(nonatomic ,strong) UIButton *btn3;

@property(nonatomic ,strong) UIButton *btn4;



@end

@implementation MineOrderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self  = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubView];
    }
    return self;
}

- (void)setupSubView{
    
    [self.mineOderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SC_DP_375(margin_12));
        make.right.mas_equalTo(SC_DP_375(-margin_12));
        make.height.mas_equalTo(SC_DP_375(50));
        make.top.mas_equalTo(self);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.mas_equalTo(self.mineOderView).mas_offset(SC_DP_375(12));
          make.centerY.mas_equalTo(self.mineOderView.mas_centerY);

      }];
    [self.allOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
          make.right.mas_equalTo(self.mineOderView.mas_right).mas_offset(SC_DP_375(-12));
        make.centerY.mas_equalTo(self.mineOderView.mas_centerY);

          
      }];
    UIView *orderListView = [PublicView ViewFrame:CGRectZero withBackgroundColor:[UIColor whiteColor] addView:self];
    [orderListView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(self.mineOderView.mas_left);
        make.right.mas_equalTo(self.mineOderView.mas_right);
         make.height.mas_equalTo(SC_DP_375(80));
         make.top.mas_equalTo(self.mineOderView.mas_bottom);
     }];
        NSArray *titleArr = @[@"待付款",@"待发货",@"待收货",@"已完成"];
        NSArray *imgArr = @[@"mine_pay",@"mine_shipping",@"mine_the_goods",@"mine_to_complete"];

    NSMutableArray *btns = [NSMutableArray array];
    for (int i = 0; i < titleArr.count; i++) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
               btn.titleLabel.font = kFont(12);
               btn.tag = i+1;
               [btn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
               [btn setTitleColor:k9Color forState:UIControlStateNormal];
               [btn setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        if (i == 0) {
            _btn1 = btn;
        }else if (i == 1){
            _btn2 = btn;
        }else if (i == 3){
            _btn3 = btn;
        }else{
            _btn4 = btn;
        }
           [orderListView addSubview:btn];
           [btns addObject:btn];
    }
    [btns mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(orderListView);
    }];
    [btns  mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:2 leadSpacing:0 tailSpacing:0];
    
    [self layoutIfNeeded];
    [_btn1 hh_imagePositionStyle:SGImagePositionStyleTop spacing:6];
    [_btn2 hh_imagePositionStyle:SGImagePositionStyleTop spacing:6];
    [_btn3 hh_imagePositionStyle:SGImagePositionStyleTop spacing:6];
    [_btn4 hh_imagePositionStyle:SGImagePositionStyleTop spacing:6];
    [_allOrderBtn hh_imagePositionStyle:SGImagePositionStyleRight spacing:1];

    
    
}
- (void)btnOnClick:(UIButton *)sender{
    if (self.handlerOrderBtnBlock) {
        self.handlerOrderBtnBlock(sender.tag);
        
    }
    
}
-(void)allOrderAction{
    if (self.handlerOrderBtnBlock) {
         self.handlerOrderBtnBlock(0);
     }
}

- (UIView *)mineOderView{
    if (!_mineOderView) {
        _mineOderView = [PublicView ViewFrame:CGRectZero withBackgroundColor:nil addView:self];
    }
    return _mineOderView;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [PublicView LabelFrame:CGRectZero Text:HHLocalizedString(@"我的订单") TextAliType:0 Font:kFont(15) Color:k3Color BackColor:nil addView:self];
    }
    return _titleLabel;
}
- (UIButton *)allOrderBtn{
    if (!_allOrderBtn) {
        _allOrderBtn = [PublicView ButtonFrame:CGRectZero imageName:@"right_arrow" selImageName:nil title:@"全部订单" titleColor:k6Color selTitle:nil selColor:nil target:self action:@selector(allOrderAction) addView:self];
        _allOrderBtn.titleLabel.font = kFont(14);
        
    }
    return _allOrderBtn;
}
@end
