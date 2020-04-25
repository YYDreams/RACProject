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

//网络错误
@property(nonatomic ,strong , readonly) RACReplaySubject *networkErrorSubject;




- (void)bindModel;

@end

NS_ASSUME_NONNULL_END
