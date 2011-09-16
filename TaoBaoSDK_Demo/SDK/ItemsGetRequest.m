//
//  ItemsGetRequest.m
//  TaoBao
//
//  Created by Wang Dave on 11-8-26.
//  Copyright 2011年 DaveDev. All rights reserved.
//

#import "ItemsGetRequest.h"
@implementation ItemsGetRequest
@synthesize fields,cid,page_size,page_no,q;

- (id)init
{
    self = [super init];
    if (self) {
        if (!page_size)
            page_size = [[NSString alloc] initWithFormat:@"%d",LOCAL_PAGE_SIZE];
          
        if (!page_no) 
            page_no = [[NSString alloc] initWithFormat:@"%d",1];
        if(!q)
            q = [[NSString alloc] initWithFormat:@""];
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
    [dic setObject:page_size forKey:@"page_size"];
    [dic setObject:page_no forKey:@"page_no"];
    [dic setObject:q forKey:@"q"];
    return dic;
}
- (void)dealloc 
{
    [super dealloc];
    fields = nil;
	cid = nil;
    page_size =nil;
    page_no = nil;
    q = nil;
 
    [cid release];
    [fields release];
    [page_size release];
    [page_no release];
    [q release];
}
@end

