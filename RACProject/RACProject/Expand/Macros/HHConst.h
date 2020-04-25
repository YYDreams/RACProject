#import <UIKit/UIKit.h>


//间隙
UIKIT_EXTERN CGFloat margin;


//间隙
UIKIT_EXTERN CGFloat margin_12;

//底部按钮的高度
UIKIT_EXTERN NSInteger kBottomHeight;


/*---------------------------------通知 ---------------------------------*/


//退出账号
UIKIT_EXTERN NSString  * const kLogoutNotification;
//登陆成功
UIKIT_EXTERN NSString  * const kLoginSuccessNotification;

// ali 支付完成通知
UIKIT_EXTERN NSString  * const kAliPayCompleteNotification;
// wechat 支付完成通知
UIKIT_EXTERN NSString  * const kWeChatPayCompleteNotification;

/*--------------------------------弹框提示---------------------------------*/

UIKIT_EXTERN NSString  * const kAwaitTips;


/*----------------------------------网络提示----------------------------------*/
//网络断开的提示语
UIKIT_EXTERN NSString  * const kNoNetworkTips;





/*----------------------------------枚举----------------------------------*/
//   payType 1 积分支付 2 微信支付、支付宝 3组合支付
typedef NS_ENUM(NSInteger,WYPayMentType){
    WYPayMentTypeIntegral = 1,
    WYPayMentTypeWechatOrAlipay = 2,
    WYPayMentTypeCombination = 3,
    
};



typedef NS_ENUM(NSInteger,PageStatus) {
    
    PageStatusLoading,
    PageStatusError,
    PageStatusSucceed
};


//单例创建
#undef    AS_SINGLETON
#define AS_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef    DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}



