//
//  SWWKWebViewController.m
//  GrassIosSamples
//
//  Created by grassswwang(王圣伟) on 2021/1/11.
//

#import "SWWKWebViewController.h"
#import <WebKit/WebKit.h>

/// 控件高度
#define kSearchBarH  44
#define kBottomViewH 44
/// 屏幕大小尺寸
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

const static NSString *LOGTAG = @"wkwebview";

@interface SWWKWebViewController ()<UISearchBarDelegate, WKNavigationDelegate>
@property (nonatomic, strong) UISearchBar *searchBar;
/// 网页控制导航栏
@property (weak, nonatomic) UIView *bottomView;
@property (nonatomic, strong) WKWebView *wkWebView;
@property (weak, nonatomic) UIButton *backBtn;
@property (weak, nonatomic) UIButton *forwardBtn;
@property (weak, nonatomic) UIButton *reloadBtn;
@property (weak, nonatomic) UIButton *browserBtn;
@property (weak, nonatomic) NSString *baseURLString;
@end

@implementation SWWKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self simpleExampleTest];
    [self addSubViews];
    [self refreshBottomButtonState];
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com/"]]];
}

- (void)addSubViews {
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.wkWebView];
    [self addBottomViewButtons];
}

- (void)addBottomViewButtons {
    // 记录按钮个数
    int count = 0;

    UIButton *button = [self buildButton:@"back" clickListener:@selector(onBottomButtonsClicled:) tag:++count];
    [self.bottomView addSubview:button];
    self.backBtn = button;
    
    button = [self buildButton:@"forward" clickListener:@selector(onBottomButtonsClicled:) tag:++count];
    [self.bottomView addSubview:button];
    self.forwardBtn = button;
    
    button = [self buildButton:@"reload" clickListener:@selector(onBottomButtonsClicled:) tag:++count];
    [self.bottomView addSubview:button];
    self.reloadBtn = button;
    
    button = [self buildButton:@"Safari" clickListener:@selector(onBottomButtonsClicled:) tag:++count];
    [self.bottomView addSubview:button];
    self.browserBtn = button;
    
    // 统一设置frame
    [self setupBottomViewLayout];
}


- (void)setupBottomViewLayout{
    int count = 4;
    CGFloat btnW = 80;
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

/// 按钮点击事件
- (void)onBottomButtonsClicled:(UIButton *)sender {
    switch (sender.tag) {
        case 1:{
            [self.wkWebView goBack];
            [self refreshBottomButtonState];
        }
            break;
        case 2:{
            [self.wkWebView goForward];
            [self refreshBottomButtonState];
        }
            break;
        case 3:
            [self.wkWebView reload];
            break;
        case 4:
            [[UIApplication sharedApplication] openURL:self.wkWebView.URL];
            break;
        default:
            break;
    }
}

#pragma mark - WKWebView WKNavigationDelegate 相关
/// 是否允许加载网页 在发送请求之前，决定是否跳转
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

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"%@_%s",LOGTAG,__func__);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    NSLog(@"%@_%s",LOGTAG,__func__);
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(nonnull NSError *)error{
    NSLog(@"%@_%s",LOGTAG,__func__);
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
        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20 + kSearchBarH, kScreenWidth, kScreenHeight - 20 - kSearchBarH - kBottomViewH)];
        webView.navigationDelegate = self;
        //                webView.scrollView.scrollEnabled = NO;
        //        webView.backgroundColor = [UIColor colorWithPatternImage:self.image];
        // 允许左右划手势导航，默认允许
        webView.allowsBackForwardNavigationGestures = YES;
        _wkWebView = webView;
    }
    return _wkWebView;
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

#pragma mark - 测试例子
- (void)simpleExampleTest {
    // 1.创建webview，并设置大小，"20"为状态栏高度
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20)];
    // 2.创建请求
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com/"]];
    //    // 3.加载网页
    [webView loadRequest:request];
    //    [webView loadFileURL:[NSURL fileURLWithPath:@"/Users/userName/Desktop/bigIcon.png"] allowingReadAccessToURL:[NSURL fileURLWithPath:@"/Users/userName/Desktop/bigIcon.png"]];
    // 最后将webView添加到界面
    [self.view addSubview:webView];
}

/// 模拟器加载mac本地文件
- (void)loadLocalFile {
    // 1.创建webview，并设置大小，"20"为状态栏高度
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20)];
    // 2.创建url  userName：电脑用户名
    NSURL *url = [NSURL fileURLWithPath:@"/Users/userName/Desktop/bigIcon.png"];
    // 3.加载文件
    [webView loadFileURL:url allowingReadAccessToURL:url];
    // 最后将webView添加到界面
    [self.view addSubview:webView];
}

@end
