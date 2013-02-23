#import "NSString.h"

@implementation NSString (player)

- (NSComparisonResult)playerCompare:(NSString *)p {
    NSArray *myParts = [self componentsSeparatedByString:@" "];
    NSArray *pParts = [p componentsSeparatedByString:@" "];
    
    return [[myParts lastObject] caseInsensitiveCompare:[pParts lastObject]];
}

@end
