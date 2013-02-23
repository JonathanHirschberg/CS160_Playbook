//
//  PickPlayersViewController.m
//  Playbook
//
//  Created by Brian Chin on 4/2/10.
//  Copyright 2010 University of California, Berkeley. All rights reserved.
//

#import "PickPlayersViewController.h"
#import "PlaybookAppDelegate.h"
#import "GameMenu.h";

@implementation PickPlayersViewController
@synthesize appDelegate, playerNames, rosterTable, gameController, navItem;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/
- (IBAction)gameTrack{
	if([appDelegate.activePlayers count] < 5){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"You must select 5 starting players before starting the game." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.cancelButtonIndex = 1;
		[alert show];
		[alert release];
	} else{
		if(gameController != nil){
			NSArray *currPlayers = [appDelegate.activePlayers allKeys];
			int i;
			for(i=0; i < [currPlayers count]; i++){
				NSMutableDictionary *player = [appDelegate.roster objectForKey:[currPlayers objectAtIndex:i]];
				int updatedNumGames= [[player objectForKey:@"numGames"] intValue]+1;
				[player setObject:[NSNumber numberWithInt:updatedNumGames] forKey:@"numGames"];
			}
		}
		[self dismissModalViewControllerAnimated:YES];
	}
										   
	
}

- (IBAction)cancel {
    appDelegate.activePlayers = oldActivePlayers;
    [self dismissModalViewControllerAnimated:YES];
    if (gameController != nil) {
        [gameController popViewControllerAnimated:NO];
    }
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	//self.title = @"Choose Roster";
	appDelegate = (PlaybookAppDelegate *)[[UIApplication sharedApplication] delegate];
	//UIBarButtonItem *tempButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(gameTrack)];
//    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
//	self.navigationItem.rightBarButtonItem = tempButton;
//    self.navigationItem.leftBarButtonItem = cancel
    if (gameController == nil) {
        navItem.title = @"Choose Players";
    }
    else {
        navItem.title = @"Choose Starters";
    }
//	[tempButton release];
//    [cancelButton release];
    [super viewDidLoad];
    oldActivePlayers = [[NSMutableDictionary dictionaryWithDictionary:appDelegate.activePlayers] retain];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[rosterTable reloadData];
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
    return [[appDelegate.roster allKeys] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	switch(section){
		case 0:
            if (gameController == nil) {
                return @"Pick the 5 in-game players";
            }
            else {
                return @"Pick the 5 starting players";
            }
		default:
			return @"";
	}
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
    NSString *cellValue;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
	
	cellValue = [NSString stringWithString:[[[appDelegate.roster allKeys] sortedArrayUsingSelector:@selector(playerCompare:)] objectAtIndex:indexPath.row]];
	cell.accessoryType = UITableViewCellAccessoryNone;
	if([appDelegate.activePlayers allKeys] != nil){
		if([appDelegate.activePlayers objectForKey:cellValue]){
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
	}
	NSString *temp =  [NSString stringWithString:[[[appDelegate.roster allKeys] sortedArrayUsingSelector:@selector(playerCompare:)] objectAtIndex:indexPath.row]]; 
	NSArray *tempArray = [temp componentsSeparatedByString: @" "];
	if ([tempArray count] > 1) { 
		cell.textLabel.text = [NSString stringWithFormat: @"%@, %@", [tempArray objectAtIndex:1], [tempArray objectAtIndex:0]];
	} else {
		cell.textLabel.text = temp;
	}
	//cellValue = @"";
	//cell.textLabel.text = cellValue;
    // Set up the cell...
	
    return cell;
}

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)newIndexPath {
	
    [theTableView deselectRowAtIndexPath:[theTableView indexPathForSelectedRow] animated:NO];
    UITableViewCell *cell = [theTableView cellForRowAtIndexPath:newIndexPath];
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        
		if([appDelegate.activePlayers count] < 5){
			NSString *temp = cell.textLabel.text; 
			NSArray *tempArray = [temp componentsSeparatedByString: @", "];
			if ([tempArray count] > 1) { 
				temp = [NSString stringWithFormat: @"%@ %@", [tempArray objectAtIndex:1], [tempArray objectAtIndex:0]];
			}
			[appDelegate.activePlayers setObject:@"" forKey:temp];
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
    } else if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
		NSString *temp = cell.textLabel.text; 
		NSArray *tempArray = [temp componentsSeparatedByString: @", "];
		if ([tempArray count] > 1) { 
			temp = [NSString stringWithFormat: @"%@ %@", [tempArray objectAtIndex:1], [tempArray objectAtIndex:0]];
		}
        cell.accessoryType = UITableViewCellAccessoryNone;
		[appDelegate.activePlayers removeObjectForKey:temp];
    }
	
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
    [gameController release];
    [oldActivePlayers release];
    [navItem release];
    [super dealloc];
}


@end
