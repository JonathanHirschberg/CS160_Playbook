//
//  GameActions.h
//  Playbook
//
//  Created by Wei on 4/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlaybookAppDelegate;
@interface GameActions : UITableViewController {
	NSString *player;
	PlaybookAppDelegate *appDelegate;
}
@property (nonatomic, retain) NSString *player;
@property (nonatomic, retain) PlaybookAppDelegate *appDelegate;
@end
