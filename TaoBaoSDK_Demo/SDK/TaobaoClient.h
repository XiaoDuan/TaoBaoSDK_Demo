//
//  TaobaoClient.h
//  TaoBao
//
//  Created by Dave on 11-8-14.
//  Copyright 2011年 DaveDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import <CommonCrypto/CommonDigest.h>
#import "SBJson.h"
#import "RequestParametersHolder.h"
#import "Utils.h"
#import "BaseRequest.h"

#define APP_KEY  @"app_key"
#define FORMAT  @"format"
#define METHOD  @"method"
#define TIMESTAMP  @"timestamp"
#define VERSION  @"v"
#define CURRENT_VERSION  @"2.0"
#define SIGN  @"sign"
#define SIGN_METHOD @"sign_method"
#define PARTNER_ID @"partner_id"
#define SESSION  @"session"
#define DATE_TIME_FORMAT  @"yyyy-MM-dd HH:mm:ss"
#define DATE_TIMEZONE  @"GMT+8"
#define CHARSET_UTF8  @"UTF-8"
#define FORMAT_JSON @"json"
#define FORMAT_XML @"xml"
#define SIGN_METHOD_MD5 @"md5"

#define DAVE_APP_KEY    @"12330971"
#define DAVE_APP_SECRET   @"115241acfb4d273327b635de4ab26906"
#define REAL_Platform_URL @"http://gw.api.taobao.com/router/rest"
#define SANDBOX_Platform_URL @"http://gw.api.tbsandbox.com/router/rest"
@interface TaobaoClient : NSObject {
    
    NSString *serverUrl;
	NSString *appKey;
	NSString *appSecret;
	NSString *format;
	NSString *signMethod;
    
}


@property(retain) NSString *serverUrl;
@property(retain) NSString *appKey;
@property(retain) NSString *appSecret;
@property(retain) NSString *format;
@property(retain) NSString *signMethod ;
-(id)initWithServerUrl:(NSString*) _serverUrl appKey:(NSString*) _appKey appSecret:(NSString*) _appSecret;  
-(NSString*) getQuery:(BaseRequest*) baseRequest;
-(NSDictionary*) execute:(BaseRequest*) request;

@end
