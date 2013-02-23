//
//  DrawPlayView.m
//  Playbook
//
//  Created by Class Account on 4/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PlaybookAppDelegate.h"
#import "DrawPlayView.h"
#import "PointWrapper.h"

#define ARROW_LENGTH 10
#define ARROW_WIDTH  10

@implementation DrawPlayView
@synthesize appDelegate;
@synthesize p1pos;
@synthesize p2pos;
@synthesize p3pos;
@synthesize p4pos;
@synthesize p5pos;
@synthesize ballpos;
@synthesize prevp1pos;
@synthesize prevp2pos;
@synthesize prevp3pos;
@synthesize prevp4pos;
@synthesize prevp5pos;
@synthesize prevballpos;
@synthesize playerRadius;
@synthesize ballRadius;
@synthesize contextRef;
@synthesize pickedup;
@synthesize strokered;
@synthesize strokegreen;
@synthesize strokeblue;
@synthesize strokealpha;
@synthesize strokethickness;
@synthesize dotred;
@synthesize dotgreen;
@synthesize dotblue;
@synthesize dotalpha;
@synthesize dotradius;
@synthesize dotdistance;
@synthesize p1line;
@synthesize p2line;
@synthesize	p3line;
@synthesize p4line;
@synthesize p5line;
@synthesize ballline;
@synthesize playerx;
@synthesize playery;
@synthesize drawMode;
@synthesize firstFrame;
@synthesize currentPlayNumber;
@synthesize currentFrameNumber;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}

-(void)nextFrameView:(int)playNum {
	NSArray *savedNames = [[NSArray alloc] initWithArray:[appDelegate.savedplays allKeys]];
	if((currentFrameNumber + 1) != [[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] count]) {
		currentFrameNumber++;
	}
	[self setNeedsDisplay];
}

-(void)prevFrameView {
	if(currentFrameNumber > 0) {
		currentFrameNumber--;
	}
	[self setNeedsDisplay];
}

-(void)initializeViewMode:(int)playNum {
	[self returnToViewMode:playNum];
	currentFrameNumber = 0;
}

-(void)returnToViewMode:(int)playNum {
	drawMode = FALSE;
	firstFrame = FALSE;
	currentPlayNumber = playNum;
	
	playerRadius = 16;
	ballRadius = 16;
	
	// line setup
	strokered = 0;
	strokegreen = 0;
	strokeblue = 0;
	strokealpha = 0.75;
	strokethickness = 10;
	
	dotred = 0;
	dotgreen = 0;
	dotblue = 50;
	dotalpha = 0.75;
	dotradius = 10;
	dotdistance = 5;	
	
	[self setNeedsDisplay];
}

// called whenever user starts drawing a new play
-(void)initializeDrawMode {
	pickedup = 0;
	// default starting spots
	prevp1pos.x = 26;
	prevp1pos.y = 41;
	prevp2pos.x = 257;
	prevp2pos.y = 72;
	prevp3pos.x = 117;
	prevp3pos.y = 53;
	prevp4pos.x = 78;
	prevp4pos.y = 171;
	prevp5pos.x = 193;
	prevp5pos.y = 193;
	prevballpos.x = 168;
	prevballpos.y = 181;
	
	p1pos.x = prevp1pos.x;
	p1pos.y = prevp1pos.y;
	p2pos.x = prevp2pos.x;
	p2pos.y = prevp2pos.y;
	p3pos.x = prevp3pos.x;
	p3pos.y = prevp3pos.y;
	p4pos.x = prevp4pos.x;
	p4pos.y = prevp4pos.y;
	p5pos.x = prevp5pos.x;
	p5pos.y = prevp5pos.y;
	ballpos.x = prevballpos.x;
	ballpos.y = prevballpos.y;
	playerRadius = 16;
	ballRadius = 16;
	
	[self initializeFrameData];

	currentPlayNumber = -1; // not using it for draw mode
	currentFrameNumber = 0; // not using it for draw mode
	
	// line setup
	strokered = 0;
	strokegreen = 0;
	strokeblue = 0;
	strokealpha = 0.75;
	strokethickness = 10;
	
	dotred = 0;
	dotgreen = 0;
	dotblue = 50;
	dotalpha = 0.75;
	dotradius = 10;
	dotdistance = 5;
	
	drawMode = TRUE;
	firstFrame = TRUE;
	
	[self setNeedsDisplay];
}

// called whenever user starts drawing a new play
-(void)initializeEditMode:(int)playNum fromFrame:(int)frameNum {
	pickedup = 0;
	// default starting spots
	NSArray *savedNames = [[NSArray alloc] initWithArray:[appDelegate.savedplays allKeys]];
	prevp1pos.x = [self getNumbersFromTextFields:[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:0] objectAtIndex:0]];
	prevp1pos.y = [self getNumbersFromTextFields:[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:1] objectAtIndex:0]];
	prevp2pos.x = [self getNumbersFromTextFields:[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:0] objectAtIndex:1]];
	prevp2pos.y = [self getNumbersFromTextFields:[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:1] objectAtIndex:1]];
	prevp3pos.x = [self getNumbersFromTextFields:[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:0] objectAtIndex:2]];
	prevp3pos.y = [self getNumbersFromTextFields:[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:1] objectAtIndex:2]];
	prevp4pos.x = [self getNumbersFromTextFields:[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:0] objectAtIndex:3]];
	prevp4pos.y = [self getNumbersFromTextFields:[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:1] objectAtIndex:3]];
	prevp5pos.x = [self getNumbersFromTextFields:[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:0] objectAtIndex:4]];
	prevp5pos.y = [self getNumbersFromTextFields:[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:1] objectAtIndex:4]];
	prevballpos.x = [self getNumbersFromTextFields:[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:0] objectAtIndex:5]];
	prevballpos.y = [self getNumbersFromTextFields:[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:1] objectAtIndex:5]];

	p1pos.x = prevp1pos.x;
	p1pos.y = prevp1pos.y;
	p2pos.x = prevp2pos.x;
	p2pos.y = prevp2pos.y;
	p3pos.x = prevp3pos.x;
	p3pos.y = prevp3pos.y;
	p4pos.x = prevp4pos.x;
	p4pos.y = prevp4pos.y;
	p5pos.x = prevp5pos.x;
	p5pos.y = prevp5pos.y;
	ballpos.x = prevballpos.x;
	ballpos.y = prevballpos.y;
	playerRadius = 16;
	ballRadius = 16;

	[self initializeEditFrameData:playNum fromFrame:frameNum];
	
	// line setup
	strokered = 0;
	strokegreen = 0;
	strokeblue = 0;
	strokealpha = 0.75;
	strokethickness = 10;
	
	dotred = 0;
	dotgreen = 0;
	dotblue = 50;
	dotalpha = 0.75;
	dotradius = 10;
	dotdistance = 5;
	
	drawMode = TRUE;
	firstFrame = (frameNum == 0 ? TRUE : FALSE);
	
	[self setNeedsDisplay];
}

