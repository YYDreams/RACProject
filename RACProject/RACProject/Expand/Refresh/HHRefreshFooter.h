//
//  HHRefreshFooter.h
//  SamClub
//
//  Created by flowerflower on 2020/4/25.
//  Copyright © 2020 flowerflower. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHRefreshFooter : MJRefreshBackStateFooter

@property (nonatomic, assign) CGFloat bottomInset;
@property (nonatomic, copy) void(^bottomInsetCalledBack)(void);
+ (MJRefreshFooter *)HHRefreshFooter:(MJRefreshComponentRefreshingBlock)refreshingBlock;

@end

NS_ASSUME_NONNULL_END
