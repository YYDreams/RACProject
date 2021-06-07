//
//  HHHudManager.m
//  RACProject
//
//  Created by flowerflower on 2021/5/29.
//  Copyright © 2021 flowerflower. All rights reserved.
//

#import "HHHudManager.h"
#import <MBProgressHUD/MBProgressHUD.h>
@implementation HHHudManager

+ (void)showHudWithText:(NSString *)text{
    [self showHudWithText:text toView:nil];
    
}

+ (void)showHudWithText:(NSString *)text toView:(UIView * _Nullable)view{
    
    if (!text.length) {return;}
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
     
     hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
     hud.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
     hud.mode = MBProgressHUDModeText;
     hud.label.text = text;
     hud.label.font = [UIFont systemFontOfSize:15];
     hud.label.textColor = [UIColor whiteColor];
     hud.label.numberOfLines = 0;
     hud.bezelView.layer.cornerRadius = 0;
     hud.margin = 12;
     hud.userInteractionEnabled = NO;
     [hud hideAnimated:YES afterDelay:1.5f];
    
}
@end
