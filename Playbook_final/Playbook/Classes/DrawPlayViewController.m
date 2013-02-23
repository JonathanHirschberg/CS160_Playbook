//
//  DrawPlayViewController.m
//  Playbook
//
//  Created by Class Account on 3/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
//  Done will bring up an alert that asks if you want to save it.  Type in name and click yes, no, or cancel.
//  At this point in time, you can't load and modify a play and save it.  Have to create a new one.

#import "PlaybookAppDelegate.h"
#import "DrawPlayView.h"
#import "DrawPlayViewController.h"
#import "PointWrapper.h"

@implementation DrawPlayViewController
@synthesize appDelegate;
@synthesize drawMode;
@synthesize frameData;
@synthesize playData;
@synthesize untitledCounter;
@synthesize currentPlayNumber;
@synthesize currentFrameNumber;
@synthesize hasBeenSaved;
@synthesize playHasBeenSaved;
@synthesize AlertType;
@synthesize myDrawPlayView;
@synthesize playName;
@synthesize editMode;
	
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

-(void)initializeViewMode:(int)playNum {
	UIBarButtonItem *forwardButton = [[UIBarButtonItem alloc] initWithTitle:@"Save Play" style:UIBarButtonItemStylePlain target:self action:@selector(savePlayAction: )];
	self.navigationItem.rightBarButtonItem = nil; //forwardButton;
	
	UIBarButtonItem *prevFrameButton = [[UIBarButtonItem alloc]
										initWithTitle:@"Previous Step" style:UIBarButtonItemStyleBordered target:self action:@selector(prevFrameView:)];
	UIBarButtonItem *nextFrameButton = [[UIBarButtonItem alloc]
										initWithTitle:@"Next Step" style:UIBarButtonItemStyleBordered target:self action:@selector(nextFrameView:)];
	//UIBarButtonItem *editFrameButton = [[UIBarButtonItem alloc] 
	//									initWithTitle:@"Edit Step" style:UIBarButtonItemStyleBordered target:self action:@selector(editFrame: )];
	[toolbar setItems:[NSArray arrayWithObjects:prevFrameButton,nextFrameButton,nil]];
	
	[self.view initializeViewMode:playNum];
	currentPlayNumber = playNum;
	playHasBeenSaved = TRUE;
	NSArray *savedNames = [[NSArray alloc] initWithArray:[appDelegate.savedplays allKeys]];
	playName = [savedNames objectAtIndex:playNum];
	int CFN = [self.view currentFrameNumber];
	self.title = [[NSString alloc] initWithFormat:@"%@: %d/%d", playName, CFN+1, [self numberOfFrames:currentPlayNumber]];
}

- (int)numberOfFrames:(int)playNum {
	NSArray *savedNames = [[NSArray alloc] initWithArray:[appDelegate.savedplays allKeys]];
	return [[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] count];
}

-(IBAction)nextFrameView:(id)sender { // higher level function that saves copy of frame, clears all arrows, leaves last player positions in frame
	[self.view nextFrameView:currentPlayNumber];
	int CFN = [self.view currentFrameNumber];
	self.title = [[NSString alloc] initWithFormat:@"%@: %d/%d", playName, CFN+1, [self numberOfFrames:currentPlayNumber]];
}

-(IBAction)prevFrameView:(id)sender { // higher level function that saves copy of frame, clears all arrows, leaves last player positions in frame
	[self.view prevFrameView];
	int CFN = [self.view currentFrameNumber];
	self.title = [[NSString alloc] initWithFormat:@"%@: %d/%d", playName, CFN+1, [self numberOfFrames:currentPlayNumber]];
}

