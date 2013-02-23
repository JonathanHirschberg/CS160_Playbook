//
//  Assists.h
//  Playbook
//
//  Created by Brian Chin on 4/4/10.
//  Copyright 2010 University of California, Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PlaybookAppDelegate;

@interface Assists : UIViewController {
	PlaybookAppDelegate *appDelegate;
	NSString *assistPlayer;
	UITableViewCell *oldCell;
}

@property (retain, nonatomic) PlaybookAppDelegate *appDelegate;
@property (retain, nonatomic) NSString *assistPlayer;
@property (retain, nonatomic) UITableViewCell *oldCell;
@end
