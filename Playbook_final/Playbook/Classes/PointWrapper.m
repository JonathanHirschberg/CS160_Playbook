//
//  PointWrapper.m
//  Playbook
//
//  Created by Class Account on 4/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PointWrapper.h"


@implementation PointWrapper
@synthesize point;

// http://stackoverflow.com/questions/448173/encoding-cgpoint-struct-with-nscoder
// http://www.cocoadev.com/index.pl?NSCoder
- (void)encodeWithCoder:(NSCoder *)encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeValueOfObjCType:@encode(CGPoint) at:&point];
}

- (id)initWithCoder:(NSCoder *)decoder {
	if (self=[super initWithCoder:decoder]) {
		if (self=[super init]) {
			[decoder decodeValueOfObjCType:@encode(CGPoint) at:&point];
		}
	}
	return self;
}

@end