- (void) awakeFromNib {
	appDelegate = (PlaybookAppDelegate *)[[UIApplication sharedApplication] delegate];
	[self initializeFrameData];
}

- (void) savePlayerPositions {
	[playerx addObject:[[NSString alloc] initWithFormat:@"%f", p1pos.x]];
	[playery addObject:[[NSString alloc] initWithFormat:@"%f", p1pos.y]];
	[playerx addObject:[[NSString alloc] initWithFormat:@"%f", p2pos.x]];
	[playery addObject:[[NSString alloc] initWithFormat:@"%f", p2pos.y]];
	[playerx addObject:[[NSString alloc] initWithFormat:@"%f", p3pos.x]];
	[playery addObject:[[NSString alloc] initWithFormat:@"%f", p3pos.y]];
	[playerx addObject:[[NSString alloc] initWithFormat:@"%f", p4pos.x]];
	[playery addObject:[[NSString alloc] initWithFormat:@"%f", p4pos.y]];
	[playerx addObject:[[NSString alloc] initWithFormat:@"%f", p5pos.x]];
	[playery addObject:[[NSString alloc] initWithFormat:@"%f", p5pos.y]];
	[playerx addObject:[[NSString alloc] initWithFormat:@"%f", ballpos.x]];
	[playery addObject:[[NSString alloc] initWithFormat:@"%f", ballpos.y]];
	prevp1pos.x = p1pos.x;
	prevp1pos.y = p1pos.y;
	prevp2pos.x = p2pos.x;
	prevp2pos.y = p2pos.y;
	prevp3pos.x = p3pos.x;
	prevp3pos.y = p3pos.y;
	prevp4pos.x = p4pos.x;
	prevp4pos.y = p4pos.y;
	prevp5pos.x = p5pos.x;
	prevp5pos.y = p5pos.y;
	prevballpos.x = ballpos.x;
	prevballpos.y = ballpos.y;
	
/*	NSLog(@"p1pos: %f, %f", p1pos.x, p1pos.y);
	NSLog(@"p2pos: %f, %f", p2pos.x, p2pos.y);
	NSLog(@"p3pos: %f, %f", p3pos.x, p3pos.y);
	NSLog(@"p4pos: %f, %f", p4pos.x, p4pos.y);
	NSLog(@"p5pos: %f, %f", p5pos.x, p5pos.y);
	NSLog(@"ballpos: %f, %f", ballpos.x, ballpos.y);*/
}

- (void) editSavePlayerPositions:(int)playNum fromFrame:(int)frameNum {
/*	NSArray *savedNames = [[NSArray alloc] initWithArray:[appDelegate.savedplays allKeys]];
	[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:0] replaceObjectAtIndex:0 withObject:[[NSString alloc] initWithFormat:@"%f", p1pos.x]];
	[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:1] replaceObjectAtIndex:0 withObject:[[NSString alloc] initWithFormat:@"%f", p1pos.y]];
	[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:0] replaceObjectAtIndex:1 withObject:[[NSString alloc] initWithFormat:@"%f", p2pos.x]];
	[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:1] replaceObjectAtIndex:1 withObject:[[NSString alloc] initWithFormat:@"%f", p2pos.y]];
	[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:0] replaceObjectAtIndex:2 withObject:[[NSString alloc] initWithFormat:@"%f", p3pos.x]];
	[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:1] replaceObjectAtIndex:2 withObject:[[NSString alloc] initWithFormat:@"%f", p3pos.y]];
	[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:0] replaceObjectAtIndex:3 withObject:[[NSString alloc] initWithFormat:@"%f", p4pos.x]];
	[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:1] replaceObjectAtIndex:3 withObject:[[NSString alloc] initWithFormat:@"%f", p4pos.y]];
	[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:0] replaceObjectAtIndex:4 withObject:[[NSString alloc] initWithFormat:@"%f", p5pos.x]];
	[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:1] replaceObjectAtIndex:4 withObject:[[NSString alloc] initWithFormat:@"%f", p5pos.y]];
	[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:0] replaceObjectAtIndex:5 withObject:[[NSString alloc] initWithFormat:@"%f", ballpos.x]];
	[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:1] replaceObjectAtIndex:5 withObject:[[NSString alloc] initWithFormat:@"%f", ballpos.y]];
*/
	[playerx addObject:[[NSString alloc] initWithFormat:@"%f", p1pos.x]];
	[playery addObject:[[NSString alloc] initWithFormat:@"%f", p1pos.y]];
	[playerx addObject:[[NSString alloc] initWithFormat:@"%f", p2pos.x]];
	[playery addObject:[[NSString alloc] initWithFormat:@"%f", p2pos.y]];
	[playerx addObject:[[NSString alloc] initWithFormat:@"%f", p3pos.x]];
	[playery addObject:[[NSString alloc] initWithFormat:@"%f", p3pos.y]];
	[playerx addObject:[[NSString alloc] initWithFormat:@"%f", p4pos.x]];
	[playery addObject:[[NSString alloc] initWithFormat:@"%f", p4pos.y]];
	[playerx addObject:[[NSString alloc] initWithFormat:@"%f", p5pos.x]];
	[playery addObject:[[NSString alloc] initWithFormat:@"%f", p5pos.y]];
	[playerx addObject:[[NSString alloc] initWithFormat:@"%f", ballpos.x]];
	[playery addObject:[[NSString alloc] initWithFormat:@"%f", ballpos.y]];
	
/*	for(int i = 0; i < [[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:0] count]; i++) {
		NSLog(@"player %d x:%@, y:%@", i, [[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:0] objectAtIndex:i], [[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:0] objectAtIndex:i]);
	}*/
	
	prevp1pos.x = p1pos.x;
	prevp1pos.y = p1pos.y;
	prevp2pos.x = p2pos.x;
	prevp2pos.y = p2pos.y;
	prevp3pos.x = p3pos.x;
	prevp3pos.y = p3pos.y;
	prevp4pos.x = p4pos.x;
	prevp4pos.y = p4pos.y;
	prevp5pos.x = p5pos.x;
	prevp5pos.y = p5pos.y;
	prevballpos.x = ballpos.x;
	prevballpos.y = ballpos.y;
}

