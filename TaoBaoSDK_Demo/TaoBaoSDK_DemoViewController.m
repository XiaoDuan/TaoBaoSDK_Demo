//
//  TaoBaoSDK_DemoViewController.m
//  TaoBaoSDK_Demo
//
//  Created by Wang Dave on 11-8-27.
//  Copyright 2011年 DaveDev. All rights reserved.
//

#import "TaoBaoSDK_DemoViewController.h"
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * Private interface definitions
 *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
@interface TaoBaoSDK_DemoViewController(private)
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
- (void)slideViewOffScreen;
- (void)searchProjectPhotos:(NSString *)text;
- (void)loadData;
-(void)loadDataBySearch:(NSString *)text;
@end

@implementation TaoBaoSDK_DemoViewController
@synthesize tableView; 
-(void)dealloc{
    NSLog(@"dealloc");
    [client release];
    [photoTitles release];
    [photoSmallImageData release];
    [photoURLsLargeImage release];
    [super dealloc];

}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

/*-------------------------------------------------------------
 *
 *------------------------------------------------------------*/
- (void)showZoomedImage:(NSIndexPath *)indexPath
{
    // Remove from view (and release)
    if ([fullImageViewController superview])
        [fullImageViewController removeFromSuperview];
    
    fullImageViewController = [[ZoomedImageView alloc] initWithURL:[photoURLsLargeImage objectAtIndex:indexPath.row]];
    
    [self.view addSubview:fullImageViewController];
    
    // Slide this view off screen
    CGRect frame = fullImageViewController.frame;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.45];
    
    // Slide the image to its new location (onscreen)
    frame.origin.x = 0;
    fullImageViewController.frame = frame;
    
    [UIView commitAnimations];
}
#pragma mark -
#pragma mark Private Methods

/*-------------------------------------------------------------
 *
 *------------------------------------------------------------*/
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
    
    [photoTitles removeAllObjects];
    [photoSmallImageData removeAllObjects];
    [photoURLsLargeImage removeAllObjects];
    [activityIndicator startAnimating];
    [self searchProjectPhotos:searchTextField.text];
    
    
   
    
	return YES;
}

/*-------------------------------------------------------------
 *
 *------------------------------------------------------------*/
-(void) searchProjectPhotos:(NSString *)text
{
   
    [self loadDataBySearch:text];
  
}



-(void)awakeFromNib{
    // Create textfield for the search text
    searchTextField = [[[UITextField alloc] initWithFrame:CGRectMake(110, 100, 100, 40)] retain];
    [searchTextField setBorderStyle:UITextBorderStyleRoundedRect];
    searchTextField.placeholder = @"search";
    searchTextField.returnKeyType = UIReturnKeyDone;
    searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchTextField.delegate = self;
    [self.view addSubview:searchTextField];
    [searchTextField release];
      
    // Create activity indicator
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(220, 110, 15, 15)];
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    activityIndicator.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
                                          UIViewAutoresizingFlexibleRightMargin |
                                          UIViewAutoresizingFlexibleTopMargin |
                                          UIViewAutoresizingFlexibleBottomMargin);
    [activityIndicator sizeToFit];
    activityIndicator.hidesWhenStopped = YES; 
    [self.view addSubview:activityIndicator];
}
-(void)initClient{
    //REAL_Platform_URL is real platform url
    //DAVE_APP_KEY is my app_key change your app_key.
    //DAVE_APP_SECRET is my app secret change your app_secret.
    client = [[TaobaoClient alloc] initWithServerUrl:REAL_Platform_URL appKey:DAVE_APP_KEY appSecret:DAVE_APP_SECRET ];
    //return message format json/xml.
    client.format = FORMAT_JSON;
    //sige method 
    client.signMethod = SIGN_METHOD_MD5;

}
#pragma mark - View lifecycle
 
/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.*/
- (void)viewDidLoad
{
    [tableView setRowHeight:80];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    [super viewDidLoad];
    [self initClient];
   // NSLog(@"..");
    //add request
    ItemsGetRequest *request = [[ItemsGetRequest alloc] init];
    request.fields = @"title,pic_url";
    request.cid = @"16";
    request.page_size =@"20";
    //note: if not copy NSDictionary maybe Turn Off Ligatures. 
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:[client execute:request]];
    [request release];
    photoTitles = [[NSMutableArray alloc] initWithCapacity:10];
    photoSmallImageData = [[NSMutableArray alloc] initWithCapacity:10];
    photoURLsLargeImage = [[NSMutableArray alloc] initWithCapacity:10];
    for (NSDictionary *photo in [dictionary valueForKeyPath:@"items_get_response.items.item"])
    {
        
        //[titles addObject:[photo objectForKey:@"title"]];
        
        [photoTitles addObject:[photo objectForKey:@"title"]];
        [photoSmallImageData addObject:[NSData dataWithContentsOfURL:[NSURL URLWithString:[photo objectForKey:@"pic_url"]]]];
        [photoURLsLargeImage addObject:[NSURL URLWithString:[photo objectForKey:@"pic_url"]]];
        
     //   NSLog(@"pic_url = %@", [photo objectForKey:@"pic_url"]);
         
       
    }
 
   
  
    self.title = @"Titles";
 	if (_refreshHeaderView == nil) {
		
        LoadMoreTableFooterView *view = [[LoadMoreTableFooterView alloc] initWithFrame:CGRectMake(0.0f, self.tableView.contentSize.height, self.tableView.frame.size.width, self.tableView.bounds.size.height)];
		view.delegate = self;
		[self.tableView addSubview:view];
		_refreshHeaderView = view;
		[view release];
		
	}
	
	//  update the last update date
