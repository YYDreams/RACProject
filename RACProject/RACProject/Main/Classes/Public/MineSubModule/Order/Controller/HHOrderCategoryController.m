//
//  HHOrderCategoryController.m
//  RACProject
//
//  Created by flowerflower on 2020/4/25.
//  Copyright © 2020 flowerflower. All rights reserved.
//

#import "HHOrderCategoryController.h"
#import "JXCategoryView.h"
#import "HHOrderListController.h"
@interface HHOrderCategoryController ()<UIScrollViewDelegate, JXCategoryViewDelegate, JXCategoryListContainerViewDelegate>
@property (nonatomic, strong) NSArray <NSString *> *titles;

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, strong) JXCategoryTitleView *categoryView;




@end

@implementation HHOrderCategoryController
- (instancetype)initWithSelectedIndex:(NSInteger)Index
{
    self = [super init];
    if (self) {
        self.selectedIndex = Index;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubView];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    //处于第一个item的时候，才允许屏幕边缘手势返回
    self.navigationController.interactivePopGestureRecognizer.enabled = (_categoryView.selectedIndex == 0);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    //离开页面的时候，需要恢复屏幕边缘手势，不能影响其他页面
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}


- (void)setupSubView{
    JXCategoryListContainerView * listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    self.categoryView.listContainer = listContainerView;
    [self.view addSubview:listContainerView];
    
    
     
     UIView * topView = [UIView new];
     topView.backgroundColor = [UIColor whiteColor];
     [self.view addSubview:topView];
     
     [topView addSubview:self.categoryView];
     
     [listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.view).offset(50);
         make.left.right.bottom.equalTo(self.view);
     }];
     
     [topView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.left.right.mas_offset(0.f);
         make.height.mas_equalTo(50);
     }];
     
     [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerY.mas_equalTo(topView);
         make.left.right.mas_offset(0.f);
         make.height.mas_equalTo(35.f);
     }];
}

#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //侧滑手势处理
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

#pragma mark - JXCategoryListContainerViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index
{
    HHOrderListController * list = [HHOrderListController new];
    if (index == 0) {
        list.selectIndex = 0;
    }else if (index == 1){
        list.selectIndex = 5;
    }else if (index == 2){
        list.selectIndex = 10;
    }else if (index == 3){
        list.selectIndex = 40;
    }else{
        list.selectIndex = 42;
    }
    return list;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView
{
    return self.categoryView.titles.count;
}

- (JXCategoryTitleView *)categoryView{
    if (!_categoryView) {
        _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 50)];
        _categoryView.titles = self.titles;
        _categoryView.defaultSelectedIndex = self.selectedIndex;
        _categoryView.backgroundColor = [UIColor whiteColor];
        _categoryView.delegate = self;
        _categoryView.titleSelectedColor = kThemeColor;
        _categoryView.titleColor = [UIColor colorWithHex:0x222427];
        _categoryView.titleSelectedFont = [UIFont systemFontOfSize:14.f weight:UIFontWeightMedium];
        _categoryView.titleFont = [UIFont systemFontOfSize:14.f weight:UIFontWeightRegular];
        _categoryView.titleColorGradientEnabled = YES;
        _categoryView.contentScrollViewClickTransitionAnimationEnabled = NO;
        _categoryView.titles = @[@"全部",@"待付款",@"待发货",@"待收货",@"已完成"];
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorColor = kThemeColor;
        lineView.indicatorWidth = 16.f;
        lineView.indicatorHeight = 2.f;
        _categoryView.indicators = @[lineView];
    }
    return _categoryView;
}
@end