-(IBAction)editFrame:(id)sender { // higher level that sets editing mode
	[self initializeFrame];
	[self.view initializeEditMode:currentPlayNumber fromFrame:[self.view currentFrameNumber]];
	editMode = TRUE;
	// set drawmode to true, load the default starting positions from current frame's values, then change edit button to save button.
	UIBarButtonItem *editSaveButton = [[UIBarButtonItem alloc] 
									   initWithTitle:@"Save Step" style:UIBarButtonItemStyleBordered target:self action:@selector(editSaveFrame: )];
	UIBarButtonItem *prevFrameButton = [[UIBarButtonItem alloc]
										initWithTitle:@"Previous Step" style:UIBarButtonItemStyleBordered target:self action:@selector(prevFrameView:)];
	UIBarButtonItem *nextFrameButton = [[UIBarButtonItem alloc]
										initWithTitle:@"Next Step" style:UIBarButtonItemStyleBordered target:self action:@selector(nextFrameView:)];
	[toolbar setItems:[NSArray arrayWithObjects:/*prevFrameButton,nextFrameButton,*/editSaveButton,nil]];
	
}

- (IBAction)clearCanvas:(id)sender {
	[self.view clearCanvas];
}

-(void)initializeDrawMode {
	UIBarButtonItem *forwardButton = [[UIBarButtonItem alloc] initWithTitle:@"Save Play" style:UIBarButtonItemStylePlain target:self action:@selector(savePlayAction: )];
	self.navigationItem.rightBarButtonItem = forwardButton;
	self.title = [[NSString alloc] initWithFormat:@"Start Positions", playName];
	playHasBeenSaved = TRUE;
	editMode = FALSE;
	playData = [[NSMutableArray alloc] init];
	[self initializeFrame];
	[self.view initializeDrawMode];
}

-(void)initializeFrame {
	hasBeenSaved = FALSE;
	frameData = [[NSMutableArray alloc] init];
	// 0th index is array of marker positions, 1st index is array of arrows
	NSMutableArray *playpositions = [[NSMutableArray alloc] init];
	NSMutableArray *playmovements = [[NSMutableArray alloc] init];
	[frameData addObject:playpositions];
	[frameData addObject:playmovements];
	
	[playpositions release];
	[playmovements release];
}

/*-(IBAction)saveFrame:(id)sender // incorporates current frame into playData
{
	[playData addObject:frameData];
}*/

-(void)savePlay:(NSString *)nameOfPlay // incorporates current playData into array of saved plays
{
    if([self.view needsSave]) {
        [self saveFrameData:-1];
	}
    
	if(!playHasBeenSaved) {
		[appDelegate.savedplays setObject:playData forKey:nameOfPlay];
		NSNumber *zero = [NSNumber numberWithInt:0];
		NSArray *stats = [NSArray arrayWithObjects: zero, zero, nil];
		[appDelegate.playStats setObject:stats forKey: nameOfPlay];
		appDelegate.needToUpdateSavedPlayList = TRUE;
		playHasBeenSaved = TRUE;
		[playData release];
	
		//	NSArray *savedNames = [[NSArray alloc] initWithArray:[appDelegate.savedplays allKeys]];
		
	/*
	for(int i = 0; i < [appDelegate.savedplays count]; i++) { // loop through plays
		for(int h = 0; h < [[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:i]] count]; h++) { // loop through frames
			for(int j = 0; j < [[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:i]] objectAtIndex:h] objectAtIndex:0] objectAtIndex:0] count]; j++) { // loop through xy coordinates
				NSLog(@"play #%d frame #%d player number %d: x: %@, y: %@", i, h, j, [[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:i]] objectAtIndex:h] objectAtIndex:0] objectAtIndex:0] objectAtIndex:j], [[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:i]] objectAtIndex:h] objectAtIndex:0] objectAtIndex:1] objectAtIndex:j]);
			}
	
			for(int j = 0; j < [[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:i]] objectAtIndex:h] objectAtIndex:1] count]; j++) { // loop over lines
				for(int k = 0; k < [[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:i]] objectAtIndex:h] objectAtIndex:1] objectAtIndex:j] objectAtIndex:0] count]; k++) { // loop through xy coordinates
					NSLog(@"play #%d frame #%d line #%d point #%d x: %@, y: %@", i, h, j, k, [[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:i]] objectAtIndex:h] objectAtIndex:1] objectAtIndex:j] objectAtIndex:0] objectAtIndex:k], [[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:i]] objectAtIndex:h] objectAtIndex:1] objectAtIndex:j] objectAtIndex:1] objectAtIndex:k]);
				}
			}
		}
	}*/
	}
}

