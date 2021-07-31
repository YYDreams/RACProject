//
//  HHRefreshHeader.m
//  SamClub
//
//  Created by flowerflower on 2020/4/25.
//  Copyright © 2020 flowerflower. All rights reserved.
//

#import "HHRefreshHeader.h"
#import <Lottie/Lottie.h>

@interface HHRefreshHeader ()

@property (nonatomic, strong) UILabel *hintLabel;
@property (nonatomic, strong) LOTAnimationView *loadingView;

@property (nonatomic, strong) UIImageView *textImage;

@end

@implementation HHRefreshHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.lastUpdatedTimeLabel.alpha = 0;
        self.stateLabel.alpha = 0;
        
        self.hintLabel = [[UILabel alloc] init];
        self.hintLabel.font = [UIFont systemFontOfSize:13];
        self.hintLabel.textColor = [UIColor grayColor];
        [self addSubview:self.hintLabel];
        
        self.hintLabel.text = self.stateLabel.text;
        [self.hintLabel sizeToFit];
        
        self.loadingView = [LOTAnimationView animationNamed:@"pull_loading_gray"];
        self.loadingView.size = CGSizeMake(120, 30);
        self.loadingView.loopAnimation = YES;
        [self addSubview:self.loadingView];
        
        self.textImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 112, 13)];
        self.textImage.image = [UIImage imageNamed:@"app_pullrefresh_text_gray"];
        [self addSubview:self.textImage];
    }
    return self;
}

- (void)prepare
{
    [super prepare];
    
    self.mj_h = 90;
    
    [self setTitle:@"" forState:MJRefreshStateIdle];
    [self setTitle:@"" forState:MJRefreshStatePulling];
    [self setTitle:@"" forState:MJRefreshStateRefreshing];
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    self.hintLabel.center = CGPointMake(self.width / 2.0,
                                        self.height / 2.0);
    
    self.loadingView.center = CGPointMake(self.width / 2.0, 30);
    
    self.textImage.center = CGPointMake(self.width / 2.0, self.height / 2.0);
    self.textImage.top = self.loadingView.bottom + 8;
}

- (void)setTitle:(NSString *)title forState:(MJRefreshState)state
{
    [super setTitle:title forState:state];
    
    if (self.state == state) {
        self.hintLabel.text = self.stateLabel.text;
        [self.hintLabel sizeToFit];
    }
}
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    self.hintLabel.text = self.stateLabel.text;
    [self.hintLabel sizeToFit];
    if (state == MJRefreshStateRefreshing) {
        [self.loadingView play];
    } else {
        if (oldState == MJRefreshStateRefreshing) {
            self.hintLabel.hidden = YES;
            [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                self.loadingView.alpha = 0;
                self.textImage.alpha = 0;
            } completion:^(BOOL finished) {
                self.hintLabel.hidden = NO;
                [self.loadingView stop];
                self.loadingView.alpha = 1.0;
                self.textImage.alpha = 1.0;
            }];
        }
    }
}

- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    [self.loadingView setProgressWithFrame:@(MIN(pullingPercent, 1.0) * 38)];
}


@end


