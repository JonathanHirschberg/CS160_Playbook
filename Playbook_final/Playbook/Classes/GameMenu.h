//
//  GameMenu.h
//  Playbook
//
//  Created by Brian Chin on 4/2/10.
//  Copyright 2010 University of California, Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Foul;
@class Shot;
@class PlaybookAppDelegate;
@class ReboundController;
@interface GameMenu : UIViewController {
	PlaybookAppDelegate *appDelegate;
}

@property (nonatomic, retain) PlaybookAppDelegate *appDelegate;
-(IBAction)reboundButton:(id)sender;
-(IBAction)shotButton:(id)sender;
-(IBAction)foulButton:(id)sender;
-(IBAction)substitutionButton:(id)sender;
-(IBAction)playSuccessButton:(id)sender;
-(IBAction)playFailureButton:(id)sender;

@end
