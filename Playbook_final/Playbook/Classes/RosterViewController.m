//
//  RosterViewController.m
//  Playbook
//
//  Created by Class Account on 3/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import "PlaybookAppDelegate.h"
#import "AddPlayerViewController.h"
#import "RosterViewController.h"


@implementation RosterViewController
@synthesize appDelegate, playerNames;
/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/

- (void)addItem {
	AddPlayerViewController *addPlayerController = [[AddPlayerViewController alloc] initWithNibName:@"AddPlayerView" bundle:[NSBundle mainBundle]];
	addPlayerController.mode = -1;
	addPlayerController.name = @"";
	addPlayerController.position = @"";
	addPlayerController.number = @"";
	[self.navigationController pushViewController:addPlayerController animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	appDelegate = (PlaybookAppDelegate *)[[UIApplication sharedApplication] delegate];
	UIBarButtonItem *tempButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem)];
	self.navigationItem.rightBarButtonItem = tempButton;
	[tempButton release];
	self.title = @"Edit Roster";
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self.tableView reloadData];

}

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

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[appDelegate.roster allKeys] count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    NSString *cellValue;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
	NSString *temp =  [NSString stringWithString:[[[appDelegate.roster allKeys] sortedArrayUsingSelector:@selector(playerCompare:)] objectAtIndex:indexPath.row]]; 
	NSArray *tempArray = [temp componentsSeparatedByString: @" "];
	if ([tempArray count] > 1) { 
		cell.textLabel.text = [NSString stringWithFormat: @"%@, %@", [tempArray objectAtIndex:1], [tempArray objectAtIndex:0]];
	} else {
		cell.textLabel.text = temp;
	}
    // Set up the cell...
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *sortedPlayers = [[appDelegate.roster allKeys] sortedArrayUsingSelector:@selector(playerCompare:)];
	NSString *name = [sortedPlayers objectAtIndex:indexPath.row];
	// Navigation logic may go here. Create and push another view controller.
	AddPlayerViewController *addPlayerController = [[AddPlayerViewController alloc] initWithNibName:@"AddPlayerView" bundle:[NSBundle mainBundle]];
	addPlayerController.mode = 1;
	addPlayerController.name = name;
	addPlayerController.position = [[appDelegate.roster objectForKey:name] objectForKey:@"position"];
	addPlayerController.number = [[appDelegate.roster objectForKey:name] objectForKey:@"number"];
	[self.navigationController pushViewController:addPlayerController animated:YES];
	
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
    [super dealloc];
}


@end

