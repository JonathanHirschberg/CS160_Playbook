//
//  PlayTrackingViewController.m
//  Playbook
//
//  Created by Charles Liu on 4/3/10.
//  Copyright 2010 UC Berkeley. All rights reserved.
//

#import "PlayTrackingViewController.h"
#import "PlaybookAppDelegate.h"

@implementation PlayTrackingViewController
@synthesize mode, playNames, appDelegate;
/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/


- (void)viewDidLoad {
    [super viewDidLoad];
	appDelegate = (PlaybookAppDelegate *)[[UIApplication sharedApplication] delegate];
	if(mode == -1){ // play sucess
		self.navigationItem.title = @"Failed Play";
	}else{ // play failure
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 145, 30)];
		[label setFont:[UIFont boldSystemFontOfSize:18.0]];
		[label setBackgroundColor:[UIColor clearColor]];
		label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
		[label setTextColor:[UIColor whiteColor]];
		[label setText:@"Successful Play"];
		[self.navigationItem setTitleView:label];
		[label release];
	}
	/*UIBarButtonItem *tempButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(goToGameMenu)];
	self.navigationItem.rightBarButtonItem = tempButton;
	[tempButton release];*/

}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	playNames = [[NSMutableArray alloc] initWithArray:[appDelegate.savedplays allKeys]];
	[playNames retain];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

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


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [playNames count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	cell.textLabel.text = [[playNames sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] objectAtIndex:indexPath.row];
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSArray *sortedPlayNames = [playNames sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
	NSArray *currStat = [appDelegate.playStats objectForKey:[sortedPlayNames objectAtIndex:indexPath.row]];
	NSArray *newStat;
	if(mode == -1){
		NSNumber *newFail = [NSNumber numberWithInt:([[currStat objectAtIndex:1] intValue] + 1)];
		newStat = [NSArray arrayWithObjects:[currStat objectAtIndex:0], newFail, nil];
		
	}else{
		NSNumber *newSuccess = [NSNumber numberWithInt:([[currStat objectAtIndex:0] intValue] + 1)];
		newStat = [NSArray arrayWithObjects:newSuccess, [currStat objectAtIndex:1], nil];
	}
	[appDelegate.playStats setObject:newStat forKey: [sortedPlayNames objectAtIndex:indexPath.row]];
	[self.navigationController popViewControllerAnimated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


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

