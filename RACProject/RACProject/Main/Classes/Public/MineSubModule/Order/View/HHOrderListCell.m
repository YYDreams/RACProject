//
//  HHOrderListCell.m
//  RACProject
//
//  Created by flowerflower on 2020/4/25.
//  Copyright © 2020 flowerflower. All rights reserved.
//

#import "HHOrderListCell.h"
#import <SDWebImage.h>
@interface HHOderImageCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView * image;
@end


@implementation HHOderImageCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    [self.contentView addSubview:self.image];
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark - getterMethod
- (UIImageView *)image{
    if (!_image) {
        _image = [UIImageView new];
    }
    return _image;
}
@end
@interface HHOrderListCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>



@property (nonatomic, strong) UIView *topBgView;

@property (nonatomic, strong) UILabel *orderNoLabel;

@property (nonatomic, strong) UILabel *orderStatusLabel;



@property (nonatomic, strong) UIView *singleGoodsView;

@property (nonatomic, strong) UIImageView *singleImgView;

@property (nonatomic, strong) UILabel *singleTitleLabel;

@property (nonatomic, strong) UILabel *singleCountLabel;

@property (nonatomic, strong) UILabel *singlePriceLabel;



@property (nonatomic, strong) UIView *multipleGoodsView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UILabel *multipleCountLabel;

@property (nonatomic, strong) UILabel *multiplePriceLabel;



@property (nonatomic, strong) UIView * bottomView ;

@property (nonatomic, strong) UILabel *createOrderTimeLabel; //下单时间

@property (nonatomic, strong) UIButton *button1;

@property (nonatomic, strong) UIButton *button2;


@end


@implementation HHOrderListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubView];
        [self setupConstraints];
        
    }
    return self;
}
- (void)setupSubView{
    self.backgroundColor = kSeparatedLineColor;

    [self addSubview:self.topBgView];
    [self.topBgView addSubview:self.orderNoLabel];
    [self.topBgView addSubview:self.orderStatusLabel];
    
    [self addSubview:self.singleGoodsView];
    [self.singleGoodsView addSubview:self.singleImgView];
    [self.singleGoodsView addSubview:self.singleTitleLabel];
    [self.singleGoodsView addSubview:self.singleCountLabel];
    [self.singleGoodsView addSubview:self.singlePriceLabel];
    
    
    [self addSubview:self.multipleGoodsView];
    [self.multipleGoodsView addSubview:self.collectionView];
    [self.multipleGoodsView addSubview:self.multipleCountLabel];
    [self.multipleGoodsView addSubview:self.multiplePriceLabel];
    
    [self addSubview:self.bottomView];
    [self.bottomView addSubview:self.createOrderTimeLabel];
    [self.bottomView addSubview:self.button1];
    [self.bottomView addSubview:self.button2];
    
    
    

    
}
- (void)setViewModel:(HHOrderListCellViewModel *)viewModel{
    _viewModel = viewModel;
    RAC(self.orderNoLabel,text) = [RACObserve(viewModel, orderNo) takeUntil:self.rac_prepareForReuseSignal];
    
    RAC(self.orderStatusLabel,text) = [RACObserve(viewModel, orderStatusText) takeUntil:self.rac_prepareForReuseSignal];
    
    RAC(self.orderStatusLabel,textColor) = [RACObserve(viewModel, orderStatusColor) takeUntil:self.rac_prepareForReuseSignal];
  
    RAC(self.createOrderTimeLabel, text) = [RACObserve(viewModel, orderTime) takeUntil:self.rac_prepareForReuseSignal];
    
    RAC(self.button1,hidden) = [RACObserve(viewModel, button1Hidden) takeUntil:self.rac_prepareForReuseSignal];
    
    RAC(self.button2,hidden) = [RACObserve(viewModel, button2Hidden) takeUntil:self.rac_prepareForReuseSignal];
    
    
    @weakify(self);
//    [RACObserve(viewModel, singleGoodsImage) subscribeNext:^(id  _Nullable x) {
//        @strongify(self);
//        [self.singleImgView sd_setImageWithURL:[NSURL URLWithString:@"https://as-vip.missfresh.cn/frontend/h5-1-castor-v1-activity/order-cash.html?masterId=104062677"] placeholderImage:nil];
//    }];


            [self.singleImgView sd_setImageWithURL:[NSURL URLWithString:@"https://as-vip.missfresh.cn/frontend/h5-1-castor-v1-activity/order-cash.html?masterId=104062677"] placeholderImage:nil];
     RAC(self.singleGoodsView, hidden) = [[RACObserve(viewModel, isSingleGoods) takeUntil:self.rac_prepareForReuseSignal] map:^id _Nullable(id  _Nullable value) {
         return @(![value boolValue]);
     }];
     
     RAC(self.multipleGoodsView, hidden) = [RACObserve(viewModel, isSingleGoods) takeUntil:self.rac_prepareForReuseSignal];
     
    
    [[RACObserve(viewModel, goodsImages) takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
       @strongify(self);
        [self.collectionView reloadData];
    }];
    [RACObserve(viewModel, button1Color) subscribeNext:^(UIColor  *color) {
       @strongify(self);
        self.button1.layer.borderWidth = color ? 1.f : 0.f;
        self.button1.layer.borderColor = color.CGColor;
        [self.button1 setTitleColor:color forState:UIControlStateNormal];
    }];
    
    [RACObserve(viewModel, button2Color) subscribeNext:^(UIColor  *color) {
         @strongify(self);
          self.button2.layer.borderWidth = color ? 1.f : 0.f;
          self.button2.layer.borderColor = color.CGColor;
          [self.button2 setTitleColor:color forState:UIControlStateNormal];
      }];
      
    [RACObserve(viewModel,button1Title) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.button1 setTitle:x forState:UIControlStateNormal];
    }];
    
    [RACObserve(viewModel, button2Title) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.button2 setTitle:x forState:UIControlStateNormal];
    }];
    
}