- (BOOL) needsSave {
	if(prevp1pos.x == p1pos.x && prevp1pos.y == p1pos.y && prevp2pos.x == p2pos.x && prevp2pos.y == p2pos.y && prevp3pos.x == p3pos.x && prevp3pos.y == p3pos.y && 
	   prevp4pos.x == p4pos.x && prevp4pos.y == p4pos.y && prevp5pos.x == p5pos.x && prevp5pos.y == p5pos.y && prevballpos.x == ballpos.x && prevballpos.y == ballpos.y) {
		return FALSE;
	}
	return TRUE;
}

- (void) clearPlayerPositions {
	[playerx removeAllObjects];
	[playery removeAllObjects];
}
/*
- (void)setFirstFrameBooleanVariable:(BOOL)value
{
	firstFrame = value;
}
*/
// drawing methods
- (void)drawCourt {
	UIImage *image = [UIImage imageNamed:@"court.jpg"];
	int toolbarHeight = 44; // found toolbar height from view controller
	[image drawInRect:CGRectMake(0, 0, (int)self.bounds.size.width, (int)self.bounds.size.height - toolbarHeight)];
}

- (void)drawMarker:(int)markerNum fromPlay:(int)playNum fromFrame:(int)frameNum { // 1-5 are players, 6 is ball
//	CGContextSetRGBFillColor(contextRef, 1.0, 1.0, 1.0, 1.0);
//	CGContextFillEllipseInRect(contextRef, CGRectMake(p1pos.x - (7.5), p1pos.y - (7.5), 15, 15));
//	CGContextStrokeEllipseInRect(contextRef, CGRectMake(p1pos.x - (7.5), p1pos.y - (7.5), 15, 15));
//	NSLog(@"player 1 drawn");
	UIImage *image;
	CGPoint point;
	NSArray *savedNames = [[NSArray alloc] initWithArray:[appDelegate.savedplays allKeys]];
	switch(markerNum) {
		case 1:
			image = [UIImage imageNamed:@"sf.png"];
			if(drawMode == TRUE) {
				// now the marker position is updated only when you save the step
				// just change prevpXpos to pXpos to revert
				if(firstFrame) {
					[image drawInRect:CGRectMake(p1pos.x - playerRadius, p1pos.y - playerRadius, 2*playerRadius, 2*playerRadius)];
				}
				else {
					[image drawInRect:CGRectMake(prevp1pos.x - playerRadius, prevp1pos.y - playerRadius, 2*playerRadius, 2*playerRadius)];
				}
			}
			else {
				point.x = [self getNumbersFromTextFields:[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:0] objectAtIndex:0]];
				point.y = [self getNumbersFromTextFields:[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:1] objectAtIndex:0]];
				[image drawInRect:CGRectMake(point.x - playerRadius, point.y - playerRadius, 2*playerRadius, 2*playerRadius)];
			}
			break;
		case 2:
			image = [UIImage imageNamed:@"pf.png"];
			if(drawMode == TRUE) {
				if(firstFrame) {
					[image drawInRect:CGRectMake(p2pos.x - playerRadius, p2pos.y - playerRadius, 2*playerRadius, 2*playerRadius)];
				}
				else {
					[image drawInRect:CGRectMake(prevp2pos.x - playerRadius, prevp2pos.y - playerRadius, 2*playerRadius, 2*playerRadius)];
				}
			}
			else {
				point.x = [self getNumbersFromTextFields:[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:0] objectAtIndex:1]];
				point.y = [self getNumbersFromTextFields:[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:1] objectAtIndex:1]];
				[image drawInRect:CGRectMake(point.x - playerRadius, point.y - playerRadius, 2*playerRadius, 2*playerRadius)];
			}
			break;
		case 3:
			image = [UIImage imageNamed:@"c.png"];
			if(drawMode == TRUE) {
				if(firstFrame) {
					[image drawInRect:CGRectMake(p3pos.x - playerRadius, p3pos.y - playerRadius, 2*playerRadius, 2*playerRadius)];
				}
				else {
					[image drawInRect:CGRectMake(prevp3pos.x - playerRadius, prevp3pos.y - playerRadius, 2*playerRadius, 2*playerRadius)];
				}
			}
			else {
				point.x = [self getNumbersFromTextFields:[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:0] objectAtIndex:2]];
				point.y = [self getNumbersFromTextFields:[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:1] objectAtIndex:2]];
				[image drawInRect:CGRectMake(point.x - playerRadius, point.y - playerRadius, 2*playerRadius, 2*playerRadius)];
			}
			break;
		case 4:
			image = [UIImage imageNamed:@"sg.png"];
			if(drawMode == TRUE) {
				if(firstFrame) {
					[image drawInRect:CGRectMake(p4pos.x - playerRadius, p4pos.y - playerRadius, 2*playerRadius, 2*playerRadius)];
				}
				else {
					[image drawInRect:CGRectMake(prevp4pos.x - playerRadius, prevp4pos.y - playerRadius, 2*playerRadius, 2*playerRadius)];
				}
			}
			else {
				point.x = [self getNumbersFromTextFields:[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:0] objectAtIndex:3]];
				point.y = [self getNumbersFromTextFields:[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:1] objectAtIndex:3]];
				[image drawInRect:CGRectMake(point.x - playerRadius, point.y - playerRadius, 2*playerRadius, 2*playerRadius)];
			}
			break;
		case 5:
			image = [UIImage imageNamed:@"pg.png"];
			if(drawMode == TRUE) {
				if(firstFrame) {
					[image drawInRect:CGRectMake(p5pos.x - playerRadius, p5pos.y - playerRadius, 2*playerRadius, 2*playerRadius)];
				}
				else {
					[image drawInRect:CGRectMake(prevp5pos.x - playerRadius, prevp5pos.y - playerRadius, 2*playerRadius, 2*playerRadius)];
				}
			}
			else {
				point.x = [self getNumbersFromTextFields:[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:0] objectAtIndex:4]];
				point.y = [self getNumbersFromTextFields:[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:1] objectAtIndex:4]];
				[image drawInRect:CGRectMake(point.x - playerRadius, point.y - playerRadius, 2*playerRadius, 2*playerRadius)];
			}
			break;
		case 6:
			image = [UIImage imageNamed:@"ball.png"];
			if(drawMode == TRUE) {
				if(firstFrame) {
					[image drawInRect:CGRectMake(ballpos.x - playerRadius, ballpos.y - playerRadius, 2*playerRadius, 2*playerRadius)];
				}
				else {
					[image drawInRect:CGRectMake(prevballpos.x - ballRadius, prevballpos.y - ballRadius, 2*ballRadius, 2*ballRadius)];
				}
			}
			else {
				point.x = [self getNumbersFromTextFields:[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:0] objectAtIndex:5]];
				point.y = [self getNumbersFromTextFields:[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:1] objectAtIndex:5]];
				[image drawInRect:CGRectMake(point.x - ballRadius, point.y - ballRadius, 2*ballRadius, 2*ballRadius)];
			}
			break;
		default:
			break;
	}
}

