#import <UIKit/UIKit.h>
@class PlaybookAppDelegate;

@interface StatsViewController : UITableViewController {
	PlaybookAppDelegate *appDelegate;

}
@property (retain, nonatomic) PlaybookAppDelegate *appDelegate;

@end
