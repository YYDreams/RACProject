//
//  HHRefreshAutoFooter.m
//  SamClub
//
//  Created by flowerflower on 2020/4/25.
//  Copyright © 2020 flowerflower. All rights reserved.
//

#import "HHRefreshAutoFooter.h"
#import <Lottie/Lottie.h>

@interface HHRefreshAutoFooter ()

@property (nonatomic, strong) UIView *dashOne;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIView *dashTwo;

//@property (nonatomic, strong) UIActivityIndicatorView *loadingView;
@property (nonatomic, strong) LOTAnimationView *loadingView;

@end

@implementation HHRefreshAutoFooter

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.stateLabel.alpha = 0;
        
        self.dashOne = [UIView new];
        self.dashOne.size = CGSizeMake(28, 0.5);
        self.dashOne.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.dashOne];
        
        self.dashTwo = [UIView new];
        self.dashTwo.size = CGSizeMake(28, 0.5);
        self.dashTwo.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.dashTwo];
        
        self.textLabel = [[UILabel alloc] init];
        self.textLabel.font = [UIFont systemFontOfSize:13];
        self.textLabel.textColor = [UIColor colorWithHex:0x9B9B9B];
        [self addSubview:self.textLabel];
        
        // 父类已经调用过setState
        self.textLabel.text = self.stateLabel.text;
        [self.textLabel sizeToFit];
        
        //        self.loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        //        self.loadingView.tintColor = [UIColor yn_warmGreyColor];
        //        [self addSubview:self.loadingView];
        self.loadingView = [LOTAnimationView animationNamed:@"loading_mini"];
        self.loadingView.size = CGSizeMake(20, 20);
        self.loadingView.loopAnimation = YES;
        [self addSubview:self.loadingView];
    }
    return self;
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    self.textLabel.center = CGPointMake(self.width / 2.0,
                                        (self.height - self.bottomInset)/ 2.0);
    
    self.dashOne.right = self.textLabel.left - 12;
    self.dashOne.centerY = self.textLabel.centerY;
    
    self.dashTwo.left = self.textLabel.right + 12;
    self.dashTwo.centerY = self.textLabel.centerY;
    
    self.loadingView.center = self.textLabel.center;
}

- (void)setTitle:(NSString *)title forState:(MJRefreshState)state
{
    [super setTitle:title forState:state];
    
    if (self.state == state) {
        self.textLabel.text = self.stateLabel.text;
        [self.textLabel sizeToFit];
    }
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    self.textLabel.text = self.stateLabel.text;
    [self.textLabel sizeToFit];
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        if (oldState == MJRefreshStateRefreshing) {
            self.dashOne.hidden = NO;
            self.textLabel.hidden = NO;
            self.dashTwo.hidden = NO;
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
        
        //        [self.loadingView startAnimating];
        [self.loadingView play];
    } else if (state == MJRefreshStateNoMoreData) {
        self.dashOne.hidden = NO;
        self.textLabel.hidden = NO;
        self.dashTwo.hidden = NO;
        
        //        [self.loadingView stopAnimating];
        [self.loadingView stop];
    }
}


@end
