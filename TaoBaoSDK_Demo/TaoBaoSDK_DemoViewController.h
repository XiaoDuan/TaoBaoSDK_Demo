//
//  TaoBaoSDK_DemoViewController.h
//  TaoBaoSDK_Demo
//
//  Created by Wang Dave on 11-8-27.
//  Copyright 2011年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaobaoClient.h"
#import "ZoomedImageView.h"
#import "UIImageExtras.h"
#import "ItemsGetRequest.h"
//#import "EGORefreshTableHeaderView.h"
#import "LoadMoreTableFooterView.h"
@interface TaoBaoSDK_DemoViewController : UIViewController <LoadMoreTableFooterDelegate,UITableViewDelegate,UITextFieldDelegate, UITableViewDataSource>
{
    TaobaoClient *client;
    
   // NSMutableDictionary *titles;
   // NSMutableArray *titles;
    NSNumber *titlesCount;
    UITableView *tableView;
    UITextField     *searchTextField;
    NSMutableArray  *photoTitles;         // Titles of images
    NSMutableArray  *photoSmallImageData; // Image data (thumbnail)
    NSMutableArray  *photoURLsLargeImage; // URL to larger image
    
    ZoomedImageView  *fullImageViewController;
    UIActivityIndicatorView *activityIndicator; 
    NSString *currentSearchText;
    LoadMoreTableFooterView *_refreshHeaderView;
	
	//  Reloading var should really be your tableviews datasource
	//  Putting it here for demo purposes 
	BOOL _reloading;
}
@property(retain) IBOutlet UITableView *tableView;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
@end
