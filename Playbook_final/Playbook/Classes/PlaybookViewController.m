#import "PlaybookAppDelegate.h"
#import "DrawPlayView.h"
#import "DrawPlayViewController.h"
#import "PlaybookViewController.h"

@implementation PlaybookViewController
@synthesize appDelegate, savedNames, drawPlayViewController;

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


- (void)viewWillAppear:(BOOL)animated {
	if(appDelegate.needToUpdateSavedPlayList == TRUE) {
		[self reloadSavedPlays];
		[self.tableView reloadData];
		appDelegate.needToUpdateSavedPlayList = FALSE;
	}
	[super viewWillAppear:animated];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Playbook";
	appDelegate = (PlaybookAppDelegate *)[[UIApplication sharedApplication] delegate];
	[self reloadSavedPlays];
	
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newPlay:)];
	
	// Add the new button to the navigation bar
	self.navigationItem.rightBarButtonItem = addButton;
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    [addButton release];
	
	// Create the DrawPlayViewController
	DrawPlayViewController *adrawPlayViewController = [[DrawPlayViewController alloc] 
															 initWithNibName:@"DrawPlayViewController" bundle:[NSBundle mainBundle]];
	adrawPlayViewController.title = @"New Play";
	self.drawPlayViewController = adrawPlayViewController;
	[adrawPlayViewController release];
	
	
	
/*	// test initialization
	NSMutableArray *play1 = [[NSMutableArray alloc] init];
	NSString *test = @"test";
	[play1 addObject:test];
	NSLog(@"count %d", [play1 count]);
	[appDelegate.savedplays setObject:play1 forKey:@"testplay"];
	NSLog(@"dictionary count %d", [appDelegate.savedplays count]);	
	[self reloadSavedPlays];
	NSLog(@"test play set: %@, %@", [savedNames objectAtIndex:0], [appDelegate.savedplays objectForKey:[savedNames objectAtIndex:0]]);
*/
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

/** Method that return the current view to the Strength view main screen */
-(void) newPlay:(id) sender{
/*	NSMutableArray *play1 = [[NSMutableArray alloc] init];
	NSString *test = @"test2";
	[play1 addObject:test];
	//	NSLog(@"count %d", [play1 count]);
	[appDelegate.savedplays setObject:play1 forKey:@"testplay2"];
	[self reloadSavedPlays];
 */
	drawPlayViewController.drawMode = TRUE;
	[drawPlayViewController initializeDrawMode];
	drawPlayViewController.playName = @"New Play";
	[[self navigationController] pushViewController:drawPlayViewController animated:YES];
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


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [savedNames count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
	cell.textLabel.text = [savedNames objectAtIndex:indexPath.row];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
    return cell;
}

- (void)reloadSavedPlays {
	//savedNames = [[NSMutableArray alloc] initWithArray:[appDelegate.savedplays allKeys]];
	savedNames = [[NSMutableArray alloc] initWithArray:[appDelegate.savedplays allKeys]];
//	[self.tableView reloadData];
}


// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
	drawPlayViewController.drawMode = FALSE;
	[drawPlayViewController initializeViewMode:indexPath.row];
	[[self navigationController] pushViewController:drawPlayViewController animated:YES];
	drawPlayViewController.playName = [savedNames objectAtIndex:indexPath.row];
//	drawPlayViewController.title = drawPlayViewController.playName;
//	drawPlayViewController.currentFrameNumber = 0;
//	NSArray *savedNames = [[NSArray alloc] initWithArray:[appDelegate.savedplays allKeys]];
//	playName = [savedNames objectAtIndex:playNum];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

	if (editingStyle == UITableViewCellEditingStyleDelete) {
		// Delete the row from the data source.
		[tableView beginUpdates];
		[appDelegate.savedplays removeObjectForKey:[savedNames objectAtIndex:indexPath.row]];
		[self reloadSavedPlays];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
		[tableView endUpdates];
	}
	else if (editingStyle == UITableViewCellEditingStyleInsert) {
		// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
	}
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



- (void)dealloc {
    [super dealloc];
}

@end