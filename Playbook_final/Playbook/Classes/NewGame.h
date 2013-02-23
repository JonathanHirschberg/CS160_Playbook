//
//  NewGame.h
//  Playbook
//
//  Created by Brian Chin on 4/2/10.
//  Copyright 2010 University of California, Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewGame;
@class RosterViewController;
@class PickPlayersViewController;
@class PlaybookAppDelegate;

@interface NewGame : UIViewController {
	PlaybookAppDelegate *appDelegate;	
}

@property (nonatomic, retain) PlaybookAppDelegate *appDelegate;
- (IBAction)newGameButton:(id)sender;
- (IBAction)enterRosterButton:(id)sender;
@end
