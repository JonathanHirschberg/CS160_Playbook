#import <UIKit/UIKit.h>

@interface NotesViewController : UITableViewController {
    UITableView *tableView;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;

- (void)saveNotes;
- (NSMutableArray *)notes;

@end
