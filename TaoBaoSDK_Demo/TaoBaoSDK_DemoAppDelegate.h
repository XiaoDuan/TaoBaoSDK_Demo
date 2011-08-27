//
//  TaoBaoSDK_DemoAppDelegate.h
//  TaoBaoSDK_Demo
//
//  Created by Wang Dave on 11-8-27.
//  Copyright 2011年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TaoBaoSDK_DemoViewController;

@interface TaoBaoSDK_DemoAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet TaoBaoSDK_DemoViewController *viewController;

@end
