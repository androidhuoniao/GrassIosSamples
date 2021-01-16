//
//  SWWKWebViewController.m
//  GrassIosSamples
//
//  Created by grassswwang(王圣伟) on 2021/1/11.
//

#import "SWWKWebViewController.h"
#import <WebKit/WebKit.h>
#import "QADLandingPageVRReporter.h"

/// 控件高度
#define kSearchBarH  44
#define kBottomViewH 44
/// 屏幕大小尺寸
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

const static NSString *LOGTAG = @"wkwebview";

typedef NS_ENUM(NSInteger,VIEWID){
    VIEWID_BACK = 0,
    VIEWID_FORWARD = 1,
    VIEWID_RELOAD = 2,
    VIEWID_CALLJS = 3,
    VIEWID_STOP_LOADING = 4,
};

@interface SWWKWebViewController ()<UISearchBarDelegate, WKNavigationDelegate, WKUIDelegate,WKScriptMessageHandler>
@property (nonatomic, strong) UISearchBar *searchBar;
/// 网页控制导航栏
@property (weak, nonatomic) UIView *bottomView;
@property (nonatomic, strong) WKWebView *wkWebView;
@property (weak, nonatomic) UIButton *backBtn;
@property (weak, nonatomic) UIButton *forwardBtn;
@property (weak, nonatomic) UIButton *reloadBtn;
@property (weak, nonatomic) UIButton *browserBtn;
@property (nonatomic,strong)UIButton *stoploadingBtn;
@property (weak, nonatomic) NSString *baseURLString;
@end

@implementation SWWKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubViews];
    [self refreshBottomButtonState];
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com/"]]];
    QADLandingPageVRReporter *reporter = [[QADLandingPageVRReporter alloc] init];
    [reporter onPageInterrupted];
}

- (void)addSubViews {
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.wkWebView];
    [self addBottomViewButtons];
}

- (void)addBottomViewButtons {
    UIButton *button = [self buildButton:@"back" clickListener:@selector(onBottomButtonsClicled:) tag:VIEWID_BACK];
    [self.bottomView addSubview:button];
    self.backBtn = button;
    
    button = [self buildButton:@"forward" clickListener:@selector(onBottomButtonsClicled:) tag:VIEWID_FORWARD];
    [self.bottomView addSubview:button];
    self.forwardBtn = button;
    
    button = [self buildButton:@"reload" clickListener:@selector(onBottomButtonsClicled:) tag:VIEWID_RELOAD];
    [self.bottomView addSubview:button];
    self.reloadBtn = button;
    
    button = [self buildButton:@"calljs" clickListener:@selector(onBottomButtonsClicled:) tag:VIEWID_CALLJS];
    [self.bottomView addSubview:button];
    self.browserBtn = button;
    
    // 停止加载
    button = [self buildButton:@"stop" clickListener:@selector(onBottomButtonsClicled:) tag:VIEWID_STOP_LOADING];
    [self.bottomView addSubview:button];
    self.stoploadingBtn = button;
    
    // 统一设置frame
    [self setupBottomViewLayout];
}


- (void)setupBottomViewLayout{
    int count = 5;
    CGFloat btnW = 70;
    CGFloat btnH = 30;
    CGFloat btnY = (self.bottomView.bounds.size.height - btnH) / 2;
    // 按钮间间隙
    CGFloat margin = (self.bottomView.bounds.size.width - btnW * count) / count;
    CGFloat btnX = margin * 0.5;
    self.backBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    btnX = self.backBtn.frame.origin.x + btnW + margin;
    self.forwardBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    btnX = self.forwardBtn.frame.origin.x + btnW + margin;
    self.reloadBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    btnX = self.reloadBtn.frame.origin.x + btnW + margin;
    self.browserBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    btnX = self.browserBtn.frame.origin.x + btnW + margin;
    self.stoploadingBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
}

/// 刷新按钮是否允许点击
- (void)refreshBottomButtonState {
    if ([self.wkWebView canGoBack]) {
        self.backBtn.enabled = YES;
    } else {
        self.backBtn.enabled = NO;
    }
    if ([self.wkWebView canGoForward]) {
        self.forwardBtn.enabled = YES;
    } else {
        self.forwardBtn.enabled = NO;
    }
}

#pragma click listener
/// 按钮点击事件
- (void)onBottomButtonsClicled:(UIButton *)sender {
    switch (sender.tag) {
        case VIEWID_BACK:{
            [self.wkWebView goBack];
            [self refreshBottomButtonState];
        }
            break;
        case VIEWID_FORWARD:{
            [self.wkWebView goForward];
            [self refreshBottomButtonState];
        }
            break;
        case VIEWID_RELOAD:
            [self.wkWebView reload];
            break;
        case VIEWID_CALLJS:
            [self evaluateJs];
            break;
        case VIEWID_STOP_LOADING:
            [self stopLoading];
            break;
        default:
            break;
    }
}