-(IBAction)clearFrame:(id)sender // clears frame (basically releases it)
{
	[frameData release];
}

-(IBAction)clearPlay:(id)sender // clears play (basically releases it)
{
	[playData release];
}

-(IBAction)savePlayAction:(id)sender
{
	if(drawMode) { // fixme: disabled save right now for edit mode because it's not implemented yet
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Save Play"
													message:@"Enter name of play" 
												   delegate:self  cancelButtonTitle:@"Cancel"   
										  otherButtonTitles:@"Save", nil];
		[alert addTextFieldWithValue:@"" label:@"Enter Name of Play"];
	
		// Customise name field 
		UITextField* playName = [alert textFieldAtIndex:0]; 
		playName.clearButtonMode = UITextFieldViewModeWhileEditing;
		playName.keyboardType = UIKeyboardTypeAlphabet; 
		playName.keyboardAppearance = UIKeyboardAppearanceAlert;
        playName.autocapitalizationType = UITextAutocapitalizationTypeWords;
		AlertType = 0;
		[alert show];
	}
}

-(IBAction)saveFrame:(id)sender // higher level function that saves copy of frame, clears all arrows, leaves last player positions in frame
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"New Play"
													message:@"Step has been Saved" 
												   delegate:self  cancelButtonTitle:@"OK"   
										  otherButtonTitles:nil];
	AlertType = 1;
	[alert show];
	
	// if user wants to modify and resave the current frame, have to remove the old version of the frame before resaving
	[self saveFrameData:-1];
}

-(IBAction)editSaveFrame:(id)sender // when in edit mode and you save
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle: self.title
													message:@"Step has been Saved" 
												   delegate:self  cancelButtonTitle:@"OK"   
										  otherButtonTitles:nil];
	AlertType = 1;
	[alert show];
	NSLog(@"needs to be saved %d", [self.view needsSave]);
	[self saveFrameData:[self.view currentFrameNumber]];
}

- (void)saveFrameData:(int)frameNum {
	if(!hasBeenSaved) {
	}
	else {
//		NSLog(@"removing older version of frame");
		[playData removeLastObject];
	}
	
	if(!editMode) { // if not edit saving, call this function instead
		[self.view savePlayerPositions];
		playHasBeenSaved = FALSE;
	}
	else {
		[self.view editSavePlayerPositions:currentPlayNumber fromFrame:frameNum];
		playHasBeenSaved = TRUE;

//		NSLog(@"made it out aliveasdlifhdsaljfadkrsjflkdsjfladkjflsdjkf");
		// access frameData player positions and then the x's or y's
//		NSLog(@"%d", [[self.view playerx] count]);
//		NSLog(@"%d", [[frameData objectAtIndex:0] count]);
//		[[frameData objectAtIndex:0] replaceObjectAtIndex:0 withObject:[self.view playerx]];
//		[[frameData objectAtIndex:0] replaceObjectAtIndex:1 withObject:[self.view playery]];
	}
	// access frameData player positions and then the x's or y's
	[[frameData objectAtIndex:0] addObject:[self.view playerx]];
	[[frameData objectAtIndex:0] addObject:[self.view playery]];
	
	// frameData player movements and add the individual lines.
	[[frameData objectAtIndex:1] addObject:[self.view p1line]];
	[[frameData objectAtIndex:1] addObject:[self.view p2line]];
	[[frameData objectAtIndex:1] addObject:[self.view p3line]];
	[[frameData objectAtIndex:1] addObject:[self.view p4line]];
	[[frameData objectAtIndex:1] addObject:[self.view p5line]];
	[[frameData objectAtIndex:1] addObject:[self.view ballline]];
	if(!editMode) { // adding new frame
		[playData addObject:frameData];
	}
	else { // replacing modified frame
		NSArray *savedNames = [[NSArray alloc] initWithArray:[appDelegate.savedplays allKeys]];
		[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:currentPlayNumber]] replaceObjectAtIndex:frameNum withObject:frameData];
		
		//UIBarButtonItem *editFrameButton = [[UIBarButtonItem alloc] 
		//									initWithTitle:@"Edit Step" style:UIBarButtonItemStyleBordered target:self action:@selector(editFrame: )];
		UIBarButtonItem *prevFrameButton = [[UIBarButtonItem alloc]
											initWithTitle:@"Previous Step" style:UIBarButtonItemStyleBordered target:self action:@selector(prevFrameView:)];
		UIBarButtonItem *nextFrameButton = [[UIBarButtonItem alloc]
											initWithTitle:@"Next Step" style:UIBarButtonItemStyleBordered target:self action:@selector(nextFrameView:)];
		[toolbar setItems:[NSArray arrayWithObjects:prevFrameButton,nextFrameButton,nil]];
		[self.view returnToViewMode:currentPlayNumber];
		editMode = FALSE;
	}
	
	hasBeenSaved = TRUE;
}