- (void)drawLine:(int)lineNum fromPlay:(int)playNum fromFrame:(int)frameNum {
	NSMutableArray *tempArray;
	NSArray *savedNames = [[NSArray alloc] initWithArray:[appDelegate.savedplays allKeys]];
	switch (lineNum) {
		case 1:
			if(drawMode == TRUE) {
				if([[p1line objectAtIndex:0] count] == 0) return;
				tempArray = [[NSMutableArray alloc] initWithArray:p1line];
			}
			else { // select play number, frame number, player movements, player 1's movements, movement x array, count
				if([[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:1] count] == 0) return;
				if([[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:1] objectAtIndex:0] count] == 0) return;
				if([[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:1] objectAtIndex:0] objectAtIndex:0] count] == 0) return;
				tempArray = [[NSMutableArray alloc] initWithArray:[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:1] objectAtIndex:0]];
			}
			break;
		case 2:
			if(drawMode == TRUE) {
				if([[p2line objectAtIndex:0] count] == 0) return;
				tempArray = [[NSMutableArray alloc] initWithArray:p2line];
			}
			else {
				if([[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:1] count] == 0) return;
				if([[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:1] objectAtIndex:1] count] == 0) return;
				if([[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:1] objectAtIndex:1] objectAtIndex:0] count] == 0) return;
				tempArray = [[NSMutableArray alloc] initWithArray:[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:1] objectAtIndex:1]];
			}
			break;
		case 3:
			if(drawMode == TRUE) {
				if([[p3line objectAtIndex:0] count] == 0) return;
				tempArray = [[NSMutableArray alloc] initWithArray:p3line];
			}
			else {
				if([[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:1] count] == 0) return;
				if([[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:1] objectAtIndex:2] count] == 0) return;
				if([[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:1] objectAtIndex:2] objectAtIndex:0] count] == 0) return;
				tempArray = [[NSMutableArray alloc] initWithArray:[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:1] objectAtIndex:2]];
			}
			break;
		case 4:
			if(drawMode == TRUE) {
				if([[p4line objectAtIndex:0] count] == 0) return;
				tempArray = [[NSMutableArray alloc] initWithArray:p4line];
			}
			else {
				if([[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:1] count] == 0) return;
				if([[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:1] objectAtIndex:3] count] == 0) return;
				if([[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:1] objectAtIndex:3] objectAtIndex:0] count] == 0) return;
				tempArray = [[NSMutableArray alloc] initWithArray:[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:1] objectAtIndex:3]];
			}
			break;
		case 5:
			if(drawMode == TRUE) {
				if([[p5line objectAtIndex:0] count] == 0) return;
				tempArray = [[NSMutableArray alloc] initWithArray:p5line];
			}
			else {
				if([[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:1] count] == 0) return;
				if([[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:1] objectAtIndex:4] count] == 0) return;
				if([[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:1] objectAtIndex:4] objectAtIndex:0] count] == 0) return;
				tempArray = [[NSMutableArray alloc] initWithArray:[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:1] objectAtIndex:4]];
			}
			break;
		case 6:
			if(drawMode == TRUE) {
				if([[ballline objectAtIndex:0] count] == 0) return;
				tempArray = [[NSMutableArray alloc] initWithArray:ballline];
			}
			else {
				if([[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:1] count] == 0) return;
				if([[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:1] objectAtIndex:5] count] == 0) return;
				if([[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:1] objectAtIndex:5] objectAtIndex:0] count] == 0) return;
				tempArray = [[NSMutableArray alloc] initWithArray:[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:1] objectAtIndex:5]];
			}
			break;
		default:
			break;
	}
	
	if(lineNum == 6) { // special case for ball that draws dots instead of strokes
		for(int i = 0; i < [[tempArray objectAtIndex:0] count]; i++){
			CGPoint point;
			point.x = [self getNumbersFromTextFields:[[tempArray objectAtIndex:0] objectAtIndex:i]];
			point.y = [self getNumbersFromTextFields:[[tempArray objectAtIndex:1] objectAtIndex:i]];
			contextRef = UIGraphicsGetCurrentContext();
			CGContextSetRGBFillColor(contextRef, dotred, dotgreen, dotblue, dotalpha);
			CGContextFillEllipseInRect(contextRef, CGRectMake(point.x, point.y, dotradius, dotradius));
		}
	}
	else {
		CGContextSetRGBStrokeColor(contextRef, strokered, strokegreen, strokeblue, strokealpha);
		CGContextSetLineWidth(contextRef, strokethickness);
		CGPoint startpoint;
		startpoint.x = [self getNumbersFromTextFields:[[tempArray objectAtIndex:0] objectAtIndex:0]];
		startpoint.y = [self getNumbersFromTextFields:[[tempArray objectAtIndex:1] objectAtIndex:0]];
		CGContextMoveToPoint(contextRef, startpoint.x, startpoint.y);

		for(int j = 0; j < [[tempArray objectAtIndex:0] count]; j++){
			// Drawing code
			CGContextSetRGBStrokeColor(contextRef, strokered, strokegreen, strokeblue, strokealpha);
			CGContextSetLineWidth(contextRef, strokethickness);
			CGPoint point;
			point.x = [self getNumbersFromTextFields:[[tempArray objectAtIndex:0] objectAtIndex:j]];
			point.y = [self getNumbersFromTextFields:[[tempArray objectAtIndex:1] objectAtIndex:j]];
			CGContextAddLineToPoint(contextRef, point.x, point.y);
			//			NSLog(@"Drawing stuff");
		
			//			NSLog([[NSString alloc] initWithFormat:@"Point Coordinates: %d, %d", point.x, point.y]);
		}
	}
	CGContextStrokePath(contextRef);
	
	// draw arrows
	
	if([[tempArray objectAtIndex:0] count] > 1) {
		CGPoint point1;
		int lastIndex = [[tempArray objectAtIndex:0] count] - 1;
		point1.x = [self getNumbersFromTextFields:[[tempArray objectAtIndex:0] objectAtIndex:lastIndex]];
		point1.y = [self getNumbersFromTextFields:[[tempArray objectAtIndex:1] objectAtIndex:lastIndex]];
		CGPoint point2;
		point2.x = [self getNumbersFromTextFields:[[tempArray objectAtIndex:0] objectAtIndex:lastIndex - 1]];
		point2.y = [self getNumbersFromTextFields:[[tempArray objectAtIndex:1] objectAtIndex:lastIndex - 1]];
		[self drawArrow:point1 toPoint:point2 forType:lineNum];
	}
	
	[tempArray release];
}

