//
//  ItemsGetRequest.h
//  TaoBao
//
//  Created by Wang Dave on 11-8-26.
//  Copyright 2011年 DaveDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRequest.h"

@interface ItemsGetRequest : BaseRequest
{
    NSString *fields;
    NSString *cid;
}
@property(nonatomic,retain)  NSString *fields; 
@property(nonatomic,retain)  NSString *cid; 
@end
