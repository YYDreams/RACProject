//
//  BaseViewModel.m
//  RACProject
//
//  Created by flowerflower on 2020/4/23.
//  Copyright © 2020 flowerflower. All rights reserved.
//

#import "BaseViewModel.h"
@interface BaseViewModel()

//加载中...
@property(nonatomic ,strong , readwrite) RACReplaySubject *loadingSubject;

//提示框
@property(nonatomic ,strong , readwrite) RACReplaySubject *totastSubject;

//缺省页
@property(nonatomic ,strong , readwrite) RACReplaySubject *noDataSubject;

//网络错误
@property(nonatomic ,strong , readwrite) RACReplaySubject *networkErrorSubject;

@end

@implementation BaseViewModel


- (RACReplaySubject *)loadingSubject{
    if (!_loadingSubject) {
        _loadingSubject = [RACReplaySubject subject];
    }
    return _loadingSubject;
}
- (RACReplaySubject *)totastSubject{
    if (!_totastSubject) {
        _totastSubject = [RACReplaySubject subject];
    }
    return _totastSubject;
}
- (RACReplaySubject *)noDataSubject{
    if (!_noDataSubject) {
        _noDataSubject = [RACReplaySubject subject];
    }
    return _loadingSubject;
}
- (RACReplaySubject *)networkErrorSubject{
    if (!_networkErrorSubject) {
        _networkErrorSubject = [RACReplaySubject subject];
    }
    return _networkErrorSubject;
}
- (void)bindModel{}

@end