- (void)setupConstraints{
    
    
    [self.topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.height.mas_equalTo(SC_DP_375(50));

    }];
    
    [self.orderNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(self.topBgView).mas_offset(SC_DP_375(margin_12));
        make.centerY.mas_equalTo(self.topBgView.mas_centerY);
    }];
    
    [self.orderStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.topBgView).mas_offset(SC_DP_375(-margin_12));
         make.centerY.mas_equalTo(self.topBgView.mas_centerY);
     }];
    

    self.singleGoodsView.backgroundColor = [UIColor redColor];
    self.singleImgView.backgroundColor = [UIColor blueColor];
    [self.singleGoodsView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.topBgView.mas_bottom);
          make.height.mas_equalTo(SC_DP_375(100));

      }];
    
    
    [self.singleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.mas_equalTo(self.singleGoodsView).mas_offset(SC_DP_375(margin_12));
         make.centerY.mas_equalTo(self.singleGoodsView.mas_centerY);
          make.width.height.mas_equalTo(SC_DP_375(80));
      }];
    
//    [self.singleTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.singleImgView.mas_right).mas_offset(SC_DP_375(margin_12));
//           make.top.mas_equalTo(self.singleGoodsView).mas_equalTo(SC_DP_375(margin_12));
//         make.right.mas_equalTo(self.singleGoodsView);
//        }];
//    [self.singleCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.singleTitleLabel);
//        make.bottom.mas_equalTo(self.singleImgView.mas_bottom);
//
//        }];
////
//    [self.singlePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(self.singleGoodsView.mas_right).mas_offset(SC_DP_375(-margin_12));
//        make.top.mas_equalTo(self.singleGoodsView);
//        make.bottom.mas_equalTo(self.singleCountLabel);
//        }];
//
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.topBgView.mas_bottom);
        make.height.mas_equalTo(SC_DP_375(100));
    }];

    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.singleGoodsView.mas_bottom);
         make.height.mas_equalTo(SC_DP_375(50));
        make.bottom.mas_equalTo(0);
    }];
    [self.createOrderTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(self.bottomView.mas_left).mas_offset(SC_DP_375(margin_12));
            make.centerY.mas_equalTo(self.bottomView.mas_centerY);
      }];
    [self.button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(SC_DP_375(-margin));
        make.centerY.mas_equalTo(self.bottomView.mas_centerY);
        make.width.mas_equalTo(SC_DP_375(70));

    }];
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
       make.right.mas_equalTo(self.button2.mas_left).mas_offset(-10);
       make.centerY.mas_equalTo(self.bottomView.mas_centerY);
        make.width.mas_equalTo(self.button2);
    }];
    
    
}
- (UIView *)topBgView{
    if (!_topBgView) {
        _topBgView = [PublicView ViewFrame:CGRectZero withBackgroundColor:nil addView:nil];
    }
    return _topBgView;
}
- (UILabel *)orderNoLabel{
    if (!_orderNoLabel) {
        _orderNoLabel = [PublicView LabelFrame:CGRectZero Text:HHLocalizedString(@"我的订单") TextAliType:0 Font:kFont(15) Color:k3Color BackColor:nil addView:nil
            ];
    }
    return _orderNoLabel;
}
- (UILabel *)orderStatusLabel{
    if (!_orderStatusLabel) {
        _orderStatusLabel = [PublicView LabelFrame:CGRectZero Text:HHLocalizedString(@"我的订单") TextAliType:0 Font:kFont(15) Color:k3Color BackColor:nil addView:nil
            ];
    }
    return _orderStatusLabel;
}

