//
//  Shot.m
//  Playbook
//
//  Created by Brian Chin on 4/2/10.
//  Copyright 2010 University of California, Berkeley. All rights reserved.
//

#import "Shot.h"
#import "PlaybookAppDelegate.h"
#import "Assists.h"


@implementation Shot
@synthesize typeOfShot;
@synthesize appDelegate;
@synthesize oldCell;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.title = @"Shot";
	UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(assistsScreen)];
    self.navigationItem.rightBarButtonItem = add;
    [add release];
	appDelegate = (PlaybookAppDelegate *)[[UIApplication sharedApplication] delegate];
	[typeOfShot setSelectedSegmentIndex:0];
    [super viewDidLoad];
}


- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)newIndexPath {
	[theTableView deselectRowAtIndexPath:[theTableView indexPathForSelectedRow] animated:NO];
	oldCell.accessoryType = UITableViewCellAccessoryNone;
	UITableViewCell *cell = [theTableView cellForRowAtIndexPath:newIndexPath];
    if (cell.accessoryType == UITableViewCellAccessoryNone) {        
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
		oldCell = [theTableView cellForRowAtIndexPath:newIndexPath];
		appDelegate.theTempScorer = [NSString stringWithString:cell.textLabel.text];
    }
}

- (IBAction)assistsScreen{
	if(appDelegate.theTempScorer == nil){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"You must select who scored" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.cancelButtonIndex = 1;
		[alert show];
		[alert release];
	} else {
		if ([typeOfShot selectedSegmentIndex] == 0) {
			appDelegate.theTempScoreAmount = 2;
		}
		if ([typeOfShot selectedSegmentIndex] == 1) {
			appDelegate.theTempScoreAmount = 3;
		}
		if ([typeOfShot selectedSegmentIndex] == 2){
			appDelegate.theTempScoreAmount = 1;
		}
		Assists *assistsController = [[Assists alloc]
								initWithNibName:@"Assists" bundle:[NSBundle mainBundle]];
		appDelegate.tempShot = self;
		[[self navigationController] pushViewController:assistsController animated:YES];
	}
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	cell.textLabel.text =[NSString stringWithString:[[[appDelegate.activePlayers allKeys] sortedArrayUsingSelector:@selector(playerCompare:)] objectAtIndex:indexPath.row]];
    return cell;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	appDelegate.theTempScorer = nil;
	appDelegate.theTempScoreAmount = nil;
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
