//
//  BaseCollectionViewController.m
//  WoYin
//
//  Created by 张志华008 on 2019/9/5.
//  Copyright © 2019 flowerflower. All rights reserved.
//

#import "BaseCollectionViewController.h"

@interface BaseCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation BaseCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        //  设置collectionview的滚动方向
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        
        //2.初始化collectionView
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout: layout];
        
        _collectionView.backgroundColor = kBgColor;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        //3.注册collectionViewCell

        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.emptyDataSetSource = self;
        _collectionView.emptyDataSetDelegate = self;
        self.succeedEmptyStr =@"暂无数据";
        
        self.succeedEmptyImage = [UIImage imageNamed:@"not_data"];
        
        
        [self.view addSubview:_collectionView];
        
    }
    return _collectionView;
}


#pragma mark - UITableViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 0;
}

//设置collectionView 的Cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
 
    return nil;
}


@end