- (UIView *)singleGoodsView{
    if (!_singleGoodsView) {
        _singleGoodsView = [PublicView ViewFrame:CGRectZero withBackgroundColor:nil addView:nil];
    }
    return _singleGoodsView;
}
- (UIImageView *)singleImgView{
    if (!_singleImgView) {
        _singleImgView = [[UIImageView alloc]init];
    }
    return _singleImgView;
}

- (UILabel *)singleTitleLabel{
    if (!_singleTitleLabel) {
        _singleTitleLabel = [PublicView LabelFrame:CGRectZero Text:HHLocalizedString(@"我的订单") TextAliType:0 Font:kFont(15) Color:k3Color BackColor:nil addView:nil
            ];
    }
    return _singleTitleLabel;
}
- (UILabel *)singleCountLabel{
    if (!_singleCountLabel) {
        _singleTitleLabel = [PublicView LabelFrame:CGRectZero Text:HHLocalizedString(@"11") TextAliType:0 Font:kFont(15) Color:k3Color BackColor:nil addView:nil
            ];
    }
    return _singleTitleLabel;
}

- (UILabel *)singlePriceLabel{
    if (!_singlePriceLabel) {
        _singlePriceLabel = [PublicView LabelFrame:CGRectZero Text:HHLocalizedString(@"20.2") TextAliType:0 Font:kFont(15) Color:k3Color BackColor:nil addView:nil
            ];
    }
    return _singlePriceLabel;
}

- (UIView *)multipleGoodsView{
    if (!_multipleGoodsView) {
         _multipleGoodsView = [PublicView ViewFrame:CGRectZero withBackgroundColor:nil addView:nil];
     }
     return _multipleGoodsView;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
           layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
         layout.itemSize = CGSizeMake(80, 80);
         layout.minimumLineSpacing = 8.0;
//         layout.sectionInset = UIEdgeInsetsMake(8, 10, 0, 10);
         
           _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
           _collectionView.backgroundColor = [UIColor redColor];
           _collectionView.delegate = self;
           _collectionView.dataSource = self;
           _collectionView.alwaysBounceHorizontal = YES;
           _collectionView.showsHorizontalScrollIndicator = NO;
           _collectionView.showsVerticalScrollIndicator = NO;
           [_collectionView registerClass:[HHOderImageCell class] forCellWithReuseIdentifier:@"HHOderImageCell"];
        
    }
    return _collectionView;
}


- (UILabel *)multipleCountLabel{
    if (!_multipleCountLabel) {
        _multipleCountLabel = [PublicView LabelFrame:CGRectZero Text:HHLocalizedString(@"我的订单") TextAliType:0 Font:kFont(15) Color:k3Color BackColor:nil addView:nil
            ];
    }
    return _multipleCountLabel;
}
- (UILabel *)multiplePriceLabel{
    if (!_multipleCountLabel) {
        _multipleCountLabel = [PublicView LabelFrame:CGRectZero Text:HHLocalizedString(@"11") TextAliType:0 Font:kFont(15) Color:k3Color BackColor:nil addView:nil
            ];
    }
    return _multipleCountLabel;
}


- (UIView *)bottomView{
    if (!_bottomView) {
         _bottomView = [PublicView ViewFrame:CGRectZero withBackgroundColor:nil addView:nil];
     }
     return _bottomView;
}



- (UILabel *)createOrderTimeLabel{
    if (!_createOrderTimeLabel) {
        _createOrderTimeLabel = [PublicView LabelFrame:CGRectZero Text:HHLocalizedString(@"我的订单") TextAliType:0 Font:kFont(15) Color:k6Color BackColor:nil addView:nil];
    }
    return _createOrderTimeLabel;
}

- (UIButton *)button1{
    if (!_button1) {
        _button1 = [PublicView ButtonFrame:CGRectZero imageName:nil selImageName:nil title:@"全部订单" titleColor:k6Color selTitle:nil selColor:nil target:self action:nil addView:nil];
        _button1.titleLabel.font = kFont(14);
        
    }
    return _button1;
}
- (UIButton *)button2{
    if (!_button2) {
        _button2 = [PublicView ButtonFrame:CGRectZero imageName:nil selImageName:nil title:@"全部订单" titleColor:k6Color selTitle:nil selColor:nil target:self action:nil addView:nil];
        _button2.titleLabel.font = kFont(14);
        
    }
    return _button2;
}
#pragma mark - UICollectionViewDelegate && dataSorce
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.viewModel.goodsImages.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HHOderImageCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HHOderImageCell" forIndexPath:indexPath];
    [cell.image sd_setImageWithURL:[NSURL URLWithString:self.viewModel.goodsImages[indexPath.row]] placeholderImage:nil];
    return cell;
}

@end


