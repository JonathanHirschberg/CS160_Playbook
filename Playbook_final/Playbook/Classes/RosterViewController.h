//
//  RosterViewController.h
//  Playbook
//
//  Created by Class Account on 3/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlaybookAppDelegate;
@interface RosterViewController : UITableViewController {
	PlaybookAppDelegate *appDelegate;
	NSArray *playerNames;
}
@property (retain, nonatomic) PlaybookAppDelegate *appDelegate;
@property (retain, nonatomic) NSArray *playerNames;
@end