-(IBAction)nextFrame:(id)sender // higher level function that saves copy of frame, clears all arrows, leaves last player positions in frame
{
	if([self.view needsSave]) {
		hasBeenSaved = FALSE;
	}
	if(!hasBeenSaved) {
        [self saveFrameData:-1];
//		UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"New Play"
//														message:@"Step has not yet been saved!" 
//													   delegate:self  cancelButtonTitle:@"Cancel"   
//											  otherButtonTitles:@"Save", @"Don't Save", nil];
//		AlertType = 2;
//		[alert show];
	}
	//else {
		[self initializeNextFrameData];
	//}
}

-(void)initializeNextFrameData {
	// make new frame
	playHasBeenSaved = FALSE;
	NSLog(@"called nextFrame");
//	[[[frameData objectAtIndex:0] objectAtIndex:0] removeAllObjects];
//	[[[frameData objectAtIndex:0] objectAtIndex:1] removeAllObjects];

	/*
	 savedplays
		playData (one for each play)
			frameData (one for each frame in play)
				0: playpositions
					0: x's
					1: y's
				1: playmovements
					0: lines
						0: x's
						1: y's
	    playData
			frameData
	            0: playpositions
	                0: x's
	                1: y's
	            1: playmovements
				    0: lines
	                    0: x's
	                    1: y's
	 */
	
	NSLog(@"in nextFrame");

//	[self.view setFirstFrameBooleanVariable:FALSE];
	// initializeFrameData sets it to false.  No danger of it being wrongly set to false because the initializeDrawMode function sets it to true after initializeFrameData is called

	hasBeenSaved = FALSE;
	/*
	NSLog(@"player xy");
	for(int j = 0; j < [[[frameData objectAtIndex:0] objectAtIndex:0] count]; j++) {
		NSLog(@"player number %d: x: %@, y: %@", j, [[[frameData objectAtIndex:0] objectAtIndex:0] objectAtIndex:j], [[[frameData objectAtIndex:0] objectAtIndex:1] objectAtIndex:j]);
	}
	
	NSLog(@"player lines");
	for(int j = 0; j < [[frameData objectAtIndex:1] count]; j++) {
		for(int k = 0; k < [[[[frameData objectAtIndex:1] objectAtIndex:j] objectAtIndex:0] count]; k++) {
			NSLog(@"line %d point number %d: x: %@, y: %@", j, k, [[[[frameData objectAtIndex:1] objectAtIndex:j] objectAtIndex:0] objectAtIndex:k], [[[[frameData objectAtIndex:1] objectAtIndex:j] objectAtIndex:1] objectAtIndex:k]);
		}
	}*/
	
	[self.view clearFrameData];
	[self.view initializeFrameData];
	[frameData release];
	[self initializeFrame];

	// increment view's currentFrameNumber
	self.title = [[NSString alloc] initWithFormat:@"Step %d", [self.view currentFrameNumber]];

	//	[markerPosition release];
	[self.view setNeedsDisplay];
}

