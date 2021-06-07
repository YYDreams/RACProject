//
//  BaseViewModel.h
//  RACProject
//
//  Created by flowerflower on 2020/4/23.
//  Copyright © 2020 flowerflower. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewModel : NSObject

//加载中...
@property(nonatomic ,strong , readonly) RACReplaySubject *loadingSubject;

//提示框
@property(nonatomic ,strong , readonly) RACReplaySubject *totastSubject;

//缺省页
@property(nonatomic ,strong , readonly) RACReplaySubject *noDataSubject;

//网络异常，请尝试刷新
@property(nonatomic ,strong , readonly) RACReplaySubject *networkErrorSubject;

//努力连接中 请重试
@property(nonatomic ,strong , readonly) RACReplaySubject *connectingSubject;


- (void)bindModel;

@end

NS_ASSUME_NONNULL_END
