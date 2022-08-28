//
//  MYURLProtocol.m
//  GrassIosSamples
//
//  Created by grassswwang on 2022/8/28.
//

#import "MYURLProtocol.h"

@implementation MYURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    NSLog(@"[grass][canInitWithRequest] url:%@", request.URL.absoluteString);
    return NO;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    NSLog(@"[grass][canonicalRequestForRequest] url:%@", request.URL.absoluteString);
    return request;
}

- (void)startLoading {
    [super startLoading];
    NSLog(@"[grass][startLoading] request:%@", self.request.URL.absoluteString);
}

- (void)stopLoading {
    [super stopLoading];
    NSLog(@"[grass][startLoading] request:%@", self.request.URL.absoluteString);
}

@end
