//
//  TaoBaoSDK_DemoViewController.m
//  TaoBaoSDK_Demo
//
//  Created by Wang Dave on 11-8-27.
//  Copyright 2011年 DaveDev. All rights reserved.
//

#import "TaoBaoSDK_DemoViewController.h"

@implementation TaoBaoSDK_DemoViewController
-(void)dealloc{
    NSLog(@"dealloc");
    [client release];
    [titles release];
    [super dealloc];

}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
 
/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.*/
- (void)viewDidLoad
{
    
    //REAL_Platform_URL is real platform url
    //DAVE_APP_KEY is my app_key change your app_key.
    //DAVE_APP_SECRET is my app secret change your app_secret.
    client = [[TaobaoClient alloc] initWithServerUrl:REAL_Platform_URL appKey:DAVE_APP_KEY appSecret:DAVE_APP_SECRET ];
    //return message format json/xml.
    client.format = FORMAT_JSON;
    //sige method 
    client.signMethod = SIGN_METHOD_MD5;
    
    //add request
    ItemsGetRequest *request = [[ItemsGetRequest alloc] init];
    request.fields = @"title";
    request.cid = @"16";
    //note: if not copy NSDictionary maybe Turn Off Ligatures. 
    NSDictionary *dictionary =  [[client execute:request] copy];
    
    // NSLog(@"dictionary = %@",dictionary);
    titles = [dictionary valueForKeyPath:@"items_get_response.items.item"];
    self.title = @"Titles";
    NSLog(@"titles.count = %d ",titles.count);
    [super viewDidLoad];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// There is only one section.
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// Return the number of time zone names.
	return titles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *MyIdentifier = @"MyIdentifier";
	
	// Try to retrieve from the table view a now-unused cell with the given identifier.
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	
	// If no cell is available, create a new one using the given identifier.
	if (cell == nil) {
		// Use the default cell style.
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
	}
	
	// Set up the cell.
    //NSLog(@"indexPath.row = %d",indexPath.row);
    NSString *title = [[titles valueForKeyPath:@"title"] objectAtIndex:indexPath.row]; 
	cell.textLabel.text = title;
	
	return cell;
}

/*
 To conform to Human Interface Guildelines, since selecting a row would have no effect (such as navigation), make sure that rows cannot be selected.
 */
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	return nil;
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
