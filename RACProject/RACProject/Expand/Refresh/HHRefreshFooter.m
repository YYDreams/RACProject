//
//  HHRefreshFooter.m
//  SamClub
//
//  Created by flowerflower on 2020/4/25.
//  Copyright © 2020 flowerflower. All rights reserved.
//

#import "HHRefreshFooter.h"

#import <Lottie/Lottie.h>

@interface HHRefreshFooter ()

@property (nonatomic, strong) UIView *dashOne;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIView *dashTwo;

@property (nonatomic, strong) UIImageView *noMoreView;

@property (nonatomic, strong) UILabel *refreshingLabel;

//@property (nonatomic, strong) UIActivityIndicatorView *loadingView;
@property (nonatomic, strong) LOTAnimationView *loadingView;

@end

@implementation HHRefreshFooter

+ (MJRefreshFooter *)HHRefreshFooter:(MJRefreshComponentRefreshingBlock)refreshingBlock
{
    return [self footerWithRefreshingBlock:refreshingBlock];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.stateLabel.alpha = 0;
        
        self.dashOne = [UIView new];
        self.dashOne.size = CGSizeMake(SC_DP_375(90), 0.5);
        self.dashOne.backgroundColor = [UIColor colorWithHex:0xDCE0E4];
        [self addSubview:self.dashOne];
        
        self.dashTwo = [UIView new];
        self.dashTwo.size = CGSizeMake(SC_DP_375(90), 0.5);
        self.dashTwo.backgroundColor = [UIColor colorWithHex:0xDCE0E4];
        [self addSubview:self.dashTwo];
        
        self.textLabel = [[UILabel alloc] init];
        self.textLabel.font = [UIFont systemFontOfSize:13];
        self.textLabel.textColor = [UIColor colorWithHex:0xACB1B6];
        [self addSubview:self.textLabel];
        
        // 父类已经调用过setState
        self.textLabel.text = self.stateLabel.text;
        [self.textLabel sizeToFit];
        
        self.refreshingLabel = [[UILabel alloc] init];
        self.refreshingLabel.font = [UIFont systemFontOfSize:13];
        self.refreshingLabel.textColor = [UIColor colorWithHex:0xACB1B6];
        [self addSubview:self.refreshingLabel];
        
        self.noMoreView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"no_more_pull"]];
        [self addSubview:self.noMoreView];
        
        // 父类已经调用过setState
        self.refreshingLabel.text = self.stateLabel.text;
        [self.refreshingLabel sizeToFit];
        self.refreshingLabel.hidden = YES;
        self.noMoreView.hidden = YES;
        
        //        self.loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        //        self.loadingView.tintColor = [UIColor gw_warmGreyColor];
        //        [self addSubview:self.loadingView];
        self.loadingView = [LOTAnimationView animationNamed:@"loading"];
        self.loadingView.size = CGSizeMake(30, 30);
        self.loadingView.loopAnimation = YES;
        [self addSubview:self.loadingView];
        self.loadingView.hidden = YES;
    }
    return self;
}

- (void)placeSubviews
{
    [super placeSubviews];
    self.textLabel.center = CGPointMake(self.width / 2.0,
                                        (self.height - self.bottomInset) / 2.0);
    
    self.noMoreView.center = CGPointMake(self.width / 2.0, (self.height - self.bottomInset) / 2.0);
    
    self.dashOne.right = self.textLabel.left - 16;
    self.dashOne.centerY = self.textLabel.centerY;
    
    self.dashTwo.left = self.textLabel.right + 16;
    self.dashTwo.centerY = self.textLabel.centerY;
    
    self.loadingView.right = self.textLabel.centerX;
    self.loadingView.centerY = self.textLabel.centerY;
    
    self.refreshingLabel.left = self.textLabel.centerX;
    self.refreshingLabel.centerY = self.textLabel.centerY;
}

- (void)setTitle:(NSString *)title forState:(MJRefreshState)state
{
    [super setTitle:title forState:state];
    
    if (self.state == state) {
        self.textLabel.text = self.stateLabel.text;
        [self.textLabel sizeToFit];
        
        self.refreshingLabel.text = self.stateLabel.text;
        [self.refreshingLabel sizeToFit];
    }
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    self.textLabel.text = self.stateLabel.text;
    [self.textLabel sizeToFit];
    self.refreshingLabel.text = self.stateLabel.text;
    [self.refreshingLabel sizeToFit];
    
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        if (oldState == MJRefreshStateRefreshing) {
            self.dashOne.hidden = NO;
            self.textLabel.hidden = NO;
            self.dashTwo.hidden = NO;
            self.noMoreView.hidden = YES;
            
            self.refreshingLabel.hidden = YES;
            self.loadingView.hidden = YES;
            [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                self.loadingView.alpha = 0.0;
            } completion:^(BOOL finished) {
                //                [self.loadingView stopAnimating];
                [self.loadingView stop];
                self.loadingView.alpha = 1.0;
            }];
        } else {
            // do nothing
        }
    } else if (state == MJRefreshStatePulling) {
        // do nothing
    } else if (state == MJRefreshStateRefreshing) {
        self.dashOne.hidden = YES;
        self.textLabel.hidden = YES;
        self.dashTwo.hidden = YES;
        self.noMoreView.hidden = YES;
        
        //        [self.loadingView startAnimating];
        self.refreshingLabel.hidden = NO;
        self.loadingView.hidden = NO;
        [self.loadingView play];
    } else if (state == MJRefreshStateNoMoreData) {
        self.dashOne.hidden = NO;
        self.textLabel.hidden = NO;
        self.dashTwo.hidden = NO;
        self.noMoreView.hidden = YES;
        
        //        [self.loadingView stopAnimating];
        [self.loadingView stop];
        self.loadingView.hidden = YES;
        self.refreshingLabel.hidden = YES;
        if (self.bottomInsetCalledBack) {
            self.bottomInsetCalledBack();
        }
    }
}

- (void)prepare
{
    [super prepare];
    
    // 初始化间距
    self.labelLeftInset = MJRefreshLabelLeftInset;
    
    // 初始化文字
    [self setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
    [self setTitle:@"松开加载更多" forState:MJRefreshStatePulling];
    [self setTitle:@"加载中" forState:MJRefreshStateRefreshing];
    [self setTitle:@"~我是有底线的~" forState:MJRefreshStateNoMoreData];
}

@end
