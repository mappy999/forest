//
//  NetworkManager.m
//  Forest
//
//  Created by Mappy999 on 2017/11/08.
//

#import "NetworkManager.h"

@implementation NetworkManager

/*
 一時的にconfig返すだけのをお試しで
 */
+ (NSURLSessionConfiguration *)SessionConfiguration {
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSString * server_port = [Env getConfStringForKey:@"proxyServer" withDefault:@""];
    NSString * server = @"";
    NSNumber * port = @80;
    if ([Env getConfBOOLForKey:@"proxyEnable" withDefault:NO]) {
        NSArray<NSString *> *list = [server_port componentsSeparatedByString:@":"];
        if (list.count > 0)
        {
            server = list[0];
            if (list.count > 1)
            {
                port = [NSNumber numberWithInt:[list[1] intValue]];
            }
            sessionConfiguration.connectionProxyDictionary = @{(NSString *)kCFStreamPropertyHTTPProxyHost: server,
                                                           (NSString *)kCFStreamPropertyHTTPProxyPort: port,
                                                           (NSString *)kCFNetworkProxiesHTTPEnable: @YES};
        }
    }
    return sessionConfiguration;
}

- (void)test:(NSURLRequest *)request proc:(void(^)(void))block {

    NSURLSessionConfiguration *sessionConfiguration = [NetworkManager SessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        (void)block;
    }];
    [task resume];
}
@end