- (void)evaluateJs{
    //OC调用JS  changeColor()是JS方法名，completionHandler是异步回调block
    NSString *jsString = [NSString stringWithFormat:@"changeColor('%@')", @"Js参数"];
    [self.wkWebView evaluateJavaScript:jsString completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        NSLog(@"改变HTML的背景色");
    }];

    //改变字体大小 调用原生JS方法
    NSString *jsFont = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%d%%'", arc4random()%99 + 100];
    [self.wkWebView evaluateJavaScript:jsFont completionHandler:nil];
}


- (void)stopLoading{
    NSLog(@"%s isLoading:%i",__func__,self.wkWebView.isLoading);
    if (self.wkWebView.isLoading) {
        [self.wkWebView stopLoading];
    }
}


#pragma mark - WKWebView WKNavigationDelegate 相关
/// 是否允许加载网页 在发送请求之前，决定是否跳转
// 根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString *urlString = [[navigationAction.request URL] absoluteString];
    urlString = [urlString stringByRemovingPercentEncoding];
    //    NSLog(@"urlString=%@",urlString);
    // 用://截取字符串
    NSArray *urlComps = [urlString componentsSeparatedByString:@"://"];
    if ([urlComps count]) {
        // 获取协议头
        NSString *protocolHead = [urlComps objectAtIndex:0];
        NSLog(@"protocolHead=%@",protocolHead);
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"%@_%s",LOGTAG,__func__);
    
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"%@_%s",LOGTAG,__func__);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    NSLog(@"%@_%s",LOGTAG,__func__);
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(nonnull NSError *)error{
    NSLog(@"%@_%s error: %@",LOGTAG,__func__,error);
}

// 接收到服务器跳转请求即服务重定向时之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"%@_%s",LOGTAG,__func__);
    
}

//需要响应身份验证时调用 同样在block中需要传入用户身份凭证
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
//    NSLog(@"%@_%s",LOGTAG,__func__);
    //用户身份信息
    NSURLCredential * newCred = [[NSURLCredential alloc] initWithUser:@"user123" password:@"123" persistence:NSURLCredentialPersistenceNone];
    //为 challenge 的发送方提供 credential
    [challenge.sender useCredential:newCred forAuthenticationChallenge:challenge];
    completionHandler(NSURLSessionAuthChallengeUseCredential,newCred);
}

#pragma mark - WKWebView WKUIDelegate 相关
/**
     *  web界面中有弹出警告框时调用
     *
     *  @param webView           实现该代理的webview
     *  @param message           警告框中的内容
     *  @param completionHandler 警告框消失调用
     */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    NSLog(@"%@_%s",LOGTAG,__func__);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"HTML的弹出框" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
    // 确认框
    //JavaScript调用confirm方法后回调的方法 confirm是js中的确定框，需要在block中把用户选择的情况传递进去
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    NSLog(@"%@_%s",LOGTAG,__func__);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
    // 输入框
    //JavaScript调用prompt方法后回调的方法 prompt是js中的输入框 需要在block中把用户输入的信息传入
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    NSLog(@"%@_%s",LOGTAG,__func__);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
    // 页面是弹出窗口 _blank 处理
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    NSLog(@"%@_%s",LOGTAG,__func__);
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

#pragma mark - 监听进度
//kvo 监听进度 必须实现此方法
-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                      context:(void *)context{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]
        && object == self.wkWebView) {
        NSLog(@"网页加载进度 = %f",self.wkWebView.estimatedProgress);
//        NSLog(@"%@_%s 网页加载进度 = %f",LOGTAG,__func__,self.wkWebView.estimatedProgress);
//        self.progressView.progress = self.wkWebView.estimatedProgress;
        if (self.wkWebView.estimatedProgress >= 1.0f) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                self.progressView.progress = 0;
            });
        }
    }else if([keyPath isEqualToString:@"title"]
             && object == self.wkWebView){
//        NSLog(@"%@_%s title: %@",LOGTAG,__func__,self.wkWebView.title);
        self.navigationItem.title = self.wkWebView.title;
    }else{
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}

