#import <UIKit/UIKit.h>

@interface PlaybookViewController : UITableViewController {
	PlaybookAppDelegate *appDelegate;
	NSMutableArray *savedNames;
	DrawPlayViewController *drawPlayViewController;
}
@property (retain, nonatomic) PlaybookAppDelegate *appDelegate;
@property (retain, nonatomic) NSMutableArray *savedNames;
@property (retain, nonatomic) DrawPlayViewController *drawPlayViewController;
- (void)reloadSavedPlays;
-(void) newPlay:(id) sender;

@end
