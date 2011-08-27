//
//  Utils.m
//  TaoBao
//
//  Created by Wang Dave on 11-8-26.
//  Copyright 2011年 DaveDev. All rights reserved.
//

#import "Utils.h"

@implementation Utils

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+ (NSString *)getMD5FromString:(NSString *)source{
    const char *src = [source UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(src, strlen(src), result);
    NSString *ret = [[[NSString alloc] initWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                      result[0], result[1], result[2], result[3],
                      result[4], result[5], result[6], result[7],
                      result[8], result[9], result[10], result[11],
                      result[12], result[13], result[14], result[15]
                      ] autorelease];
    
    return [ret uppercaseString]; 
}
+ (NSString *)getCurrentTimeStamp{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [NSDate date]; 
    
    return [dateFormatter stringFromDate:date];
} 
+(NSString*)signTopRequestNew:(RequestParametersHolder*) requestHolder  andSecret:(NSString*) secret
{
    NSMutableDictionary *sortedParams = [NSMutableDictionary dictionaryWithCapacity:10];
    [sortedParams addEntriesFromDictionary:requestHolder.applicationParams];
    [sortedParams addEntriesFromDictionary:requestHolder.protocalMustParams];
    [sortedParams addEntriesFromDictionary:requestHolder.protocalOptParams];
    NSMutableString *stringBuffer = [NSMutableString stringWithCapacity:20];
    [stringBuffer appendString:secret];
    for (NSString *key in  [[sortedParams allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]) 
    {
        [stringBuffer appendFormat:@"%@%@",key,[sortedParams objectForKey:key]];
    }
    //NSLog(@"%@",stringBuffer);
    [stringBuffer appendString:secret];
    return [Utils getMD5FromString:stringBuffer];
}

+(NSString*)buildQuery:(NSMutableDictionary*) params
{
    if (params == nil) {
        return nil;
    }
    BOOL hasParam = false;
    NSMutableString *query = [NSMutableString stringWithCapacity:10];
    
    for ( NSString *key in  [params allKeys])
    {
        if (hasParam) {
            [query appendFormat:@"&"];
        }else{
            hasParam = true;
        }
        [query appendFormat:@"%@=%@", key,
         [(NSString*)[params objectForKey:key] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
        
         
    }
    
    return [query description];
}

 


@end
