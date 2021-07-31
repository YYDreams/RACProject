//
//  MineCell.m
//  RACProject
//
//  Created by flowerflower on 2020/4/25.
//  Copyright © 2020 flowerflower. All rights reserved.
//

#import "MineCell.h"

@interface MineCell ()

@property (nonatomic, strong) UIImageView * floorImg;

@property (nonatomic, strong) UILabel * productName;

@property (nonatomic, strong) UILabel * productPrice;

@property (nonatomic, strong) UILabel * originPrice;


//@property (nonatomic, strong) QMUIFloatLayoutView * layoutView;

@property (nonatomic, strong) UIButton *sellOutButton; //售罄

//@property (nonatomic, strong) SCRecommendCellViewModel * viewModel;

@property (nonatomic, strong) UIImageView * productImg;

@property (nonatomic, assign) NSInteger sceneID;

@property (nonatomic, copy) NSString *algId;

@property (nonatomic, strong) UIButton * purchaseCar;

@end

@implementation MineCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor colorWithHex:0xffffff];
        
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews
{
    _productImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_productImg];
    [_productImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
        make.height.equalTo(_productImg.mas_width);
    }];
    
    _floorImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_floorImg];
    [_floorImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_productImg).offset(12);
        make.top.equalTo(_productImg.mas_bottom).offset(12);
    }];
     
    [self.contentView addSubview:self.sellOutButton];
    [self.sellOutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.productImg).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    _productName = [[UILabel alloc] init];
    _productName.textColor = [UIColor colorWithHex:0x222427];
    _productName.font = [UIFont systemFontOfSize:13];
    _productName.numberOfLines = 2;
    [self.contentView addSubview:_productName];
    [_productName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_productImg).offset(12);
        make.top.equalTo(_productImg.mas_bottom).offset(12);
        make.right.equalTo(self.contentView).offset(-12);
    }];
    
//    _layoutView = [[QMUIFloatLayoutView alloc] init];
//    _layoutView.padding = UIEdgeInsetsZero;
//    _layoutView.itemMargins = UIEdgeInsetsMake(4, 0, 0, 4);
//    _layoutView.clipsToBounds = YES;
//    [self.contentView addSubview:_layoutView];
//    [_layoutView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView).offset(12);
//        make.top.equalTo(_productName.mas_bottom).offset(10);
//        make.right.equalTo(self.contentView).offset(-12);
//        make.height.mas_equalTo(34);
//    }];
    
    _productPrice = [[UILabel alloc] init];
    _productPrice.textColor = [UIColor colorWithHex:0xDE1C24];
    _productPrice.font = [UIFont boldSystemFontOfSize:14];
    [self.contentView addSubview:_productPrice];
    [_productPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12);
        make.bottom.equalTo(self.contentView).offset(-14);
        make.height.mas_equalTo(25);
    }];
    
    _originPrice = [[UILabel alloc] init];
    _originPrice.textColor = [UIColor colorWithHex:0xAEB3B7];
    [self.contentView addSubview:_originPrice];
    [_originPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_productPrice.mas_right).offset(4);
        make.centerY.equalTo(_productPrice);
    }];
    
    _purchaseCar = [[UIButton alloc] init];
    [_purchaseCar setImage:[UIImage imageNamed:@"recommandCar"] forState:UIControlStateNormal];
//    @weakify(self);
//    [[_purchaseCar rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        @strongify(self);
//        [self uploadBuryPoint];
//
//        if (self.viewModel.isPresell) {
//            [SCNavigator navigationToType:SCControllerTypeGoodsDetail userInfo:@{kGoodsDetailAnimationFromView:_productImg ?: @"", @"spuId":SCString(self.viewModel.spuId, @""), @"storeId":SCString(self.viewModel.storeId, @"")} animated:YES];
//            return;
//        }
//        UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
//        CGRect startRect = [self.purchaseCar convertRect:self.purchaseCar.bounds toView:window];
//        [self responseChainWithEventName:@"recommandAddCarEvent" userInfo:@{@"storeId":SCString(self.viewModel.storeId, @""), @"spuId":SCString(self.viewModel.spuId, @""), @"goodsName":SCString(self.viewModel.goodsName, @""), @"isPresell":@(self.viewModel.isPresell), @"img":self.productImg,@"rect":[NSValue valueWithCGRect:startRect]}];
//    }];
    [self.contentView addSubview:_purchaseCar];
    [_purchaseCar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-5);
        make.centerY.equalTo(_productPrice);
        make.width.height.mas_equalTo(25);
    }];
}


//- (void)setViewModel:(SCRecommendCellViewModel *)viewModel {
//    _viewModel = viewModel;
//
//    self.floorImg.image = viewModel.iconImage;
//
//    self.productName.attributedText = viewModel.title;
//
//    [self.productImg sd_setImageWithURL:[NSURL URLWithString:viewModel.productImg] placeholderImage:[UIImage imageNamed:@"class_default_item"]];
//
//    self.productPrice.attributedText = viewModel.nowPrice;
//    self.originPrice.attributedText = viewModel.originPrice;
//
//    for (UIView * subView in _layoutView.subviews) {
//        [subView removeFromSuperview];
//    }
//    for (NSInteger i = 0; i < viewModel.tagArray.count; i++) {
//        QMUIGhostButton * button = [[QMUIGhostButton alloc] init];
//        button.userInteractionEnabled = NO;
//        button.ghostColor = [UIColor colorWithHex:0x007AC9];
//        button.cornerRadius = 0;
//        button.borderWidth = 0.5;
//        [button setTitle:viewModel.tagArray[i] forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor colorWithHex:0x007AC9] forState:UIControlStateNormal];
//        button.titleLabel.font = [UIFont scFontOfSize:10];
//        button.contentEdgeInsets = UIEdgeInsetsMake(0.5, 4, 0.5, 4);
//        [_layoutView addSubview:button];
//    }
//    if (self.viewModel.isSoldOut) {
//        self.sellOutButton.hidden = NO;
//        self.purchaseCar.userInteractionEnabled = NO;
//        [self.purchaseCar setImage:[UIImage imageNamed:@"goods_sellOut"] forState:UIControlStateNormal];
//    }else{
//        self.sellOutButton.hidden = YES;
//        self.purchaseCar.userInteractionEnabled = YES;
//        [self.purchaseCar setImage:[UIImage imageNamed:@"class_cell_shop_cart"] forState:UIControlStateNormal];
//
//    }
//    if (self.sceneID == 14) { //商详默认一行
//        if (viewModel.tagArray.count > 0) {
//            self.productName.numberOfLines = 1;
//
//        }else{
//            self.productName.numberOfLines = 2;
//        }
//        [_layoutView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.contentView).offset(12);
//            make.top.equalTo(_productName.mas_bottom).offset(10);
//            make.right.equalTo(self.contentView).offset(-12);
//            make.height.mas_equalTo(15);
//        }];
//    }
//
//
//}


- (UIButton *)sellOutButton{
    if (!_sellOutButton) {
        _sellOutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sellOutButton.userInteractionEnabled = NO;
        [_sellOutButton setTitle:@"已售罄" forState:UIControlStateNormal];
        [_sellOutButton setTitleColor:[UIColor colorWithHex:0x000000] forState:UIControlStateNormal];
        _sellOutButton.titleLabel.font = [UIFont systemFontOfSize:13];
        _sellOutButton.backgroundColor = [UIColor colorWithHex:0xFFFFFF alpha:0.8];
       // [_sellOutButton addTarget:self action:@selector(viewAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sellOutButton;
}
@end