- (void)drawArrow:(CGPoint)point1 toPoint:(CGPoint)point2 forType:(int)type { // assumes the line has at least two points
	CGPoint slope; // rise over run
	slope.y = point2.y - point1.y;
	slope.x = point2.x - point1.x;
	
	// normalize
	slope.x = slope.x/(sqrt(slope.x*slope.x + slope.y*slope.y));
	slope.y = slope.y/(sqrt(slope.x*slope.x + slope.y*slope.y));
	
	CGPoint normalslope_left; // vector from line to left arrow side
	normalslope_left.x = slope.y;
	normalslope_left.y = -slope.x;
	
	CGPoint normalslope_right; // vector from line to left arrow side
	normalslope_right.x = -slope.y;
	normalslope_right.y = slope.x;
	
	CGPoint arrowBase;
	arrowBase.x = point2.x + ARROW_LENGTH*slope.x;
	arrowBase.y = point2.y + ARROW_LENGTH*slope.y;
	
	CGPoint leftArrowPoint;
	leftArrowPoint.x = arrowBase.x + ARROW_WIDTH*normalslope_left.x;
	leftArrowPoint.y = arrowBase.y + ARROW_WIDTH*normalslope_left.y;
	
	CGPoint rightArrowPoint;
	rightArrowPoint.x = arrowBase.x + ARROW_WIDTH*normalslope_right.x;
	rightArrowPoint.y = arrowBase.y + ARROW_WIDTH*normalslope_right.y;
	
	if(type == 6) // ball
	{
		CGContextSetRGBStrokeColor(contextRef, dotred, dotgreen, dotblue, dotalpha);
		CGContextSetLineWidth(contextRef, dotradius);
	}
	else {
		CGContextSetRGBStrokeColor(contextRef, strokered, strokegreen, strokeblue, 1.0);
		CGContextSetLineWidth(contextRef, strokethickness);
	}
	CGContextMoveToPoint(contextRef, leftArrowPoint.x, leftArrowPoint.y);
	CGContextAddLineToPoint(contextRef, point1.x, point1.y);
	CGContextAddLineToPoint(contextRef, rightArrowPoint.x, rightArrowPoint.y);
	CGContextStrokePath(contextRef);
}

- (void)drawRect:(CGRect)rect {
	contextRef = UIGraphicsGetCurrentContext();
	[self drawCourt];
	[self drawLine:1 fromPlay:currentPlayNumber fromFrame:currentFrameNumber];
	[self drawLine:2 fromPlay:currentPlayNumber fromFrame:currentFrameNumber];
	[self drawLine:3 fromPlay:currentPlayNumber fromFrame:currentFrameNumber];
	[self drawLine:4 fromPlay:currentPlayNumber fromFrame:currentFrameNumber];
	[self drawLine:5 fromPlay:currentPlayNumber fromFrame:currentFrameNumber];
	[self drawLine:6 fromPlay:currentPlayNumber fromFrame:currentFrameNumber];
	[self drawMarker:1 fromPlay:currentPlayNumber fromFrame:currentFrameNumber];
	[self drawMarker:2 fromPlay:currentPlayNumber fromFrame:currentFrameNumber];
	[self drawMarker:3 fromPlay:currentPlayNumber fromFrame:currentFrameNumber];
	[self drawMarker:4 fromPlay:currentPlayNumber fromFrame:currentFrameNumber];
	[self drawMarker:5 fromPlay:currentPlayNumber fromFrame:currentFrameNumber];
	[self drawMarker:6 fromPlay:currentPlayNumber fromFrame:currentFrameNumber];
}

