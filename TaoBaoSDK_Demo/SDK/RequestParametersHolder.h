//
//  RequestParametersHolder.h
//  TaoBao
//
//  Created by Dave on 11-8-18.
//  Copyright 2011年 DaveDev. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RequestParametersHolder : NSObject {
    NSMutableDictionary *protocalMustParams;
    NSMutableDictionary *protocalOptParams;
    NSMutableDictionary *applicationParams;
}

@property(retain) NSMutableDictionary *protocalMustParams;
@property(retain) NSMutableDictionary *protocalOptParams;
@property(retain) NSMutableDictionary *applicationParams;
@end
