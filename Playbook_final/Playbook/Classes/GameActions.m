//
//  GameActions.m
//  Playbook
//
//  Created by Wei on 4/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GameActions.h"

#import "PlaybookAppDelegate.h"
@implementation GameActions

@synthesize appDelegate, player;
#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
	self.navigationItem.title = @"Select Action";
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	appDelegate = (PlaybookAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate retain];
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 8;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	switch(indexPath.row){
		case 0:
			cell.textLabel.text = @"2-Pointer";
			break;
		case 1:
			cell.textLabel.text = @"3-Pointer";
			break;
		case 2:
			cell.textLabel.text = @"Free Throw";
			break;
		case 3:
			cell.textLabel.text = @"Assist";
			break;
		case 4:
			cell.textLabel.text = @"Rebound";
			break;
		case 5:
			cell.textLabel.text = @"Technical Foul";
			break;
		case 6:
			cell.textLabel.text = @"Personal Foul";
			break;
		case 7:
			cell.textLabel.text = @"Flagrant Foul";
			break;
		default:
			cell.textLabel.text = @"";
	}
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSMutableDictionary *playerEntry = [appDelegate.roster objectForKey:player];
	int total, foulTotal;
	switch(indexPath.row){
		case 0:
			total = [[playerEntry objectForKey:@"numShots"] intValue] + 2;
			[playerEntry setObject:[NSNumber numberWithInt:total] forKey:@"numShots"];
			break;
		case 1:
			total = [[playerEntry objectForKey:@"numShots"] intValue] + 3;
			[playerEntry setObject:[NSNumber numberWithInt:total] forKey:@"numShots"];
			break;
		case 2:
			total = [[playerEntry objectForKey:@"numShots"] intValue] + 1;
			[playerEntry setObject:[NSNumber numberWithInt:total] forKey:@"numShots"];
			break;
		case 3:
			total = [[playerEntry objectForKey:@"numAssists"] intValue] + 1;
			[playerEntry setObject:[NSNumber numberWithInt:total] forKey:@"numAssists"];
			break;
		case 4:
			total = [[playerEntry objectForKey:@"numRebounds"] intValue] + 1;
			[playerEntry setObject:[NSNumber numberWithInt:total] forKey:@"numRebounds"];
			break;
		case 5:
			total = [[playerEntry objectForKey:@"numTechFouls"] intValue] + 1;
			[playerEntry setObject:[NSNumber numberWithInt:total] forKey:@"numTechFouls"];
			foulTotal = [[playerEntry objectForKey:@"numTotalFouls"] intValue] + 1;
			[playerEntry setObject:[NSNumber numberWithInt:foulTotal] forKey:@"numTotalFouls"];
			break;
		case 6:
			total = [[playerEntry objectForKey:@"numPersFouls"] intValue] + 1;
			[playerEntry setObject:[NSNumber numberWithInt:total] forKey:@"numPersFouls"];
			foulTotal = [[playerEntry objectForKey:@"numTotalFouls"] intValue] + 1;
			[playerEntry setObject:[NSNumber numberWithInt:foulTotal] forKey:@"numTotalFouls"];
			break;
		case 7:
			total = [[playerEntry objectForKey:@"numFlagFouls"] intValue] + 1;
			[playerEntry setObject:[NSNumber numberWithInt:total] forKey:@"numFlagFouls"];
			foulTotal = [[playerEntry objectForKey:@"numTotalFouls"] intValue] + 1;
			[playerEntry setObject:[NSNumber numberWithInt:foulTotal] forKey:@"numTotalFouls"];
			break;
		default:
			total = 0;
	}
	[self.navigationController popViewControllerAnimated:YES];
	
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