- (float)getNumbersFromTextFields:(NSString *)textField {
	NSScanner *scanner = [NSScanner scannerWithString:textField];
	float rtn;
	if([scanner scanFloat:&rtn]) { // valid float number
		return rtn;
	}
	return 0;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	if(drawMode == TRUE) {
		NSArray *alltouches = [[NSArray alloc] initWithArray:[touches allObjects]];
		for(int d = 0; d < [alltouches count]; d++) {
			CGPoint point = [[alltouches objectAtIndex:d] locationInView:self];
			if(point.x <= (ballpos.x + ballRadius) && point.x >= (ballpos.x - ballRadius) &&
			   point.y <= (ballpos.y + ballRadius) && point.y >= (ballpos.y - ballRadius)) {
				ballpos = point;
				if(!firstFrame) {
					[[ballline objectAtIndex:0] addObject:[[NSString alloc] initWithFormat:@"%f", point.x]];
					[[ballline objectAtIndex:1] addObject:[[NSString alloc] initWithFormat:@"%f", point.y]];
				}
				pickedup = 6;
				break;
			}
			else if(point.x <= (p1pos.x + playerRadius) && point.x >= (p1pos.x - playerRadius) &&
			   point.y <= (p1pos.y + playerRadius) && point.y >= (p1pos.y - playerRadius)) {
				p1pos = point;
				if(!firstFrame) {
					[[p1line objectAtIndex:0] addObject:[[NSString alloc] initWithFormat:@"%f", point.x]];
					[[p1line objectAtIndex:1] addObject:[[NSString alloc] initWithFormat:@"%f", point.y]];
				}
				pickedup = 1;
				break;
			}
			else if(point.x <= (p2pos.x + playerRadius) && point.x >= (p2pos.x - playerRadius) &&
					point.y <= (p2pos.y + playerRadius) && point.y >= (p2pos.y - playerRadius)) {
				p2pos = point;
				if(!firstFrame) {
					[[p2line objectAtIndex:0] addObject:[[NSString alloc] initWithFormat:@"%f", point.x]];
					[[p2line objectAtIndex:1] addObject:[[NSString alloc] initWithFormat:@"%f", point.y]];
				}
				pickedup = 2;
				break;
			}
			else if(point.x <= (p3pos.x + playerRadius) && point.x >= (p3pos.x - playerRadius) &&
					point.y <= (p3pos.y + playerRadius) && point.y >= (p3pos.y - playerRadius)) {
				p3pos = point;
				if(!firstFrame) {
					[[p3line objectAtIndex:0] addObject:[[NSString alloc] initWithFormat:@"%f", point.x]];
					[[p3line objectAtIndex:1] addObject:[[NSString alloc] initWithFormat:@"%f", point.y]];
				}
				pickedup = 3;
				break;
			}
			else if(point.x <= (p4pos.x + playerRadius) && point.x >= (p4pos.x - playerRadius) &&
					point.y <= (p4pos.y + playerRadius) && point.y >= (p4pos.y - playerRadius)) {
				p4pos = point;
				if(!firstFrame) {
					[[p4line objectAtIndex:0] addObject:[[NSString alloc] initWithFormat:@"%f", point.x]];
					[[p4line objectAtIndex:1] addObject:[[NSString alloc] initWithFormat:@"%f", point.y]];
				}
				pickedup = 4;
				break;
			}
			else if(point.x <= (p5pos.x + playerRadius) && point.x >= (p5pos.x - playerRadius) &&
					point.y <= (p5pos.y + playerRadius) && point.y >= (p5pos.y - playerRadius)) {
				p5pos = point;
				if(!firstFrame) {
					[[p5line objectAtIndex:0] addObject:[[NSString alloc] initWithFormat:@"%f", point.x]];
					[[p5line objectAtIndex:1] addObject:[[NSString alloc] initWithFormat:@"%f", point.y]];
				}
				pickedup = 5;
				break;
			}
		}
		[alltouches release];
		[self setNeedsDisplay];
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	if(drawMode == TRUE) {
		NSArray *alltouches = [[NSArray alloc] initWithArray:[touches allObjects]];
		for(int d = 0; d < [alltouches count]; d++) {
			CGPoint point = [[alltouches objectAtIndex:d] locationInView:self];
			CGPoint prevPoint;
			int toolbarHeight = 44;
			if(point.y > 0 && point.y < ((int)self.bounds.size.height - toolbarHeight)) {// don't use coordinates off the valid drawing area on the screen or you risk losing the marker.  
				switch(pickedup) {
					case 1:
						//					if(![self detectCollisions:1]) {
						p1pos = point;
						
						if([p1line count] > 0) {
							prevPoint.x = [self getNumbersFromTextFields:[[p1line objectAtIndex:0] lastObject]];
							prevPoint.y = [self getNumbersFromTextFields:[[p1line objectAtIndex:1] lastObject]];
							if(![self collisionDots:point otherPoint:prevPoint]) {
								if(!firstFrame) {
									[[p1line objectAtIndex:0] addObject:[[NSString alloc] initWithFormat:@"%f", point.x]];
									[[p1line objectAtIndex:1] addObject:[[NSString alloc] initWithFormat:@"%f", point.y]];
								}
							}
						}
						//					}
						break;
					case 2:
						//					if(![self detectCollisions:2]) {
						p2pos = point;
						
						if([p2line count] > 0) {
							prevPoint.x = [self getNumbersFromTextFields:[[p2line objectAtIndex:0] lastObject]];
							prevPoint.y = [self getNumbersFromTextFields:[[p2line objectAtIndex:1] lastObject]];
							if(![self collisionDots:point otherPoint:prevPoint]) {
								if(!firstFrame) {
									[[p2line objectAtIndex:0] addObject:[[NSString alloc] initWithFormat:@"%f", point.x]];
									[[p2line objectAtIndex:1] addObject:[[NSString alloc] initWithFormat:@"%f", point.y]];
								}
							}
						}
						//					}
						break;
					case 3:
						//					if(![self detectCollisions:3]) {
						p3pos = point;
						
						if([p3line count] > 0) {
							prevPoint.x = [self getNumbersFromTextFields:[[p3line objectAtIndex:0] lastObject]];
							prevPoint.y = [self getNumbersFromTextFields:[[p3line objectAtIndex:1] lastObject]];
							if(![self collisionDots:point otherPoint:prevPoint]) {
								if(!firstFrame) {
									[[p3line objectAtIndex:0] addObject:[[NSString alloc] initWithFormat:@"%f", point.x]];
									[[p3line objectAtIndex:1] addObject:[[NSString alloc] initWithFormat:@"%f", point.y]];
								}
							}
						}
						//					}
						break;
					case 4:
						//					if(![self detectCollisions:4]) {
						p4pos = point;
						
						if([p4line count] > 0) {
							prevPoint.x = [self getNumbersFromTextFields:[[p4line objectAtIndex:0] lastObject]];
							prevPoint.y = [self getNumbersFromTextFields:[[p4line objectAtIndex:1] lastObject]];
							if(![self collisionDots:point otherPoint:prevPoint]) {
								if(!firstFrame) {
									[[p4line objectAtIndex:0] addObject:[[NSString alloc] initWithFormat:@"%f", point.x]];
									[[p4line objectAtIndex:1] addObject:[[NSString alloc] initWithFormat:@"%f", point.y]];
								}
							}
						}
						//					}
						break;
					case 5:
						//					if(![self detectCollisions:5]) {
						p5pos = point;
						
						if([p5line count] > 0) {
							prevPoint.x = [self getNumbersFromTextFields:[[p5line objectAtIndex:0] lastObject]];
							prevPoint.y = [self getNumbersFromTextFields:[[p5line objectAtIndex:1] lastObject]];
							if(![self collisionDots:point otherPoint:prevPoint]) {
								if(!firstFrame) {
									[[p5line objectAtIndex:0] addObject:[[NSString alloc] initWithFormat:@"%f", point.x]];
									[[p5line objectAtIndex:1] addObject:[[NSString alloc] initWithFormat:@"%f", point.y]];
								}
							}
						}
						//					}
						break;
					case 6:
						//					if(![self detectCollisions:6]) {
						ballpos = point;
						
						if([ballline count] > 0) {
							prevPoint.x = [self getNumbersFromTextFields:[[ballline objectAtIndex:0] lastObject]];
							prevPoint.y = [self getNumbersFromTextFields:[[ballline objectAtIndex:1] lastObject]];
							if(![self collisionDots:point otherPoint:prevPoint]) {
								if(!firstFrame) {
									[[ballline objectAtIndex:0] addObject:[[NSString alloc] initWithFormat:@"%f", point.x]];
									[[ballline objectAtIndex:1] addObject:[[NSString alloc] initWithFormat:@"%f", point.y]];
								}
							}
						}
						break;
						
					default:
						break;
				}
			}
		}
		[alltouches release];
		[self setNeedsDisplay];
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	if(drawMode == TRUE) {
		pickedup = 0;
	}
}

- (void)clearFrameData {
//	if([p1line count] > 0) [p1line removeAllObjects];
	[p1line release];
//	if([p2line count] > 0) [p2line removeAllObjects];
	[p2line release];
//	if([p3line count] > 0) [p3line removeAllObjects];
	[p3line release];
//	if([p4line count] > 0) [p4line removeAllObjects];
	[p4line release];
//	if([p5line count] > 0) [p5line removeAllObjects];
	[p5line release];
//	if([ballline count] > 0) [ballline removeAllObjects];
	[ballline release];
//	if([playerx count] > 0) [playerx removeAllObjects];
	[playerx release];
//	if([playery count] > 0) [playery removeAllObjects];
	[playery release];
	[self setNeedsDisplay];
}

- (void)initializeFrameData {
	playerx = [[NSMutableArray alloc] init];
	playery = [[NSMutableArray alloc] init];
	
	p1line = [[NSMutableArray alloc] init];
	NSMutableArray *p1x = [[NSMutableArray alloc] init];
	NSMutableArray *p1y = [[NSMutableArray alloc] init];
	[p1line addObject:p1x];
	[p1line addObject:p1y];
	[p1x release];
	[p1y release];
	
	p2line = [[NSMutableArray alloc] init];
	NSMutableArray *p2x = [[NSMutableArray alloc] init];
	NSMutableArray *p2y = [[NSMutableArray alloc] init];
	[p2line addObject:p2x];
	[p2line addObject:p2y];
	[p2x release];
	[p2y release];
	
	p3line = [[NSMutableArray alloc] init];
	NSMutableArray *p3x = [[NSMutableArray alloc] init];
	NSMutableArray *p3y = [[NSMutableArray alloc] init];
	[p3line addObject:p3x];
	[p3line addObject:p3y];
	[p3x release];
	[p3y release];
	
	p4line = [[NSMutableArray alloc] init];
	NSMutableArray *p4x = [[NSMutableArray alloc] init];
	NSMutableArray *p4y = [[NSMutableArray alloc] init];
	[p4line addObject:p4x];
	[p4line addObject:p4y];
	[p4x release];
	[p4y release];
	
	p5line = [[NSMutableArray alloc] init];
	NSMutableArray *p5x = [[NSMutableArray alloc] init];
	NSMutableArray *p5y = [[NSMutableArray alloc] init];
	[p5line addObject:p5x];
	[p5line addObject:p5y];
	[p5x release];
	[p5y release];
	
	ballline = [[NSMutableArray alloc] init];
	NSMutableArray *ballx = [[NSMutableArray alloc] init];
	NSMutableArray *bally = [[NSMutableArray alloc] init];
	[ballline addObject:ballx];
	[ballline addObject:bally];
	[ballx release];
	[bally release];
	
	firstFrame = FALSE;
	
	p1pos.x = prevp1pos.x;
	p1pos.y = prevp1pos.y;
	p2pos.x = prevp2pos.x;
	p2pos.y = prevp2pos.y;
	p3pos.x = prevp3pos.x;
	p3pos.y = prevp3pos.y;
	p4pos.x = prevp4pos.x;
	p4pos.y = prevp4pos.y;
	p5pos.x = prevp5pos.x;
	p5pos.y = prevp5pos.y;
	ballpos.x = prevballpos.x;
	ballpos.y = prevballpos.y;
	currentFrameNumber++;
}

- (void)initializeEditFrameData:(int)playNum fromFrame:(int)frameNum {
	NSArray *savedNames = [[NSArray alloc] initWithArray:[appDelegate.savedplays allKeys]];
	[self getNumbersFromTextFields:[[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:0] objectAtIndex:0] objectAtIndex:0]];

	playerx = [[NSMutableArray alloc] init];
	playery = [[NSMutableArray alloc] init];
	
	p1line = [[NSMutableArray alloc] initWithArray:[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:1] objectAtIndex:0]];
	p2line = [[NSMutableArray alloc] initWithArray:[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:1] objectAtIndex:1]];
	p3line = [[NSMutableArray alloc] initWithArray:[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:1] objectAtIndex:2]];
	p4line = [[NSMutableArray alloc] initWithArray:[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:1] objectAtIndex:3]];
	p5line = [[NSMutableArray alloc] initWithArray:[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:1] objectAtIndex:4]];
	ballline = [[NSMutableArray alloc] initWithArray:[[[[appDelegate.savedplays objectForKey:[savedNames objectAtIndex:playNum]] objectAtIndex:frameNum] objectAtIndex:1] objectAtIndex:5]];
	
	firstFrame = FALSE;
}