// clear frame is done by shaking action

- (IBAction)quitDrawPlay:(id) sender {
/* http://stackoverflow.com/questions/833392/showing-a-alertview-with-a-textbox-in-iphone
 This will be used for when user wants to quit.  It pops up an alert asking if user wants to
 save play and types in play name and clicks yes.  User can also click no to go back and not save, 
 or cancel to stay with the current frame.*/
//	if(drawMode == FALSE) {
//		[self.navigationController popToRootViewControllerAnimated:YES];
//	}
	
	if(!playHasBeenSaved) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Play has not yet been saved!"
														message:@"Enter name of play" 
													   delegate:self  cancelButtonTitle:@"Don't Save"   
											  otherButtonTitles:@"Save", nil];
		[alert addTextFieldWithValue:@""label:@"Enter Name of Play"];
		
		// Customise name field 
		UITextField* playName = [alert textFieldAtIndex:0];	
		playName.clearButtonMode = UITextFieldViewModeWhileEditing;
		playName.keyboardType = UIKeyboardTypeAlphabet; 
		playName.keyboardAppearance = UIKeyboardAppearanceAlert;
		AlertType = 3;
		[alert show];
	}
	else {
		[self.navigationController popToRootViewControllerAnimated:YES];
	}

	
//	else {
/*		UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Save Play and Return?"
														message:@"Enter name of play" 
													   delegate:self  cancelButtonTitle:@"Cancel"   
											  otherButtonTitles:@"Save", @"Don't Save", nil];
		[alert addTextFieldWithValue:@""label:@"Enter Name of Play"]; 
 
		// Customise name field 
		UITextField* playName = [alert textFieldAtIndex:0]; 
		playName.clearButtonMode = UITextFieldViewModeWhileEditing; 
		playName.keyboardType = UIKeyboardTypeAlphabet; 
		playName.keyboardAppearance = UIKeyboardAppearanceAlert;
		AlertType = 0;
//		[alert show];
	}*/
}

- (void) alertView:(UIAlertView *) alertView clickedButtonAtIndex: (int) index
{
	switch(AlertType) {
		case 0:
			switch(index) {
				case 1:
					if([[[alertView textFieldAtIndex:0] text] length] > 0) { // if no name entered, make it untitled
						[self savePlay:[[alertView textFieldAtIndex:0] text]];
					}
					else {
						NSString *pN = [[NSString alloc] initWithFormat:@"untitled %d", untitledCounter];
						untitledCounter++;
						[self savePlay:pN];
					}
					[self.navigationController popToRootViewControllerAnimated:YES];
					break;
//				case 2:
//					//			[[self.view frameData] removeAllObjects];
//					[self.navigationController popToRootViewControllerAnimated:YES];
//					break;
				case 0:
					break;
			}
			break;
		case 1: // just an ok button
			break;
		case 2: // alert only shows if you try to add a new frame without saving the old one
			switch(index) {
				case 1:
					[self saveFrameData:-1];
				case 2:
					[self initializeNextFrameData];
					break;
				case 0:
					break;
			}
			break;
		case 3:
			switch(index) {
				case 1:
					if([[[alertView textFieldAtIndex:0] text] length] > 0) { // if no name entered, make it untitled
						[self savePlay:[[alertView textFieldAtIndex:0] text]];
					}
					else {
						NSString *pN = [[NSString alloc] initWithFormat:@"untitled %d", untitledCounter];
						untitledCounter++;
						[self savePlay:pN];
					}
				case 0:
					[self.navigationController popToRootViewControllerAnimated:YES];
					break;
			}
	}
	[alertView release];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	appDelegate = (PlaybookAppDelegate *)[[UIApplication sharedApplication] delegate];

    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(quitDrawPlay: )];
    self.navigationItem.leftBarButtonItem = backButton;
