//
//  NewGame.m
//  Playbook
//
//  Created by Brian Chin on 4/2/10.
//  Copyright 2010 University of California, Berkeley. All rights reserved.
//

#import "NewGame.h"
#import "RosterViewController.h"
#import "GameMenu.h"
#import "PlaybookAppDelegate.h"
#import "GameMenuAlt.h"
@implementation NewGame
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

- (void)viewDidLoad {
	self.title = @"Track Stats";
	appDelegate = (PlaybookAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate retain];
    [super viewDidLoad];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (IBAction)newGameButton:(id)sender {
	if([appDelegate.roster count] < 5){
		RosterViewController *rosterView = [[RosterViewController alloc] initWithNibName: @"RosterView" bundle: [NSBundle mainBundle]];
		[[self navigationController] pushViewController:rosterView animated:YES];
		[rosterView release];
	}else{
        GameMenuAlt *newGameAlt = [[GameMenuAlt alloc] initWithNibName: @"GameMenuAlt" bundle: [NSBundle mainBundle]];
        [[self navigationController] pushViewController:newGameAlt animated:NO];
        appDelegate.activePlayers = [NSMutableDictionary dictionaryWithCapacity:5];
	}
}

- (IBAction)enterRosterButton:(id)sender {
	RosterViewController *rosterView = [[RosterViewController alloc] initWithNibName: @"RosterView" bundle: [NSBundle mainBundle]];
	[[self navigationController] pushViewController: rosterView animated:YES];
	[rosterView release];
}

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