- (void)clearCanvas {
	// clear movement lines and restore players to starting positions
	p1pos.x = prevp1pos.x;
	p1pos.y = prevp1pos.y;
	p2pos.x = prevp2pos.x;
	p2pos.y = prevp2pos.y;
	p3pos.x = prevp3pos.x;
	p3pos.y = prevp3pos.y;
	p4pos.x = prevp4pos.x;
	p4pos.y = prevp4pos.y;
	p5pos.x = prevp5pos.x;
	p5pos.y = prevp5pos.y;
	ballpos.x = prevballpos.x;
	ballpos.y = prevballpos.y;
	// load new frame
	[[p1line objectAtIndex:0] removeAllObjects];
	[[p1line objectAtIndex:1] removeAllObjects];
	[[p2line objectAtIndex:0] removeAllObjects];
	[[p2line objectAtIndex:1] removeAllObjects];
	[[p3line objectAtIndex:0] removeAllObjects];
	[[p3line objectAtIndex:1] removeAllObjects];
	[[p4line objectAtIndex:0] removeAllObjects];
	[[p4line objectAtIndex:1] removeAllObjects];
	[[p5line objectAtIndex:0] removeAllObjects];
	[[p5line objectAtIndex:1] removeAllObjects];
	[[ballline objectAtIndex:0] removeAllObjects];
	[[ballline objectAtIndex:1] removeAllObjects];
	[self setNeedsDisplay];
}

