//
//  GameMenu.m
//  Playbook
//
//  Created by Brian Chin on 4/2/10.
//  Copyright 2010 University of California, Berkeley. All rights reserved.
//

#import "GameMenu.h"
#import "PickPlayersViewController.h"
#import "Foul.h"
#import "Shot.h"
#import "PlayTrackingViewController.h"
#import "PlaybookAppDelegate.h"
#import "ReboundController.h"

@implementation GameMenu
@synthesize appDelegate;

-(IBAction)shotButton:(id)sender{
	Shot *shotController = [[Shot alloc]
							 initWithNibName:@"Shot" bundle:[NSBundle mainBundle]];
	[[self navigationController] pushViewController:shotController animated:YES];
	[shotController release];
	appDelegate.theTempScorer = nil;
	appDelegate.theTempScoreAmount = 2;
	
}

-(IBAction)foulButton:(id)sender{
	Foul *foulController = [[Foul alloc]
							initWithNibName:@"Foul" bundle:[NSBundle mainBundle]];
	[[self navigationController] pushViewController:foulController animated:YES];
	[foulController release];
}

-(IBAction)reboundButton:(id)sender{
	ReboundController *reboundController = [[ReboundController alloc]
							initWithNibName:@"ReboundController" bundle:[NSBundle mainBundle]];
	[[self navigationController] pushViewController:reboundController animated:YES];
	[reboundController release];
}

-(IBAction)substitutionButton:(id)sender{
	PickPlayersViewController *pickPlayersView = [[PickPlayersViewController alloc]
												  initWithNibName:@"PickPlayers" bundle:[NSBundle mainBundle]];
	[self presentModalViewController:pickPlayersView animated:YES];	
}
-(IBAction)playSuccessButton:(id)sender{
	PlayTrackingViewController *playController = [[PlayTrackingViewController alloc]
							initWithNibName:@"PlayTrackingView" bundle:[NSBundle mainBundle]];
	playController.mode = 1;
	[[self navigationController] pushViewController:playController animated:YES];
	[playController release];
}
-(IBAction)playFailureButton:(id)sender{
	PlayTrackingViewController *playController = [[PlayTrackingViewController alloc]
												  initWithNibName:@"PlayTrackingView" bundle:[NSBundle mainBundle]];
	playController.mode = -1;
	[[self navigationController] pushViewController:playController animated:YES];
	[playController release];
}

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
	appDelegate = (PlaybookAppDelegate *)[[UIApplication sharedApplication] delegate];
	self.title = @"Game Events";
    [super viewDidLoad];
	PickPlayersViewController *pickPlayersView = [[PickPlayersViewController alloc]
												  initWithNibName:@"PickPlayers" bundle:[NSBundle mainBundle]];
    pickPlayersView.gameController = self.navigationController;
	[self presentModalViewController:pickPlayersView animated:YES];
	//[[self navigationController] pushViewController:pickPlayersView animated:YES];
	[pickPlayersView release];
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


//-(IBAction)shotButton:(id)sender;
//-(IBAction)foulButton:(id)sender;

- (void)dealloc {
    [super dealloc];
}


@end
