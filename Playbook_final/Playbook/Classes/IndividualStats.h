//
//  IndividualStats.h
//  Playbook
//
//  Created by Brian Chin on 4/5/10.
//  Copyright 2010 University of California, Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PlaybookAppDelegate;

@interface IndividualStats : UITableViewController  {
	PlaybookAppDelegate *appDelegate;

}
@property (retain, nonatomic) PlaybookAppDelegate *appDelegate;

@end
