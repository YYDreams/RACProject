//
//  BaseNavViewController.h
//  QF
//
//  Created by yuki on 2019/8/5.
//  Copyright © 2019 flowerflower. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseNavViewController : UINavigationController

//拦截返回事件
@property (nonatomic, copy) BOOL (^shouldPopBlock)(void);

@end

NS_ASSUME_NONNULL_END
