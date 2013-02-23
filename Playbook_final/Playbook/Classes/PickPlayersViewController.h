//
//  PickPlayersViewController.h
//  Playbook
//
//  Created by Brian Chin on 4/2/10.
//  Copyright 2010 University of California, Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PlaybookAppDelegate;
@class GameMenu;

@interface PickPlayersViewController: UIViewController<UITableViewDelegate> {
	PlaybookAppDelegate *appDelegate;
	NSArray *playerNames;
	UITableView *rosterTable;
    UINavigationController *gameController;
    NSMutableDictionary *oldActivePlayers;
    UINavigationItem *navItem;
}

@property (retain, nonatomic) PlaybookAppDelegate *appDelegate;
@property (retain, nonatomic) NSArray *playerNames;
@property (retain, nonatomic) IBOutlet UITableView *rosterTable;
@property (retain, nonatomic) UINavigationController *gameController;
@property (retain, nonatomic) IBOutlet UINavigationItem *navItem;
- (IBAction)gameTrack;
- (IBAction)cancel;
@end
