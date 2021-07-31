//
//  HHMacros.h
//  RACProject
//
//  Created by flowerflower on 2020/4/23.
//  Copyright © 2020 flowerflower. All rights reserved.
//

#ifndef HHMacros_h
#define HHMacros_h

#define Screen_Bounds [UIScreen mainScreen].bounds
#define Screen_Height [UIScreen mainScreen].bounds.size.height
#define Screen_Width [UIScreen mainScreen].bounds.size.width

#define SC_DP_375(size)   ((CGFloat)(size) / (375.0) * (MIN(Screen_Width, Screen_Height)))


// iPhone X系列判断
//#define  IS_iPhoneX (CGSizeEqualToSize(CGSizeMake(375.f, 812.f), [UIScreen mainScreen].bounds.size) || CGSizeEqualToSize(CGSizeMake(812.f,375.f), [UIScreen mainScreen].bounds.size)  || CGSizeEqualToSize(CGSizeMake(414.f,896.f), [UIScreen mainScreen].bounds.size) || CGSizeEqualToSize(CGSizeMake(896.f,414.f), [UIScreen mainScreen].bounds.size))

#define IS_iPhoneX ({\
BOOL isiPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
UIWindow *window = [UIApplication sharedApplication].delegate.window;\
if (window.safeAreaInsets.bottom > 0.0) {\
isiPhoneX = YES;\
}\
}\
isiPhoneX;\
})

/**
 
 非iPhone X ：
 StatusBar 高20px，NavigationBar 高44px，底部TabBar高49px
 iPhone X：
 StatusBar 高44px，NavigationBar 高44px，底部TabBar高83px
 */

// 状态栏高度`

#define StatusBarHeight (IS_iPhoneX ? 44.f : 20.f)


//#define kStatusHeight (IS_iPhoneX ? 0.f : 0.f)
// 导航栏高度
#define kNavHeight (IS_iPhoneX ? 88.f : 64.f)
// tabBar高度
#define kTabBarHeight (IS_iPhoneX ? 83 : 49.f)

// 安全区域高度`

#define kTabbarSafeBottomMargin     (IS_iPhoneX ? 34.f : 0.f)


/*上传APP Store用woyin20190916*/
//#define MAIN_URL @"http://portal.ewoyin.cn"
//#define kApiKey @"3fd27fbeef88dd998637b0a2406bd5e5"

/*上传Fir 正式环境用woyin20190918*/
//#define MAIN_URL @"http://portal.ewoyin.cn"
//#define kApiKey @"2e77b4b881eca2eeab9007f4e1f19280"
 
//上传Fir 测试环境用woyin20190916
#define MAIN_URL @"http://www.mocky.io/v2"


//#define MAIN_URL @"https://uatmer.ewoyin.com"
#define kApiKey @"3fd27fbeef88dd998637b0a2406bd5e5"

/*--------------------------------- key 相关----------------------------------*/


#define  Success [resposeObject[@"status] isEqualToString:@"000000]




/*----------------------------------字体 相关----------------------------------*/
// 系统字体大小定义
#define kFont(FontSize)    ([UIFont hhFontOfSize:FontSize])

#define kFontWithMedium(FontSize)    ([UIFont hhMediumFontOfSize:FontSize])
#define kFonWithLight(FontSize)    ([UIFont hhLightFontOfSize:FontSize])

#define kFontWithBold(FontSize)    [UIFont hhBoldFontOfSize:FontSize]


/*----------------------------------function 相关----------------------------------*/
// 设置view圆角
#define kViewRadius(view, radius)\
\
[view.layer setCornerRadius:(radius)];\
[view.layer setMasksToBounds:YES]

#define KImageNamed(name)\
 [UIImage imageNamed:name]


#define HHLocalizedString(s)                    NSLocalizedString(s, nil)//国际化字符串

//适配屏幕尺寸大小



#define WeakSelf __weak typeof(self) weakSelf = self


//打印
#if DEBUG
#define NSLog(fmt,...) NSLog((@"%s [Line %d]" fmt),__PRETTY_FUNCTION__,__LINE__,##__VA_ARGS__)
#else
#define NSLog(...)
#endif


/*----------------------------------color 相关----------------------------------*/
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b) RGBA(r, g, b, 1.0f)

//背景色  浅灰色
#define kBgColor [UIColor colorWithHex:0xF5F5F5]
//主色 浅红色  如导航栏、商品按钮
#define kThemeColor   [UIColor colorWithHex:0x00CBA6]

//辅主色
#define K2FF2CF  [UIColor colorWithHex:0x2FF2CF]

#define kRedColor  [UIColor colorWithHex:0xFD5A6A]

//辅色 蓝色 如我的页面图标
#define kBlueColor   [UIColor colorWithHex:0x39A1ED]

//文字  黑色 如导航、标题、正文
#define k3Color   [UIColor colorWithHex:0x333333]
//文字   浅灰色  如提示、正文
#define k6Color   [UIColor colorWithHex:0x666666]
//文字 浅灰色 如提示、正文
#define k9Color   [UIColor colorWithHex:0x999999]
//文字  白色
#define kfColor   [UIColor colorWithHex:0xffffff]
//分割线颜色
#define kSeparatedLineColor   [UIColor colorWithHex:0xDCDDDD]

#define kD0Color  [UIColor colorWithHex:0xD0D0D0]


#endif /* HHMacros_h */
