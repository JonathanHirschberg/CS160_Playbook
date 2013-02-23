#import "StatsViewController.h"
#import "PlaybookAppDelegate.h"
#import "IndividualStats.h"
@implementation StatsViewController
@synthesize appDelegate;
/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.title = @"View Stats";
	appDelegate = (PlaybookAppDelegate *)[[UIApplication sharedApplication] delegate];

    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self.tableView reloadData];
	
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [[appDelegate.roster allKeys] count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }    
	//cell.textLabel.text =[NSString stringWithString:[[[appDelegate.roster allKeys] sortedArrayUsingSelector:@selector(playerCompare:)] objectAtIndex:indexPath.row]];  
	NSString *temp =  [NSString stringWithString:[[[appDelegate.roster allKeys] sortedArrayUsingSelector:@selector(playerCompare:)] objectAtIndex:indexPath.row]]; 
	NSArray *tempArray = [temp componentsSeparatedByString: @" "];
	if ([tempArray count] > 1) { 
		cell.textLabel.text = [NSString stringWithFormat: @"%@, %@", [tempArray objectAtIndex:1], [tempArray objectAtIndex:0]];
	} else {
		cell.textLabel.text = temp;
	}
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
    return cell;
}


- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [aTableView cellForRowAtIndexPath:indexPath];
	NSString *temp =  [NSString stringWithString:[[[appDelegate.roster allKeys] sortedArrayUsingSelector:@selector(playerCompare:)] objectAtIndex:indexPath.row]]; 
	NSArray *tempArray = [temp componentsSeparatedByString: @", "];
	if ([tempArray count] > 1) { 
		cell.textLabel.text = [NSString stringWithFormat: @"%@ %@", [tempArray objectAtIndex:0], [tempArray objectAtIndex:1]];
	} else {
		cell.textLabel.text = temp;
	}
	
	appDelegate.statPlayer = cell.textLabel.text;
    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
	IndividualStats *individualStatsController = [[IndividualStats alloc] initWithNibName:@"IndividualStats" bundle:[NSBundle mainBundle]];
	individualStatsController.title = cell.textLabel.text;
	[self.navigationController pushViewController:individualStatsController animated:YES];
    [individualStatsController release];
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
