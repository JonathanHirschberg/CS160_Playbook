//
//  AddPlayerViewController.m
//  Playbook
//
//  Created by Class Account on 3/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import "PlaybookAppDelegate.h"
#import "AddPlayerViewController.h"

@implementation AddPlayerViewController
@synthesize playerName, playerNumber, playerPosition, appDelegate, playerEntry;
@synthesize mode, name, position, number;
@synthesize deleteButton;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/
- (int)translatePositionToIndex:(NSString *)title{
	if([title isEqualToString:@"Power Forward"]){
		return 0;
	}else if([title isEqualToString:@"Point Guard"]){
		return 1;
	}else if([title isEqualToString:@"Shooting Guard"]){
		return 2;
	}else if([title isEqualToString:@"Shooting Forward"]){
		return 3;
	}else return 4;
}
- (void)deletePlayer:(id)sender{
	// open a alert with an OK and cancel button
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete Player" message:@"Are you sure you want to delete this player?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
	alert.cancelButtonIndex = 1;
	[alert show];
	[alert release];
}
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	// the user clicked one of the OK/Cancel buttons
	if (buttonIndex == 1)
	{
		[appDelegate.roster removeObjectForKey:name];
		[appDelegate.activePlayers removeObjectForKey:name];
		[[self navigationController] popViewControllerAnimated:YES];
	}
	else
	{
		NSLog(@"cancel");
	}
}

- (void)goToRosterView{
	NSString *pPosition;
	switch([playerPosition selectedSegmentIndex]){
		case 0:
			pPosition = @"Power Forward";
			break;
		case 1:
			pPosition = @"Point Guard";
			break;
		case 2:
			pPosition = @"Shooting Guard";
			break;
		case 3:
			pPosition = @"Shooting Forward";
			break;
		case 4:
			pPosition = @"Center";
			break;
		default: pPosition = @"";
			
	}
	[playerEntry setObject:playerName.text forKey:@"name"];
	[playerEntry setObject:pPosition forKey:@"position"];
	[playerEntry setObject:playerNumber.text forKey:@"number"];
	[playerEntry setObject:[NSNumber numberWithInt:0] forKey:@"numGames"];
	[playerEntry setObject:[NSNumber numberWithInt:0] forKey:@"numShots"];
	[playerEntry setObject:[NSNumber numberWithInt:0] forKey:@"numRebounds"];
	[playerEntry setObject:[NSNumber numberWithInt:0] forKey:@"numAssists"];
	[playerEntry setObject:[NSNumber numberWithInt:0] forKey:@"numTechFouls"];
	[playerEntry setObject:[NSNumber numberWithInt:0] forKey:@"numPersFouls"];
	[playerEntry setObject:[NSNumber numberWithInt:0] forKey:@"numFlagFouls"];
	[playerEntry setObject:[NSNumber numberWithInt:0] forKey:@"numTotalFouls"];
	[appDelegate.roster setObject:playerEntry forKey:playerName.text];
	[[self navigationController] popViewControllerAnimated:YES];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	if(mode == -1){
		self.title = @"Add New Player";
		[playerPosition setSelectedSegmentIndex:0];
		deleteButton.hidden = YES;
	} else{
		self.title = @"Edit Player";
		[playerPosition setSelectedSegmentIndex:[self translatePositionToIndex:position]];
	}
	playerName.text = name;
	playerNumber.text = number;
	
	appDelegate = (PlaybookAppDelegate *)[[UIApplication sharedApplication] delegate];
	UIBarButtonItem *tempButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(goToRosterView)];
	self.navigationItem.rightBarButtonItem = tempButton;
	[tempButton release];
	playerEntry = [NSMutableDictionary dictionaryWithCapacity:10];
	[playerEntry retain];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	
    if (theTextField == playerName) {		
        [playerName resignFirstResponder];
    }else if(theTextField == playerNumber){
		[playerNumber resignFirstResponder];
	}
    return YES;
	
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
	[playerName release];
	[playerPosition release];
	[playerNumber release];
	[name release];
	[position release];
	[playerEntry release];
	[appDelegate release];
    [super dealloc];
}


@end
