//
//  TaobaoClient.m
//  TaoBao
//
//  Created by Dave on 11-8-14.
//  Copyright 2011年 DaveDev. All rights reserved.
//

#import "TaobaoClient.h"


@implementation TaobaoClient
@synthesize serverUrl;
@synthesize appKey;
@synthesize appSecret;
@synthesize format;
@synthesize signMethod; 
- (void)dealloc 
{
    
    serverUrl = nil;
	appKey = nil;
	appSecret = nil;
	format = nil;
	signMethod = nil;
    [serverUrl release];
    [appKey release];
    [appSecret release];
    [format release];
    [signMethod release];
    [super dealloc];
}
 
-(id)initWithServerUrl:(NSString*) _serverUrl appKey:(NSString*) _appKey appSecret:(NSString*) _appSecret{
    self.serverUrl = _serverUrl;
    self.appKey = _appKey;
    self.appSecret = _appSecret;
    return self;
}
 
-(NSDictionary*) execute:(BaseRequest*) request
{
    NSURL *url = [NSURL URLWithString:[self getQuery:request]];
    ASIHTTPRequest *asiRequest = [ASIHTTPRequest requestWithURL:url];
    [asiRequest startSynchronous];
    NSError *error = [asiRequest error];
    if (!error) {
return [[asiRequest responseString] JSONValue];
    }
//    startAsynchronous ASIRequest
    
//    __block ASIHTTPRequest *asiRequest = [ASIHTTPRequest requestWithURL:url];
//    [request setCompletionBlock:^{
//        
//        NSDictionary *items = [[asiRequest responseString] JSONValue];
//        NSDictionary *urls = [items valueForKeyPath:@"items_get_response.items.item"] ;
//        interestingPhotosDictionary3 =  [urls retain];
//        // Hold onto the response dictionary.
//        //  [openFlow1 setNumberOfImages:[urls count]];
//        
//        // [openFlow2 setNumberOfImages:[urls count]];
//        
//        [openFlow3 setNumberOfImages:[urls count]];
//        
//    }];
//    [request setFailedBlock:^{
//        NSError *error = [asiRequest error];
//        NSLog(@"error = %@",error);
//    }];
//    [request startAsynchronous];
    return nil;
    
}
-(NSString*) getQuery:(BaseRequest*) baseRequest
{

    RequestParametersHolder *requestHolder = [[RequestParametersHolder alloc] init];
    NSMutableDictionary *appParams = [NSMutableDictionary dictionaryWithDictionary:[baseRequest getTextParams]];
    requestHolder.applicationParams = appParams;
     
    NSMutableDictionary *protocalMustParams = [NSMutableDictionary dictionaryWithCapacity:10];
    
    [protocalMustParams setObject:baseRequest.getApiMethodName forKey:METHOD];
    [protocalMustParams setObject:CURRENT_VERSION forKey:VERSION];
    [protocalMustParams setObject:appKey forKey:APP_KEY];
    [protocalMustParams setObject:[Utils getCurrentTimeStamp] forKey:TIMESTAMP];
    
    requestHolder.protocalMustParams = protocalMustParams;
    
    NSMutableDictionary *protocalOptParams = [NSMutableDictionary dictionaryWithCapacity:10];
    
    [protocalOptParams setObject:format forKey:FORMAT];
    
    [protocalOptParams setObject:signMethod forKey:SIGN_METHOD];
    
    requestHolder.protocalOptParams = protocalOptParams;
  
    [protocalMustParams setObject:[Utils signTopRequestNew:requestHolder andSecret:appSecret]  forKey:SIGN];
    
    NSMutableString *urlBuffer = [NSMutableString stringWithString:serverUrl] ;
    
    
    NSString *sysMustQuery = [Utils buildQuery:protocalMustParams];
    NSString *sysOptQuery = [Utils buildQuery:protocalOptParams];
    NSString *appQuery = [Utils buildQuery:appParams];
    [urlBuffer appendFormat:@"?"];
    [urlBuffer appendString:sysMustQuery];
     if (sysOptQuery!=NULL )   
     {
         [urlBuffer appendString:@"&"];
         [urlBuffer appendString:sysOptQuery];
     } 
    if (appQuery!=NULL )   
    {
        [urlBuffer appendString:@"&"];
        [urlBuffer appendString:appQuery];
    } 
    [requestHolder release];
    return urlBuffer;
}

 
@end
