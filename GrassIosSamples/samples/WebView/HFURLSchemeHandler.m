//
//  HFURLSchemeHandler.m
//  GrassIosSamples
//
//  Created by grassswwang on 2022/8/28.
//

#import "HFURLSchemeHandler.h"

@implementation HFURLSchemeHandler

- (void)webView:(WKWebView *)webView startURLSchemeTask:(id<WKURLSchemeTask>)urlSchemeTask{
    NSURLRequest *request = urlSchemeTask.request;
    NSString *urlStr = request.URL.absoluteString;
    
    if ([urlStr hasPrefix:@"file://"]) {
        // scheme切换回本地文件协议file://
        NSURLRequest *fileUrlRequest = [[NSURLRequest alloc] initWithURL:request.URL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:0];
        // 异步加载本地资源
        NSURLSession *session = [NSURLSession sharedSession];
        // 请求加载任务
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:fileUrlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                [urlSchemeTask didFailWithError:error];
            } else {
                NSDictionary *headerFields = @{
                    @"Content-Type": response.MIMEType,
                    @"Content-Length":[NSString stringWithFormat:@"%ld", data.length]
                };
                response = [[NSHTTPURLResponse alloc] initWithURL:request.URL statusCode:200 HTTPVersion:@"HTTP/1.1" headerFields:headerFields];
                
                // 将数据回传给webView
                [urlSchemeTask didReceiveResponse:response];
                [urlSchemeTask didReceiveData:data];
                [urlSchemeTask didFinish];
            }
        }];
        [dataTask resume];
    }
}
 
- (void)webView:(WKWebView *)webView stopURLSchemeTask:(id<WKURLSchemeTask>)urlSchemeTask {
    NSLog(@"stop = %@",urlSchemeTask);
    [urlSchemeTask didFinish];
}

@end
