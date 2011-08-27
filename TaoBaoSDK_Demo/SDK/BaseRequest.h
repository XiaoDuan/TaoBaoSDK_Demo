//
//  BaseRequest.h
//  TaoBao
//
//  Created by Wang Dave on 11-8-26.
//  Copyright 2011年 DaveDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseRequest : NSObject
-(NSString*) getApiMethodName;
-(NSDictionary*) getTextParams;
@end
