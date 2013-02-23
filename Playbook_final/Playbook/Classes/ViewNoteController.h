#import <UIKit/UIKit.h>

@class NotesViewController;

@interface ViewNoteController : UITableViewController {
    UITableView *tableView;
    NotesViewController *notesViewController;
    NSUInteger notePos;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NotesViewController *notesViewController;
@property (nonatomic) NSUInteger notePos;

@end