#pragma mark WKScriptMessageHandler
//通过接收JS传出消息的name进行捕捉的回调方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"%@_%s",LOGTAG,__func__);
    NSLog(@"userContentController name:%@\\\\n body:%@\\\\n frameInfo:%@\\\\n",message.name,message.body,message.frameInfo);
    //用message.body获得JS传出的参数体
    NSDictionary * parameter = message.body;
    //JS调用OC
    if([message.name isEqualToString:@"jsToOcNoPrams"]){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"js调用到了oc" message:@"不带参数" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }else if([message.name isEqualToString:@"jsToOcWithPrams"]){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"js调用到了oc" message:parameter[@"params"] preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark - searchBar代理方法
/// 点击搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    // 创建url
    NSURL *url = nil;
    NSString *urlStr = searchBar.text;
    // 如果file://则为打开bundle本地文件，http则为网站，否则只是一般搜索关键字
    if([urlStr hasPrefix:@"file://"]){
        NSRange range = [urlStr rangeOfString:@"file://"];
        NSString *fileName = [urlStr substringFromIndex:range.length];
        url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
        // 如果是模拟器加载电脑上的文件，则用下面的代码
        //        url = [NSURL fileURLWithPath:fileName];
    }else if(urlStr.length>0){
        if ([urlStr hasPrefix:@"http://"]) {
            url=[NSURL URLWithString:urlStr];
        } else {
            urlStr=[NSString stringWithFormat:@"http://www.baidu.com/s?wd=%@",urlStr];
        }
        urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        url=[NSURL URLWithString:urlStr];
    }
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    // 加载请求页面
    [self.wkWebView loadRequest:request];
}


#pragma mark - 懒加载
- (UIView *)bottomView {
    if (_bottomView == nil) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 240, kScreenWidth, kBottomViewH)];
        view.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
        [self.view addSubview:view];
        _bottomView = view;
    }
    return _bottomView;
}
- (UISearchBar *)searchBar {
    if (_searchBar == nil) {
        UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kSearchBarH)];
        searchBar.delegate = self;
        searchBar.text = @"http://www.cnblogs.com/mddblog/";
        _searchBar = searchBar;
    }
    return _searchBar;
}

- (WKWebView *)wkWebView {
    if (_wkWebView == nil) {
        CGRect frame = CGRectMake(0, 20 + kSearchBarH, kScreenWidth, kScreenHeight - 20 - kSearchBarH - kBottomViewH);
        WKWebView *webView = [[WKWebView alloc] initWithFrame:frame configuration:[self buildConfigration]];
       
        webView.navigationDelegate = self;
        // webView.scrollView.scrollEnabled = NO;
        // webView.backgroundColor = [UIColor colorWithPatternImage:self.image];
        // 允许左右划手势导航，默认允许
        webView.allowsBackForwardNavigationGestures = YES;
        webView.UIDelegate = self;
        //添加监测网页加载进度的观察者
        [webView addObserver:self
                           forKeyPath:@"estimatedProgress"
                              options:0
                              context:nil];
        //添加监测网页标题title的观察者
        [webView addObserver:self
                           forKeyPath:@"title"
                              options:NSKeyValueObservingOptionNew
                              context:nil];
        _wkWebView = webView;
    }
    return _wkWebView;
}

- (WKWebViewConfiguration *)buildConfigration{
    //创建网页配置对象
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    // 创建设置对象
    WKPreferences *preference = [[WKPreferences alloc]init];
    //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
    preference.minimumFontSize = 0;
    //设置是否支持javaScript 默认是支持的
    preference.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
    preference.javaScriptCanOpenWindowsAutomatically = YES;
    config.preferences = preference;
    
    // 是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
    config.allowsInlineMediaPlayback = YES;
    
    //设置是否允许画中画技术 在特定设备上有效
    config.allowsPictureInPictureMediaPlayback = YES;
    //设置请求的User-Agent信息中应用程序名称 iOS9后可用
    config.applicationNameForUserAgent = @"ChinaDailyForiPad";
    
    //这个类主要用来做native与JavaScript的交互管理
    WKUserContentController * wkUController = [[WKUserContentController alloc] init];
    //注册一个name为jsToOcNoPrams的js方法
    [wkUController addScriptMessageHandler:self  name:@"jsToOcNoPrams"];
    [wkUController addScriptMessageHandler:self  name:@"jsToOcWithPrams"];
    config.userContentController = wkUController;
    
    //以下代码适配文本大小，由UIWebView换为WKWebView后，会发现字体小了很多，这应该是WKWebView与html的兼容问题，解决办法是修改原网页，要么我们手动注入JS
    NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    //用于进行JavaScript注入
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    [config.userContentController addUserScript:wkUScript];
    
    return config;
}


- (UIButton *)buildButton:(NSString *)title clickListener:(SEL)clickListener tag:(NSInteger) tag{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:249 / 255.0 green:102 / 255.0 blue:129 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    button.tag = tag;
    [button addTarget:self action:clickListener forControlEvents:UIControlEventTouchUpInside];
    return button;
}


@end
