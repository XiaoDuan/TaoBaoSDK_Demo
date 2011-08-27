//
//  RequestParametersHolder.m
//  TaoBao
//
//  Created by Dave on 11-8-18.
//  Copyright 2011年 DaveDev. All rights reserved.
//

#import "RequestParametersHolder.h"


@implementation RequestParametersHolder
@synthesize protocalOptParams;
@synthesize protocalMustParams;
@synthesize applicationParams;
-(void)dealloc{
    [super dealloc];
    [protocalMustParams release];
    [protocalOptParams release];
    [applicationParams release];
}

-(id)init
{ 
    [super init]; 
     return self;
}
@end
