/* 
 * Copyright 2018 Christian-W. Budde
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "WKWebViewInjectCookie.h"
#import <WebKit/WebKit.h>
#import <Cordova/CDV.h>

@implementation WKWebViewInjectCookie

- (void)injectCookie:(CDVInvokedUrlCommand *)command {

    self.callbackId = command.callbackId;

    NSString *domain = command.arguments[0];
    NSString *path = command.arguments[1];
    NSString *name = command.arguments[2];
    NSString *value = command.arguments[3];
    NSString *secure = command.arguments[4];
    NSString *maxAge = command.arguments[5];
    
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    [cookieProperties setObject:name forKey:NSHTTPCookieName];
    [cookieProperties setObject:value forKey:NSHTTPCookieValue];
    [cookieProperties setObject:path forKey:NSHTTPCookiePath];
    [cookieProperties setObject:domain forKey:NSHTTPCookieDomain];
    [cookieProperties setObject:secure forKey:NSHTTPCookieSecure];
    [cookieProperties setObject:maxAge forKey:NSHTTPCookieMaximumAge];
    
    NSHTTPCookie * cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];

    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];

}

@end
