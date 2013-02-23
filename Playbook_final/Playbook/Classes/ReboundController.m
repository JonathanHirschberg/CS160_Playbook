//
//  ReboundController.m
//  Playbook
//
//  Created by Brian Chin on 4/4/10.
//  Copyright 2010 University of California, Berkeley. All rights reserved.
//

#import "ReboundController.h"
#import "PlaybookAppDelegate.h"

@implementation ReboundController
@synthesize rebounder;
@synthesize appDelegate;

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
	rebounder = nil;
	self.title = @"Rebound";
	UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(returnBack)];
    self.navigationItem.rightBarButtonItem = add;
    [add release];
	appDelegate = (PlaybookAppDelegate *)[[UIApplication sharedApplication] delegate];
    [super viewDidLoad];
}

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)newIndexPath {
    [theTableView deselectRowAtIndexPath:newIndexPath animated:YES];
    UITableViewCell *cell = [theTableView cellForRowAtIndexPath:newIndexPath];
	rebounder = cell.textLabel.text;
    [theTableView reloadData];
}




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
    if ([cell.textLabel.text isEqualToString:rebounder]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}



- (IBAction)returnBack{
	NSMutableDictionary *reboundPlayer = [appDelegate.roster objectForKey:rebounder];
	NSNumber *newShots = [NSNumber numberWithInt:([[reboundPlayer objectForKey:@"numRebounds"] intValue] + 1)];
	[reboundPlayer	setObject:newShots forKey:@"numRebounds"];
	[[self navigationController] popViewControllerAnimated:YES];
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


- (void)dealloc {
    [super dealloc];
}


@end
