//
//  IndividualStats.m
//  Playbook
//
//  Created by Brian Chin on 4/5/10.
//  Copyright 2010 University of California, Berkeley. All rights reserved.
//

#import "IndividualStats.h"
#import "PlaybookAppDelegate.h"

@implementation IndividualStats
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
	appDelegate = (PlaybookAppDelegate *)[[UIApplication sharedApplication] delegate];
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self.tableView reloadData];
	
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	if(section == 0)
		return @"Player Basics";
	else
		return @"Player Game Stats (per game)";
}

// Customize the number of rows in the table view.∫
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if(section == 0){
		return 3;
	}else{
		NSMutableDictionary *playerEntry = [appDelegate.roster objectForKey:[[appDelegate.roster allKeys] objectAtIndex:0]];
		
		return [[playerEntry allKeys] count] - 4;
	}
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}



// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		if(indexPath.section == 0){
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
		}else{
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
		}
    }
	NSMutableDictionary *playerEntry = [appDelegate.roster objectForKey:appDelegate.statPlayer];
	int numGames = [[playerEntry objectForKey:@"numGames"] intValue];
	int total;
	NSNumber *perGame;
	if(indexPath.section == 0){
		switch(indexPath.row){
			case 0:
				cell.textLabel.text = @"Position";
				cell.detailTextLabel.text = [@"" stringByAppendingString:[playerEntry objectForKey:@"position"]];
				break;
			case 1:
				cell.textLabel.text = @"Number";
				cell.detailTextLabel.text = [@"" stringByAppendingString: [playerEntry objectForKey:@"number"]];
				break;
			case 2:
				cell.textLabel.text = @"# Games Played";
				cell.detailTextLabel.text = [@"" stringByAppendingString: [[playerEntry objectForKey:@"numGames"] stringValue] ];
				break;
			default:
				cell.textLabel.text = @"";
		}
	} else if (indexPath.section == 1){
		switch(indexPath.row){
			case 0:
				cell.textLabel.text = @"Points";
				total = [[playerEntry objectForKey:@"numShots"] intValue];
				break;
			case 1:
				cell.textLabel.text = @"Assists";
				total = [[playerEntry objectForKey:@"numAssists"] intValue];
				break;
			case 2:
				cell.textLabel.text = @"Rebounds";
				total = [[playerEntry objectForKey:@"numRebounds"] intValue];
				break;
			case 3:
				cell.textLabel.text = @"Total fouls";
				total = [[playerEntry objectForKey:@"numTotalFouls"] intValue];
				break;
			case 4:
				cell.textLabel.text = @"Technical fouls";
				total = [[playerEntry objectForKey:@"numTechFouls"] intValue];
				break;
			case 5:
				cell.textLabel.text = @"Personal fouls";
				total = [[playerEntry objectForKey:@"numPersFouls"] intValue];
				break;
			case 6:
				cell.textLabel.text = @"Flagrant fouls";
				total = [[playerEntry objectForKey:@"numFlagFouls"] intValue];
				break;
			default:
				perGame = [NSNumber numberWithFloat:0];
		}
		
		if(numGames == 0){
			cell.detailTextLabel.text = @"0.000";
		} else{
			perGame = [NSNumber numberWithFloat:(float)total / numGames];
			cell.detailTextLabel.text = [NSString stringWithFormat:@"%.3f", [perGame floatValue]];	
		}
		
	}
    return cell;
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
