//
//  AddPlayerViewController.h
//  Playbook
//
//  Created by Class Account on 3/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddPlayerViewController : UIViewController<UIAlertViewDelegate> {
	UITextField *playerName;
	UITextField *playerNumber;
	UISegmentedControl *playerPosition;
	UIButton *deleteButton;
	NSMutableDictionary *playerEntry;
	PlaybookAppDelegate *appDelegate;
	
	NSUInteger mode;
	NSString *name;
	NSString *number;
	NSString *position;
}
@property (nonatomic, retain) IBOutlet UITextField *playerName;
@property (nonatomic, retain) IBOutlet UITextField *playerNumber;
@property (nonatomic, retain) IBOutlet UIButton *deleteButton;
@property (nonatomic, retain) IBOutlet UISegmentedControl *playerPosition;
@property (nonatomic, retain) NSMutableDictionary *playerEntry;
@property (nonatomic, retain) PlaybookAppDelegate *appDelegate;
@property (nonatomic) NSUInteger mode;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *number;
@property (nonatomic, retain) NSString *position;
-(IBAction) deletePlayer:(id)sender;
@end
