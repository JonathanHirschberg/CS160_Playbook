//
//  DrawPlayViewController.h
//  Playbook
//
//  Created by Class Account on 3/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
//  drawing a line is easy.  drawing an arrow is hard.  we may save that for the coding after the interactive prototype
//  toolbar tutorial: http://www.iphonesdkarticles.com/2008/09/navigation-controller-uitoolbar.html

#import <UIKit/UIKit.h>


@interface DrawPlayViewController : UIViewController {
	PlaybookAppDelegate *appDelegate;
	BOOL drawMode;
	NSMutableArray *playData; // structure that holds all frames
	NSMutableArray *frameData; // structure that holds positions of all drawable things in frame
	int untitledCounter; // allow people to save untitled plays if they don't enter anything
	int currentPlayNumber;
	int currentFrameNumber;
	BOOL hasBeenSaved;
	BOOL playHasBeenSaved;
	int AlertType; // 0 is quit alert view, 1 is save frame, 2 is new frame
	UIToolbar *toolbar;
	DrawPlayView *myDrawPlayView;
	NSString *playName;
	BOOL editMode;
}
@property (retain, nonatomic) PlaybookAppDelegate *appDelegate;
@property BOOL drawMode;
@property (nonatomic, retain) NSMutableArray *playData;
@property (nonatomic, retain) NSMutableArray *frameData;
@property int untitledCounter;
@property int currentPlayNumber;
@property int currentFrameNumber;
@property BOOL hasBeenSaved;
@property BOOL playHasBeenSaved;
@property int AlertType;
@property (nonatomic, retain) DrawPlayView *myDrawPlayView;
@property (nonatomic, retain) NSString *playName;
@property BOOL editMode;

-(void)initializeViewMode:(int)playNum; // initializes playData with a new frame
-(IBAction)nextFrameView:(id)sender; // advances to next frame in playback sequence
-(IBAction)prevFrameView:(id)sender; // advances to next frame in playback sequence
-(void)initializeDrawMode; // initializes playData with a new frame
-(void)initializeFrame; // initializes frameData with an array for player positions and an array for arrows
//-(IBAction)saveFrame:(id)sender; // incorporates current frame into playData
-(void)savePlay:(NSString *)nameOfPlay; // incorporates current playData into array of saved plays
-(IBAction)clearFrame:(id)sender; // clears frame (basically releases it)
-(IBAction)clearPlay:(id)sender; // clears play (basically releases it)
-(IBAction)savePlayAction:(id)sender; // clears play (basically releases it)
-(IBAction)saveFrame:(id)sender; // saves copy of frame into playData
-(IBAction)editSaveFrame:(id)sender; // saves copy of frame into playData
-(void)saveFrameData:(int)frameNum; // saveFrame calls this to save frame data into playData
-(IBAction)nextFrame:(id)sender; // initializes new frame with last player positions in frame
-(void)initializeNextFrameData; // initializes frameData with an array for player positions and an array for arrows
- (IBAction)quitDrawPlay:(id) sender; // quits drawing the play, goes back to saved play list
- (void) alertView:(UIAlertView *) alertView clickedButtonAtIndex: (int) index;
- (int)numberOfFrames:(int)playNum;
- (IBAction)clearCanvas:(id)sender;

@end
