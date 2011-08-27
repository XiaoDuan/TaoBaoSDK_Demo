//
//  TaoBaoSDK_DemoViewController.h
//  TaoBaoSDK_Demo
//
//  Created by Wang Dave on 11-8-27.
//  Copyright 2011年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaobaoClient.h"
#import "ItemsGetRequest.h"

@interface TaoBaoSDK_DemoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    TaobaoClient *client;
    NSDictionary *titles;
}

@end
