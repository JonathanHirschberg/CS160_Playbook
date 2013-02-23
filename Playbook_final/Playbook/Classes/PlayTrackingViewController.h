//
//  PlayTrackingViewController.h
//  Playbook
//
//  Created by Charles Liu on 4/3/10.
//  Copyright 2010 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlaybookAppDelegate;
@interface PlayTrackingViewController : UITableViewController {
	NSInteger mode;
	NSMutableArray *playNames;
	PlaybookAppDelegate *appDelegate;
}
@property (nonatomic, retain) NSMutableArray *playNames;
@property (nonatomic, retain) PlaybookAppDelegate *appDelegate;
@property (nonatomic) NSInteger mode;
@end