//	later versions, if we want to get fancy, then when you load a play, the edit button can 
//  allow you to delete the current frame.  but then do we have to restore continuity somehow?
	
	untitledCounter = 0;
	editMode = FALSE;
	self.title = @"New Play";
	
	if(drawMode == TRUE) {
		[self initializeDrawMode];
	}
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
//	playName = self.title;
	editMode = FALSE;

	// toolbar setup http://www.iphonesdkarticles.com/2008/09/navigation-controller-uitoolbar.html
	toolbar = [[UIToolbar alloc] init];
	toolbar.barStyle = UIBarStyleDefault;
	toolbar.tintColor = [UIColor colorWithRed:0.011764 green:0.37254 blue:0.56862 alpha:1.0];
	[toolbar sizeToFit];
	CGRect rootViewBounds = self.parentViewController.view.bounds;
	CGFloat toolbarHeight = [toolbar frame].size.height;
	NSLog(@"toolbar height: %f", toolbarHeight);
	CGFloat rootViewHeight = CGRectGetHeight(rootViewBounds);
	CGFloat rootViewWidth = CGRectGetWidth(rootViewBounds);
	CGRect rectArea = CGRectMake(0, rootViewHeight - toolbarHeight, rootViewWidth, toolbarHeight);
	[self.navigationController.view addSubview:toolbar];

	// Create buttons
	UIBarButtonItem *prevFrameButton = [[UIBarButtonItem alloc]initWithTitle:@"Previous Step" style:UIBarButtonItemStyleBordered target:self action:@selector(prevFrameView:)];
	UIBarButtonItem *nextFrameButton = [[UIBarButtonItem alloc]initWithTitle:@"Next Step" style:UIBarButtonItemStyleBordered target:self action:@selector(nextFrameView:)];
	UIBarButtonItem *newFrameButton = [[UIBarButtonItem alloc]initWithTitle:@"Next Step" style:UIBarButtonItemStyleBordered target:self action:@selector(nextFrame:)];
	UIBarButtonItem *clearCanvasButton = [[UIBarButtonItem alloc]initWithTitle:@"Undo Step" style:UIBarButtonItemStyleBordered target:self action:@selector(clearCanvas:)];
	//UIBarButtonItem *saveFrameButton = [[UIBarButtonItem alloc]initWithTitle:@"Save Step" style:UIBarButtonItemStyleBordered target:self action:@selector(saveFrame:)];
	//UIBarButtonItem *editFrameButton = [[UIBarButtonItem alloc]initWithTitle:@"Edit Step" style:UIBarButtonItemStyleBordered target:self action:@selector(editFrame:)];
	if(drawMode) {
		[toolbar setItems:[NSArray arrayWithObjects:newFrameButton,clearCanvasButton,nil]];
	}
	else {
		[toolbar setItems:[NSArray arrayWithObjects:prevFrameButton,nextFrameButton,nil]];
	}
	
	//FADE IN THE TABLE VIEW: http://www.iphonedevsdk.com/forum/iphone-sdk-development/2071-hide-fade-out-toolbar.html
	[toolbar setAlpha:0.0];		
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.25];
	[toolbar setAlpha:1.0];
	[UIView commitAnimations];
	
	[toolbar setFrame:rectArea];
}

- (void)viewWillDisappear:(BOOL)animated {
	//FADE IN THE TABLE VIEW: http://www.iphonedevsdk.com/forum/iphone-sdk-development/2071-hide-fade-out-toolbar.html
	[toolbar setAlpha:1.0];		
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.25];
	[toolbar setAlpha:0.0];
	[UIView commitAnimations];
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
//	[playData release];
//	[frameData release];
    [super dealloc];
}


@end
