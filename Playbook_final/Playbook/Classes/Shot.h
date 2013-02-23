//
//  Shot.h
//  Playbook
//
//  Created by Brian Chin on 4/2/10.
//  Copyright 2010 University of California, Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PlaybookAppDelegate;

@interface Shot : UIViewController {
	UISegmentedControl *typeOfShot;
	PlaybookAppDelegate *appDelegate;
	UITableViewCell *oldCell;
}

@property (nonatomic, retain) IBOutlet UISegmentedControl *typeOfShot;
@property (retain, nonatomic) PlaybookAppDelegate *appDelegate;
@property (retain, nonatomic) UITableViewCell *oldCell;


@end
