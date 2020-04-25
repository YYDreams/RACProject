//
//  HHOrderListController.h
//  RACProject
//
//  Created by flowerflower on 2020/4/25.
//  Copyright © 2020 flowerflower. All rights reserved.
//

#import "BaseTableViewController.h"
#import "JXCategoryListContainerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHOrderListController : BaseTableViewController<JXCategoryListContentViewDelegate>
@property (nonatomic, assign) NSInteger selectIndex;


@end

NS_ASSUME_NONNULL_END
