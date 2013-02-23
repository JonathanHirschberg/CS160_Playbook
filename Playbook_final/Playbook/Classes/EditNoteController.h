#import <UIKit/UIKit.h>

@class NotesViewController;
@class ViewNoteController;

@interface EditNoteController : UITableViewController <UITextFieldDelegate, UITextViewDelegate> {
    UITableView *tableView;
    NotesViewController *notesViewController;
    ViewNoteController *viewNoteController;
    NSUInteger notePos;
    
    UITextField *titleTextField;
    UITextView *noteTextView;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NotesViewController *notesViewController;
@property (nonatomic, retain) ViewNoteController *viewNoteController;
@property (nonatomic) NSUInteger notePos;

@end
