//
//  BaseRequest.m
//  TaoBao
//
//  Created by Wang Dave on 11-8-26.
//  Copyright 2011年 DaveDev. All rights reserved.
//

#import "BaseRequest.h"

@implementation BaseRequest

- (id)init
{
    self = [super init];
    if (self) {
    }
    
    return self;
}
-(NSString*) getApiMethodName{
    return nil;
}
-(NSDictionary*) getTextParams{
    return nil;
}


@end
