//
//  BaseUIViewController.h
//  QF
//
//  Created by yuki on 2019/8/5.
//  Copyright © 2019 flowerflower. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseUIViewController : UIViewController

// 是否隐藏导航 默认是不隐藏的
@property(nonatomic,assign,getter=isHiddenNavBar) BOOL hiddenNavBar;
//加载网络数据 子类需要重写
- (void)loadDataFromNetwork;
//子类重写 自定义导航栏
- (void)setupNav;
//子类重写
- (void)setupSubView;

//网络从无网状态变为有网状态回调这个方法
- (void)autoDoRetryRequest;

///重设返回按钮
- (void)needResetBackItem;
///重设返回按钮的事件响应方法，需子类实现
- (void)backItemClick;

- (void)bindViewModel;


@end

NS_ASSUME_NONNULL_END
