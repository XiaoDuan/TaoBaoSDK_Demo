//
//  ItemsGetRequest.m
//  TaoBao
//
//  Created by Wang Dave on 11-8-26.
//  Copyright 2011年 DaveDev. All rights reserved.
//

#import "ItemsGetRequest.h"
@implementation ItemsGetRequest
@synthesize fields,cid;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
-(NSString*) getApiMethodName{
    return @"taobao.items.get";
}
-(NSDictionary*) getTextParams{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:fields forKey:@"fields"];
    [dic setObject:cid forKey:@"cid"];
    return dic;
}
- (void)dealloc 
{
    [super dealloc];
    fields = nil;
	cid = nil;
 
    [cid release];
    [fields release];
 
}
@end

