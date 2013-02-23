//
//  GameMenuAlt.m
//  Playbook
//
//  Created by Wei on 4/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GameMenuAlt.h"
#import "PlaybookAppDelegate.h"
#import "PickPlayersViewController.h"
#import "GameActions.h"
@implementation GameMenuAlt
@synthesize appDelegate;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	appDelegate = (PlaybookAppDelegate *)[[UIApplication sharedApplication] delegate];
	self.title = @"Players In Game";
	PickPlayersViewController *pickPlayersView = [[PickPlayersViewController alloc]
												  initWithNibName:@"PickPlayers" bundle:[NSBundle mainBundle]];
    pickPlayersView.gameController = self.navigationController;
	[self presentModalViewController:pickPlayersView animated:YES];
	//[[self navigationController] pushViewController:pickPlayersView animated:YES];
	[pickPlayersView release];
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	[self.tableView reloadData];
}
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
    return [appDelegate.activePlayers count]+1;
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
	if(indexPath.row == [appDelegate.activePlayers count]){
		cellValue = @"Substitute a player";
	}else{
		NSString *temp =  [NSString stringWithString:[[[appDelegate.activePlayers allKeys] sortedArrayUsingSelector:@selector(playerCompare:)] objectAtIndex:indexPath.row]]; 
		NSArray *tempArray = [temp componentsSeparatedByString: @" "];
		if ([tempArray count] > 1) { 
			cellValue = [NSString stringWithFormat: @"%@, %@", [tempArray objectAtIndex:1], [tempArray objectAtIndex:0]];
		} else {
			cellValue = temp;
		}	}
	cell.textLabel.text = cellValue;
    // Set up the cell...
	
    
    return cell;
}



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


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	if(indexPath.row == [appDelegate.activePlayers count]){
		PickPlayersViewController *pickPlayersView = [[PickPlayersViewController alloc]
													  initWithNibName:@"PickPlayers" bundle:[NSBundle mainBundle]];
		[self presentModalViewController:pickPlayersView animated:YES];	
	} else{		
		GameActions *gameAction = [[GameActions alloc] initWithNibName:@"GameActions" bundle:nil];
		NSString *temp =  [NSString stringWithString:[tableView cellForRowAtIndexPath:indexPath].textLabel.text];
		NSArray *tempArray = [temp componentsSeparatedByString: @", "];
		if ([tempArray count] > 1) { 
			temp = [NSString stringWithFormat: @"%@ %@", [tempArray objectAtIndex:1], [tempArray objectAtIndex:0]];
		}
		gameAction.player = temp;
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:gameAction animated:YES];
	 [gameAction release];
	}
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

