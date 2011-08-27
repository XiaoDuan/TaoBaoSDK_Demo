//
//  Utils.h
//  TaoBao
//
//  Created by Wang Dave on 11-8-26.
//  Copyright 2011年 DaveDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import "RequestParametersHolder.h"
@interface Utils : NSObject
+ (NSString *)getCurrentTimeStamp;
+(NSString*)signTopRequestNew:(RequestParametersHolder*) requestHolder andSecret:(NSString*) secret;
+ (NSString *)getMD5FromString:(NSString *)source;
+(NSString*)buildQuery:(NSMutableDictionary*) params;
@end
