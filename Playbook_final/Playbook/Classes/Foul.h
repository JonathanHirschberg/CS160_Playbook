//
//  Foul.h
//  Playbook
//
//  Created by Brian Chin on 4/2/10.
//  Copyright 2010 University of California, Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PlaybookAppDelegate;

@interface Foul : UIViewController {
	PlaybookAppDelegate *appDelegate;
	UISegmentedControl *foulType;
	NSString *rebounder;
	UITableViewCell *oldCell;
}

@property (retain, nonatomic) PlaybookAppDelegate *appDelegate;
@property (retain, nonatomic) UISegmentedControl *foulType;
@property (retain, nonatomic) NSString *rebounder;
@property (retain, nonatomic) UITableViewCell *oldCell;
@end
