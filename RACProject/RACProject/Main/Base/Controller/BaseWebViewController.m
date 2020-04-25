//
//  BaseWebViewController.m
//  LYGame
//
//  Created by 花花 on 2017/7/15.
//  Copyright © 2017年 花花. All rights reserved.
//

//webview到顶部的距离
#define TOP_MARGIN (self.isNeedNavBar?0:20)

#import "BaseWebViewController.h"
#import <WebKit/WebKit.h>
//#import "WYMTConfrimPayController.h"
//#import "WYConfirmPaymentController.h"
//#import "QFOrderViewController.h"
//#import "UIViewController+BackButtonHandler.h"
#import "BaseNavViewController.h"

//提供给h5的方法名
static NSString * const kJSFOpenPaymentName = @"jsToiOS";
// 添加到User-Agent的尾部  给h5做识别
static NSString * const kIPHONEWOYINAPP = @"IPHONEWOYINAPP";

@interface BaseWebViewController ()<WKNavigationDelegate,WKUIDelegate,NSURLConnectionDelegate,WKScriptMessageHandler>

@property (strong, nonatomic) WKWebView *wkWebView;
@property (strong, nonatomic) UIProgressView *progressView;

@end

@implementation BaseWebViewController

//- (instancetype)init{
//    self = [super init];
//    if (self){
////        self.isNeedNavBar = YES;
//    }
//    return self;
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    [self.view addSubview:self.wkWebView];
//    [self.view addSubview:self.progressView];
//    [self loadRequest];
//}
//
//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    [self needResetBackItem];
//}
//
//- (void)backItemClick{
//    if ([self.wkWebView canGoBack]) {
//        [self.wkWebView goBack];
//    }else{
//        [super backItemClick];
//    }
//}
//
//- (void)loadRequest{
////    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kAppUrl]];
////    //设置请求类型
////    [request setHTTPMethod:@"GET"];
////    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//
//    //WKWebview 添加User-Agent 尾部添加IPHONEWOYINAPP
//    if (@available(iOS 12.0, *)) {
//        NSString *baseAgent = [self.wkWebView valueForKey:@"applicationNameForUserAgent"];
//        NSString *userAgent = [NSString stringWithFormat:@"%@ %@",baseAgent,kIPHONEWOYINAPP];
//        [self.wkWebView setValue:userAgent forKey:@"applicationNameForUserAgent"];
//    }
//    
//    WeakSelf;
//    [self.wkWebView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
//        NSString *oldAgent = result;
//        if ([oldAgent rangeOfString:kIPHONEWOYINAPP].location != NSNotFound) {
//            return ;
//        }
//        NSString *newAgent = [NSString stringWithFormat:@"%@ %@", oldAgent, kIPHONEWOYINAPP];
//        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:newAgent, @"UserAgent", nil];
//        [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        if (@available(iOS 9.0, *)) {
//            [weakSelf.wkWebView setCustomUserAgent:newAgent];
//        } else {
//            [weakSelf.wkWebView setValue:newAgent forKey:@"applicationNameForUserAgent"];
//        }
//    }];
//    
//    [self.wkWebView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//        NSLog(@"userAgent :%@", result);
//    }];
//}
//
//- (void)loadHttpRequestWithUrl:(NSString*)url{
//    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
//}
//
//- (void)loadLocalHtmlString:(NSString *)htmlContent andBaseURL:(NSURL *)url{
//    [self.wkWebView loadHTMLString:htmlContent baseURL:url];
//}
//
//#pragma mark - <WKScriptMessageHandler>
//- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
//    NSLog(@"-----messageName:%@\n---messageBody:%@\n",message.name,message.body);
//    NSLog(@"class:%@",[message.body class]);
//    /**
//     //orderNo 美团返回的是thirdPayOrderId 袋鼠返回的是orderNo
//     //美团
//     {"actionType":"meituanpay","thirdPayOrderId":"2019112516181125971","fee":"0","totalAmt":"3600","businessType":"1601"}
//     //袋鼠健康
//     {"actionType":"meituanpay","orderNo":"2019112517274882102","fee":"1","totalAmt":"11","businessType":"2201"}
//     */
//    //    himalayaOAuth
//    
//    if ([message.name isEqualToString:kJSFOpenPaymentName]) {
//        NSData *jsonData = [message.body dataUsingEncoding:NSUTF8StringEncoding];
//        NSError *err;
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData  options:NSJSONReadingMutableContainers  error:&err];
//        if(err) {/*JSON解析失败*/
//            return;
//        }
//        
//        if ([dic[@"actionType"] isEqualToString:@"himalayaOAuth"]) {
//            [self bingXMLY:dic];
//        }
//        else{
////            WYMTConfrimPayMdel *model = [WYMTConfrimPayMdel mj_objectWithKeyValues:[message.body mj_JSONString]];
////            WYConfirmPaymentController *vc = [[WYConfirmPaymentController alloc]init];
////            NSString *body  = [QFDefalutDataTool getbodyWithRechargeTpe:[self getTypeWithBusinessType:model.businessType]];
////            [vc setupCurrentIntegral:model.totalAmt totalIntegral:nil orderNo:model.thirdPayOrderId?:model.orderNo rechargeType:[model.businessType integerValue] body:body orderType:WYPayOrderTypeFictitious];
////            [self.navigationController pushViewController:vc animated:YES];
//        }
//    }
//}
//
//-(void)bingXMLY:(NSDictionary *)dict{
//    NSMutableDictionary *parmaDict = [NSMutableDictionary dictionary];
//    parmaDict[@"timestamp"] = [NSString getNowTimeTimestamp];
//    parmaDict[@"client_os_type"] = @"1";
//    parmaDict[@"code"] = dict[@"code"];
//    
//    NSString *signStr = [NSString stringWithFormat:@"key=%@&timestamp=%@",kSignKey, parmaDict[@"timestamp"]];
//    parmaDict[@"sign"] = [signStr MD5];
//    [MBProgressHUD LY_ShowHUD:YES];
//    WeakSelf;
//    [HTTPRequest POST:kXMLYAccessTokendUrl parameter:parmaDict success:^(id resposeObject) {
//        if(Success){
//            [weakSelf realBingXMLY:resposeObject[@"data"]];
//        }else{
//            [MBProgressHUD LY_ShowError:resposeObject[@"msg"] time:2.0];
//        }
//    } failure:^(NSError *error) {
//        [MBProgressHUD LY_ShowError:kNoNetworkTips time:1.0];
//    }];
//}
//
//-(void)realBingXMLY:(NSString *)accessToken{
//    NSMutableDictionary *parmaDict = [NSMutableDictionary dictionary];
//    parmaDict[@"timestamp"] = [NSString getNowTimeTimestamp];
//    parmaDict[@"client_os_type"] = @"1";
//    parmaDict[@"access_token"] = accessToken;
//    parmaDict[@"type"] = @"1";
//    
//    NSString *signStr = [NSString stringWithFormat:@"key=%@&timestamp=%@",kSignKey, parmaDict[@"timestamp"]];
//    parmaDict[@"sign"] = [signStr MD5];
//
//    WeakSelf;
//    [HTTPRequest POST:kXMLYThirdUidBindUrl parameter:parmaDict success:^(id resposeObject) {
//        if(Success){
//            [MBProgressHUD LY_ShowError:@"绑定成功" time:2.0];
//            [weakSelf.navigationController popViewControllerAnimated:YES];
//        }else{
//            [MBProgressHUD LY_ShowError:resposeObject[@"msg"] time:2.0];
//        }
//    } failure:^(NSError *error) {
//        [MBProgressHUD LY_ShowError:kNoNetworkTips time:1.0];
//    }];
//}
//
//- (QFRechargeType)getTypeWithBusinessType:(NSString *)businessType{
//    NSInteger  rechargeType = 0;
//    if ([businessType hasPrefix:@"16"]) {
//        rechargeType = QFRechargeTypeWaiMai;
//    }
//    else if ([businessType hasPrefix:@"19"]){
//        rechargeType =  QFRechargeTypeJiuDian;
//    }
//    else if ([businessType hasPrefix:@"20"]){
//        rechargeType = QFRechargeTypeCanYin;
//    }
//    else if ([businessType hasPrefix:@"21"]){
//        rechargeType = QFRechargeTypeDianYinPiao;
//    }
//    else if ([businessType hasPrefix:@"22"]){
//        rechargeType = QFRechargeTypeDaiShuJianKang;
//    }
//    else if ([businessType hasPrefix:@"23"]){
//        rechargeType = QFRechargeTypeCaocaoChuXing;
//    }
//    else if ([businessType hasPrefix:@"28"]){
//        rechargeType = QFRechargeTypeShiFuBang;
//    }
//    else {
//        rechargeType =  QFRechargeTypeJiaFu; //15开头的都属于嘉福
//    }
//    return rechargeType;
//}
//
//#pragma mark - WKWebViewDelegate
//
//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{ // 类似  的 －webViewDidFinishLoad:
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//}
//
//- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//}
//
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
//    decisionHandler(WKNavigationResponsePolicyAllow);
//}
//
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//    // 类似  的 -webView: shouldStartLoadWithRequest: navigationType:
//    NSString * urlStr = navigationAction.request.URL.absoluteString;
//    NSLog(@"------urlStr:%@",urlStr);
//    BOOL isAllow = YES;
//    if ([self.forbiddenUrls containsObject:urlStr]) {
//        isAllow = NO;
//    }else{
//        if ([urlStr hasPrefix:@"http://"]||[urlStr hasPrefix:@"https://"]) {
//            isAllow = [self loadingUrl:urlStr];
//        }
//    }
//    decisionHandler(isAllow);
//}
//
//- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{ // 类似的 -webViewDidStartLoad:
//    NSLog(@"didStartProvisionalNavigation");
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//}
//
//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
//{
//    // 创建 NSURLCredential 对象
//    NSURLCredential *newCred = [NSURLCredential credentialWithUser:@"123"
//                                                          password:@"123"
//                                                       persistence:NSURLCredentialPersistenceNone];
//    completionHandler(NSURLSessionAuthChallengeUseCredential,newCred);
//}
//
////WkWebView的progress 回调
//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
//    NSLog(@"keyPath%@======",keyPath);
//    if([keyPath isEqualToString:@"estimatedProgress"])
//    {
//        double estimatedProgress = [change[NSKeyValueChangeNewKey] doubleValue];
//        [self loadPropress:estimatedProgress];
//    }else if ([keyPath isEqualToString:@"title"]) {
//        if (object == self.wkWebView) {
//            self.title = self.wkWebView.title;
//        } else {
//            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//        }
//    } else {
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//    }
//}
//
//- (BOOL)loadingUrl:(NSString *)url{
//    return YES;
//}
//
//- (void)loadPropress:(double)propress{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        if (propress >= 1) {
//            self.progressView.hidden = YES;
//            [self.progressView setProgress:0 animated:NO];
//        }else {
//            self.progressView.hidden = NO;
//            [self.progressView setProgress:propress animated:YES];
//        }
//    });
//}
//
//- (WKWebView * )wkWebView{
//    if (!_wkWebView){
//        WKWebViewConfiguration *configuretion = [[WKWebViewConfiguration alloc] init];
//        configuretion.allowsInlineMediaPlayback = YES;
//        if (@available(iOS 9.0, *)) {
//            configuretion.requiresUserActionForMediaPlayback = false;
//        } else {
//            // Fallback on earlier versions
//        }
//        
//        [configuretion.userContentController addScriptMessageHandler:self name:kJSFOpenPaymentName];
//        
//        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0,kNavHeight, Screen_Width,Screen_Height-kNavHeight) configuration:configuretion];
//        _wkWebView.navigationDelegate = self;
//        _wkWebView.UIDelegate = self;
//        [_wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
//        [_wkWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
//        [self.view insertSubview:_wkWebView belowSubview:self.progressView];
//    }
//    return _wkWebView;
//}
//
//- (UIProgressView *)progressView {
//    if(!_progressView) {
//        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, kNavHeight, Screen_Width, 2)];
//        _progressView.tintColor = [UIColor colorWithHexString:@"0099FF"];
//        _progressView.trackTintColor = [UIColor whiteColor];
//    }
//    return _progressView;
//}
//
//- (void)dealloc{
//    [_wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
//    [_wkWebView removeObserver:self forKeyPath:@"title"];
//    _wkWebView.navigationDelegate = nil;
//    _wkWebView.UIDelegate = nil;
//}

@end
