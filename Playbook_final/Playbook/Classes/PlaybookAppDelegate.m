//
//  PlaybookAppDelegate.m
//  Playbook
//
//  Created by Alex on 3/28/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "PlaybookAppDelegate.h"
#define savedPlaysFilename @"SavedPlays.plist"


@implementation PlaybookAppDelegate
@synthesize theTempScorer;
@synthesize theTempScoreAmount;
@synthesize window;
@synthesize tabBarController;
@synthesize roster;
@synthesize notes;
@synthesize playStats;
@synthesize positionKey;
@synthesize activePlayers;
@synthesize savedplays;
@synthesize rosterListPath;
@synthesize notesPath;
@synthesize playStatsPath;
@synthesize savedPlaysListPath;
@synthesize needToUpdateSavedPlayList;
@synthesize tempShot;
@synthesize statPlayer;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	theTempScorer = nil;
	theTempScoreAmount = 2;
    
    // Add the tab bar controller's current view as a subview of the window
    [window addSubview:tabBarController.view];
	
	activePlayers = [NSMutableDictionary dictionaryWithCapacity:5];
	[activePlayers retain];
	NSString *error;
	NSPropertyListFormat format;
	
	// Load saved roster from .plist
	NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]; // gets the document directory
	rosterListPath = [rootPath stringByAppendingPathComponent:@"Roster.plist"];
	if(![[NSFileManager defaultManager] fileExistsAtPath:rosterListPath]) {
		rosterListPath = [[NSBundle mainBundle] pathForResource:@"Roster" ofType:@"plist"];
	}
	[rosterListPath retain];
	NSData *rosterListXML = [[NSFileManager defaultManager] contentsAtPath:rosterListPath];
	NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization propertyListFromData: rosterListXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription: &error];
	roster = [NSMutableDictionary dictionaryWithDictionary: temp]; // perhaps this is stored in an instance variable, in which case you'd want to retain it
	[roster retain];
	
    // Load saved notes from plist
    notesPath = [rootPath stringByAppendingPathComponent:@"Notes.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:notesPath]) {
        notesPath = [[NSBundle mainBundle] pathForResource:@"Notes" ofType:@"plist"];
    }
    [notesPath retain];
    NSData *notesXML = [[NSFileManager defaultManager] contentsAtPath:notesPath];
    NSArray *tempNotes = (NSArray *)[NSPropertyListSerialization propertyListFromData:notesXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&error];
    notes = [NSMutableArray arrayWithArray:tempNotes];
    [notes retain];

	playStatsPath = [rootPath stringByAppendingPathComponent:@"PlayStats.plist"];
	if(![[NSFileManager defaultManager] fileExistsAtPath:playStatsPath]) {
		playStatsPath = [[NSBundle mainBundle] pathForResource:@"PlayStats" ofType:@"plist"];
	}
	[playStatsPath retain];
	NSData *playStatsXML = [[NSFileManager defaultManager] contentsAtPath:playStatsPath];
	temp = (NSDictionary *)[NSPropertyListSerialization propertyListFromData: playStatsXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription: &error];
	playStats = [NSMutableDictionary dictionaryWithDictionary: temp]; // perhaps this is stored in an instance variable, in which case you'd want to retain it
	[playStats retain];

	// Load saved plays from .plist
	savedPlaysListPath = [rootPath stringByAppendingPathComponent:@"SavedPlays.plist"];
	if(![[NSFileManager defaultManager] fileExistsAtPath:savedPlaysListPath]) {
		savedPlaysListPath = [[NSBundle mainBundle] pathForResource:@"SavedPlays" ofType:@"plist"];
	}
	NSData *savedPlaysListXML = [[NSFileManager defaultManager] contentsAtPath:savedPlaysListPath];
	NSDictionary *temp2 = (NSDictionary *)[NSPropertyListSerialization propertyListFromData: savedPlaysListXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription: &error];
	savedplays = [NSMutableDictionary dictionaryWithDictionary: temp2]; // perhaps this is stored in an instance variable, in which case you'd want to retain it
	[savedplays retain];
//	savedplays = [[NSMutableDictionary alloc] init];
	
	// Saved Plays initialization
//	NSString *savedplayspath = [self savedPlaysDataFilePath];
//	if ([[NSFileManager defaultManager] fileExistsAtPath:savedplayspath]) {
//		savedplays = [[NSMutableDictionary alloc] initWithContentsOfFile:savedplayspath];
//	}
//	else {
//		savedplays = [[NSMutableDictionary alloc] init];
//	}
	
	// telling it to call UIApplicationWillTerminate later - borrowed from iphonedevbook.com, chapter 11
	UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillTerminate:)
                                                 name:UIApplicationWillTerminateNotification 
                                               object:app];	
}

// borrowed from iphonedevbook.com, chapter 11
- (NSString *)savedPlaysDataFilePath {
	//	PainterAppDelegate *appDelegate = (PainterAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
	//	NSLog(appDelegate.dotsFilename);
    return [documentsDirectory stringByAppendingPathComponent:savedPlaysFilename];
}

/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/

/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/

// based on code segment from iphonedevbook.com, chapter 11
- (void)applicationWillTerminate:(NSNotification *)notification {
	NSString *error;
	NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *rosterPath = [rootPath stringByAppendingPathComponent:@"Roster.plist"];
    NSString *notesPath = [rootPath stringByAppendingPathComponent:@"Notes.plist"];
	NSString *savedPlaysPath = [rootPath stringByAppendingPathComponent:@"SavedPlays.plist"];
	NSString *playStPath = [rootPath stringByAppendingPathComponent:@"PlayStats.plist"];
	NSData *rosterData = [NSPropertyListSerialization dataFromPropertyList: roster format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
    NSData *notesData = [NSPropertyListSerialization dataFromPropertyList:notes format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
	NSData *savedPlaysData = [NSPropertyListSerialization dataFromPropertyList:savedplays format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
	NSData *playStatsData = [NSPropertyListSerialization dataFromPropertyList:playStats format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
	if(rosterData) {
		[rosterData writeToFile:rosterPath atomically:YES];
	}
	/*if([savedplays writeToFile:[self savedPlaysDataFilePath] atomically:YES]) {
		NSLog(@"successfully saved plays");
	}
	else {
		NSLog(@"failed to save plays");
	}*/
    if (notesData) {
        [notesData writeToFile:notesPath atomically:YES];
    }
	if(savedPlaysData) {
		[savedPlaysData writeToFile:savedPlaysPath atomically:YES];
	}
	if(playStatsData){
		[playStatsData writeToFile:playStPath atomically:YES];
	}
}

- (void)dealloc {
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end

