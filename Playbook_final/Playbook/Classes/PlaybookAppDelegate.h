//
//  PlaybookAppDelegate.h
//  Playbook
//
//  Created by Alex on 3/28/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaybookAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
	NSMutableDictionary *roster;
    NSMutableArray *notes;
	NSMutableDictionary *playStats;
	NSDictionary *positionKey;
	NSMutableDictionary *activePlayers;
	NSMutableDictionary *savedplays;
	NSString *rosterListPath;
    NSString *notesPath;
	NSString *playStatsPath;
	NSString *savedPlaysListPath;
	BOOL needToUpdateSavedPlayList;
	NSString *theTempScorer;
	NSInteger theTempScoreAmount;
	UIViewController *tempShot;
	NSString *statPlayer;
}
@property (nonatomic, retain) NSString *statPlayer;
@property (nonatomic, retain) UIViewController *tempShot;
@property (nonatomic, retain) NSString *theTempScorer;
@property (nonatomic) NSInteger theTempScoreAmount;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) NSMutableDictionary *roster;
@property (nonatomic, retain) NSMutableArray *notes;
@property (nonatomic, retain) NSMutableDictionary *playStats;
@property (nonatomic, retain) NSDictionary *positionKey;
@property (nonatomic, retain) NSMutableDictionary *activePlayers;
@property (nonatomic, retain) NSMutableDictionary *savedplays;
@property (nonatomic, retain) NSString *rosterListPath;
@property (nonatomic, retain) NSString *notesPath;
@property (nonatomic, retain) NSString *playStatsPath;
@property (nonatomic, retain) NSString *savedPlaysListPath;
@property BOOL needToUpdateSavedPlayList;
- (void)applicationWillTerminate:(NSNotification *)notification;
- (NSString *)savedPlaysDataFilePath;

@end