- (BOOL)detectCollisions:(int)markerNum {
	switch (markerNum) {
		case 1:
			if([self collisionMarkers:1 otherMarker:2]) return TRUE;
			if([self collisionMarkers:1 otherMarker:3]) return TRUE;
			if([self collisionMarkers:1 otherMarker:4]) return TRUE;
			if([self collisionMarkers:1 otherMarker:5]) return TRUE;
			return FALSE;
			break;
		case 2:
			if([self collisionMarkers:2 otherMarker:1]) return TRUE;
			if([self collisionMarkers:2 otherMarker:3]) return TRUE;
			if([self collisionMarkers:2 otherMarker:4]) return TRUE;
			if([self collisionMarkers:2 otherMarker:5]) return TRUE;
			return FALSE;
			break;
		case 3:
			if([self collisionMarkers:3 otherMarker:1]) return TRUE;
			if([self collisionMarkers:3 otherMarker:2]) return TRUE;
			if([self collisionMarkers:3 otherMarker:4]) return TRUE;
			if([self collisionMarkers:3 otherMarker:5]) return TRUE;
			return FALSE;
			break;
		case 4:
			if([self collisionMarkers:4 otherMarker:1]) return TRUE;
			if([self collisionMarkers:4 otherMarker:2]) return TRUE;
			if([self collisionMarkers:4 otherMarker:3]) return TRUE;
			if([self collisionMarkers:4 otherMarker:5]) return TRUE;
			return FALSE;
			break;
		case 5:
			if([self collisionMarkers:5 otherMarker:1]) return TRUE;
			if([self collisionMarkers:5 otherMarker:2]) return TRUE;
			if([self collisionMarkers:5 otherMarker:3]) return TRUE;
			if([self collisionMarkers:5 otherMarker:4]) return TRUE;
			return FALSE;
			break;
		default:
			return FALSE;
			break;
	}
	return FALSE;
}

- (BOOL)collisionMarkers:(int)marker1Num otherMarker:(int)marker2Num { // detect if hero collides with this agent
	CGPoint point1;
	CGPoint point2;
	switch (marker1Num) {
		case 1:
			point1.x = p1pos.x;
			point1.y = p1pos.y;
			break;
		case 2:
			point1.x = p2pos.x;
			point1.y = p2pos.y;
			break;
		case 3:
			point1.x = p3pos.x;
			point1.y = p3pos.y;
			break;
		case 4:
			point1.x = p4pos.x;
			point1.y = p4pos.y;
			break;
		case 5:
			point1.x = p5pos.x;
			point1.y = p5pos.y;
			break;
		case 6:
			point1.x = ballpos.x;
			point1.y = ballpos.y;
			break;
		default:
			break;
	}
	switch (marker2Num) {
		case 1:
			point2.x = p1pos.x;
			point2.y = p1pos.y;
			break;
		case 2:
			point2.x = p2pos.x;
			point2.y = p2pos.y;
			break;
		case 3:
			point2.x = p3pos.x;
			point2.y = p3pos.y;
			break;
		case 4:
			point2.x = p4pos.x;
			point2.y = p4pos.y;
			break;
		case 5:
			point2.x = p5pos.x;
			point2.y = p5pos.y;
			break;
		case 6:
			point2.x = ballpos.x;
			point2.y = ballpos.y;
			break;
		default:
			break;
	}
	
	if(point1.x + playerRadius >= point2.x - playerRadius &&
	   point1.x - playerRadius <= point2.x + playerRadius &&
	   point1.y + playerRadius >= point2.y - playerRadius &&
	   point1.y - playerRadius <= point2.y + playerRadius) {
		return TRUE;
	}
	return FALSE;
}

- (BOOL)collisionDots:(CGPoint)point1 otherPoint:(CGPoint)point2 { // detect if hero collides with this agent

	if(point1.x + dotdistance >= point2.x - dotdistance &&
	   point1.x - dotdistance <= point2.x + dotdistance &&
	   point1.y + dotdistance >= point2.y - dotdistance &&
	   point1.y - dotdistance <= point2.y + dotdistance) {
		return TRUE;
	}
	return FALSE;
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


- (void)dealloc {
    [super dealloc];
}


@end
