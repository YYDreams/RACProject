//
//  BaseTableViewController+PageStatus.h
//  QF
//
//  Created by flowerflower on 2019/8/5.
//  Copyright © 2019 flowerflower. All rights reserved.
//

#import "BaseTableViewController.h"

#import "UIScrollView+EmptyDataSet.h"



typedef void(^EmptyViewTapBlock)(void);
NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewController (PageStatus)<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
/**
 *  当前页面状态
 */
@property (nonatomic, assign) PageStatus currentPageStatus;



/**
 *  如果请求成功，空数据，显示提示
 */
@property (nonatomic, strong) NSString *succeedEmptyStr;

/**
 *  如果请求成功，空数据，显示的图片
 */
@property (nonatomic ,strong) UIImage *succeedEmptyImage;

/**
 *  空页面点击，刷新block
 */
@property (nonatomic, copy) EmptyViewTapBlock emptyViewTapBlock;


@end

NS_ASSUME_NONNULL_END