//	[_refreshHeaderView refreshLastUpdatedDate];
}



#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	[_refreshHeaderView loadMoreScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView loadMoreScrollViewDidEndDragging:scrollView];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// There is only one section.
	return 1;
}


#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
    
	_reloading = YES;
    
       
	
}
-(void) loadDataBySearch:(NSString *)text{
   
    ItemsGetRequest *request = [[ItemsGetRequest alloc] init];
    request.fields = @"title,pic_url";
    request.cid = @"16";
    request.page_size =@"20"; 
    request.q =  text;
    currentSearchText = text;
    NSDictionary *dic = [[client execute:request]     valueForKeyPath:@"items_get_response.items.item"];
    for (NSDictionary *photo in dic)
    {
        // Get title of the image
        // NSLog(@"%@",[photo objectForKey:@"title"] );
        [photoTitles addObject:[photo objectForKey:@"title"]];
        [photoSmallImageData addObject:[NSData dataWithContentsOfURL:[NSURL URLWithString:[photo objectForKey:@"pic_url"]]]];
        [photoURLsLargeImage addObject:[NSURL URLWithString:[photo objectForKey:@"pic_url"]]];
        
    } 
    [request release];
    [activityIndicator stopAnimating];
    [tableView reloadData];

}
-(void) loadData{
    static int currentPage = 1;
    //add request
    ItemsGetRequest *request = [[ItemsGetRequest alloc] init];
    request.fields = @"title,pic_url";
    request.cid = @"16";
    request.page_size =@"20";
    if (currentSearchText) {
        request.q = currentSearchText;
    }
    NSLog(@"currentPage = %d ",++currentPage);
    NSString *strNo = [[NSString alloc] initWithFormat:@"%d",currentPage] ;
    request.page_no = strNo;
    
    [strNo release];
    // NSLog(@"titles.count = %d ",titles.count);
    NSDictionary *dic = [[client execute:request]     valueForKeyPath:@"items_get_response.items.item"];
    for (NSDictionary *photo in dic)
    {
        // Get title of the image
        // NSLog(@"%@",[photo objectForKey:@"title"] );
        [photoTitles addObject:[photo objectForKey:@"title"]];
        [photoSmallImageData addObject:[NSData dataWithContentsOfURL:[NSURL URLWithString:[photo objectForKey:@"pic_url"]]]];
        [photoURLsLargeImage addObject:[NSURL URLWithString:[photo objectForKey:@"pic_url"]]];
        
    } 
    [request release];
}

- (void)doneLoadingTableViewData{
 
    [self loadData];
    [self.tableView reloadData];
    _reloading = NO;
	[_refreshHeaderView loadMoreScrollViewDataSourceDidFinishedLoading:self.tableView];
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// Return the number of time zone names.
	return photoTitles.count;
}
//
//#pragma mark -
//#pragma mark EGORefreshTableHeaderDelegate Methods
//
//- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
//	
//	[self reloadTableViewDataSource];
//	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:.0];
//	
//}
//
//- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
//	
//	return _reloading; // should return if data source model is reloading
//	
//}
//
//- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
//	
//	return [NSDate date]; // should return date data source was last changed
//	
//}

#pragma mark -
#pragma mark LoadMoreTableFooterDelegate Methods

- (void)loadMoreTableFooterDidTriggerRefresh:(LoadMoreTableFooterView *)view {
    
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:.0];
    
}

- (BOOL)loadMoreTableFooterDataSourceIsLoading:(LoadMoreTableFooterView *)view {
	return _reloading;
}


/*-------------------------------------------------------------
 *
 *------------------------------------------------------------*/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
    searchTextField.hidden = NO;
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cachedCell"];
    if (cell == nil)
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"cachedCell"] autorelease];
    
 
    cell.textLabel.text = [photoTitles objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:13.0];
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.textLabel.numberOfLines = 0;
	 
    cell.imageView.image = [[UIImage imageWithData:[photoSmallImageData objectAtIndex:indexPath.row]]cropCenterAndScaleImageToSize:CGSizeMake(75,75)];
    
    
    
      
    
	return cell;

}






/*
 To conform to Human Interface Guildelines, since selecting a row would have no effect (such as navigation), make sure that rows cannot be selected.
 */
//- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//	return nil;
//}
 
/*-------------------------------------------------------------
 *
 *------------------------------------------------------------*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    searchTextField.hidden = YES;
    
    // If we've created this VC before...
    if (fullImageViewController != nil)
    {
        // Slide this view off screen
        CGRect frame = fullImageViewController.frame;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.45];
        
        // Off screen location
        frame.origin.x = -320;
        fullImageViewController.frame = frame;
        
        [UIView commitAnimations];
        
    }
    
    [self performSelector:@selector(showZoomedImage:) withObject:indexPath afterDelay:0.1];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
