//
//  ItemsGetRequest.h
//  TaoBao
//
//  Created by Wang Dave on 11-8-26.
//  Copyright 2011年 DaveDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRequest.h"
#define LOCAL_PAGE_SIZE 50

@interface ItemsGetRequest : BaseRequest
{
    NSString *fields;
    NSString *cid;
    NSString *page_size;
    NSString *page_no;
    NSString *q;
}
@property(nonatomic,copy)  NSString *fields; 
@property(nonatomic,copy)  NSString *cid; 
@property(nonatomic,copy)  NSString *page_size; 
@property(nonatomic,copy)  NSString *page_no;
@property(nonatomic,copy)  NSString *q; 
@end 
