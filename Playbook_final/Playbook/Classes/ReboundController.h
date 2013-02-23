//
//  ReboundController.h
//  Playbook
//
//  Created by Brian Chin on 4/4/10.
//  Copyright 2010 University of California, Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PlaybookAppDelegate;

@interface ReboundController : UIViewController {
	PlaybookAppDelegate *appDelegate;
	NSString *rebounder;	

}
@property (retain, nonatomic) NSString *rebounder;
@property (retain, nonatomic) PlaybookAppDelegate *appDelegate;


@end
