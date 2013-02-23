//
//  DrawPlayView.h
//  Playbook
//
//  Created by Class Account on 4/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DrawPlayView : UIView {
	PlaybookAppDelegate *appDelegate;

	// store temporary player positions as they are drawn on screen
	// current positions
	CGPoint p1pos;
	CGPoint p2pos;
	CGPoint p3pos;
	CGPoint p4pos;
	CGPoint p5pos;
	CGPoint ballpos;
	
	// past positions
	CGPoint prevp1pos;
	CGPoint prevp2pos;
	CGPoint prevp3pos;
	CGPoint prevp4pos;
	CGPoint prevp5pos;
	CGPoint prevballpos;
	
	float playerRadius;
	float ballRadius;
	CGContextRef contextRef;
	int pickedup; // the value is the player that is currently picked up.  0 for none, 1-5 for player, 6 for ball
	
	float strokered;
	float strokegreen;
	float strokeblue;
	float strokealpha;
	float strokethickness;

	float dotred;
	float dotgreen;
	float dotblue;
	float dotalpha;
	float dotradius;
	float dotdistance;
	
	// temporary arrays for all player movement lines.  when frame is saved, they'll be copied to frameData and cleared
	NSMutableArray *p1line;
	NSMutableArray *p2line;
	NSMutableArray *p3line;
	NSMutableArray *p4line;
	NSMutableArray *p5line;
	NSMutableArray *ballline;
	
	// arrays used for saving player positions when saving a frame
	NSMutableArray *playerx;
	NSMutableArray *playery;
	
	BOOL drawMode; // true if in draw mode, false if in view mode
	BOOL firstFrame;
	
	// current play and frame numbers for viewing plays
	int currentPlayNumber;
	int currentFrameNumber;
}
@property (retain, nonatomic) PlaybookAppDelegate *appDelegate;
@property CGPoint p1pos;
@property CGPoint p2pos;
@property CGPoint p3pos;
@property CGPoint p4pos;
@property CGPoint p5pos;
@property CGPoint ballpos;
@property CGPoint prevp1pos;
@property CGPoint prevp2pos;
@property CGPoint prevp3pos;
@property CGPoint prevp4pos;
@property CGPoint prevp5pos;
@property CGPoint prevballpos;
@property float playerRadius;
@property float ballRadius;
@property CGContextRef contextRef;
@property int pickedup;
@property float strokered;
@property float strokegreen;
@property float strokeblue;
@property float strokealpha;
@property float strokethickness;

@property float dotred;
@property float dotgreen;
@property float dotblue;
@property float dotalpha;
@property float dotradius;
@property float dotdistance;

@property (nonatomic, retain) NSMutableArray *p1line;
@property (nonatomic, retain) NSMutableArray *p2line;
@property (nonatomic, retain) NSMutableArray *p3line;
@property (nonatomic, retain) NSMutableArray *p4line;
@property (nonatomic, retain) NSMutableArray *p5line;
@property (nonatomic, retain) NSMutableArray *ballline;

@property (nonatomic, retain) NSMutableArray *playerx;
@property (nonatomic, retain) NSMutableArray *playery;

@property BOOL drawMode;
@property BOOL firstFrame;
@property int currentPlayNumber;
@property int currentFrameNumber;
// draw methods
- (void)initializeViewMode:(int)playNum;
- (void)returnToViewMode:(int)playNum;
- (void)nextFrameView:(int)playNum;
- (void)prevFrameView;
- (void)initializeDrawMode;
- (void)initializeEditMode:(int)playNum fromFrame:(int)frameNum;
- (void)drawCourt;
- (void)drawMarker:(int)markerNum fromPlay:(int)playNum fromFrame:(int)frameNum; // playNum and frameNum are only used if in viewing mode
- (void)drawLine:(int)lineNum fromPlay:(int)playNum fromFrame:(int)frameNum; // playNum and frameNum are only used if in viewing mode
- (BOOL)detectCollisions:(int)markerNum;
- (BOOL)collisionMarkers:(int)marker1Num otherMarker:(int)marker2Num;
- (BOOL)collisionDots:(CGPoint)point1 otherPoint:(CGPoint)point2;
- (float)getNumbersFromTextFields:(NSString *)textField;
- (void)savePlayerPositions;
- (void)clearPlayerPositions;
- (void)clearFrameData;
- (void)initializeFrameData;
- (void)initializeEditFrameData:(int)playNum fromFrame:(int)frameNum;
- (BOOL)needsSave;
- (void)clearCanvas;
- (void)drawArrow:(CGPoint)point1 toPoint:(CGPoint)point2 forType:(int)type;
//- (void)setFirstFrameBooleanVariable:(BOOL)value;

@end