//
//  Assists.m
//  Playbook
//
//  Created by Brian Chin on 4/4/10.
//  Copyright 2010 University of California, Berkeley. All rights reserved.
//

#import "Assists.h"
#import "PlaybookAppDelegate.h"

@implementation Assists
@synthesize appDelegate, assistPlayer, oldCell;
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
	self.title = @"Assists";
	UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneScreen)];
    self.navigationItem.rightBarButtonItem = add;
    [add release];
	appDelegate = (PlaybookAppDelegate *)[[UIApplication sharedApplication] delegate];
	oldCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    [super viewDidLoad];
}

- (IBAction)doneScreen{
	NSMutableDictionary *shotPlayer = [appDelegate.roster objectForKey:appDelegate.theTempScorer];
	if([shotPlayer objectForKey:@"numShots"] == nil){
		[shotPlayer setObject:[NSNumber numberWithInt:appDelegate.theTempScoreAmount] forKey: @"numShots"];
	}else{
		NSNumber *newShots = [NSNumber numberWithInt:([[shotPlayer objectForKey:@"numShots"] intValue] + appDelegate.theTempScoreAmount)];
		[shotPlayer	setObject:newShots forKey:@"numShots"];
	}
	NSMutableDictionary *assister = [appDelegate.roster objectForKey:assistPlayer];
	if([assister objectForKey:@"numAssists"] == nil){
		[assister setObject:[NSNumber numberWithInt:1] forKey:@"numAssists"];
	}else{
		NSNumber *newAssists = [NSNumber numberWithInt:([[assister objectForKey:@"numAssists"] intValue] + 1)];
		[assister setObject:newAssists forKey:@"numAssists"];
	}
	int count = [self.navigationController.viewControllers count];
	[[self navigationController] popToViewController:[[[self navigationController] viewControllers] objectAtIndex:count-3] animated: YES];

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
    return cell;
}

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)newIndexPath {
	
    [theTableView deselectRowAtIndexPath:[theTableView indexPathForSelectedRow] animated:NO];
	
	oldCell.accessoryType = UITableViewCellAccessoryNone;
	UITableViewCell *cell = [theTableView cellForRowAtIndexPath:newIndexPath];
    if (cell.accessoryType == UITableViewCellAccessoryNone) {        
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
		oldCell = [theTableView cellForRowAtIndexPath:newIndexPath];
		assistPlayer = [NSString stringWithString:cell.textLabel.text];
    }
	
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
