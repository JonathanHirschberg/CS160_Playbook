#import "NotesViewController.h"
#import "EditNoteController.h"
#import "ViewNoteController.h"
#import "PlaybookAppDelegate.h"

@implementation NotesViewController

@synthesize tableView;

- (NSMutableArray *)notes {
    PlaybookAppDelegate *delegate = (PlaybookAppDelegate *)[[UIApplication sharedApplication] delegate];
    return delegate.notes;
}

#pragma mark Saving

//- (void)loadNotes {
//    NSPropertyListFormat format;
//    NSString *error;
//    NSData *plistData = [[NSFileManager defaultManager] contentsAtPath:[[NSBundle mainBundle] pathForResource:@"notes" ofType:@"plist"]];
//    NSDictionary *plist = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistData mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&error];
//    self.notes = [NSMutableArray arrayWithArray:[plist objectForKey:@"notes"]];
//}
//
//- (void)saveNotes {
//    NSDictionary *plist = [NSDictionary dictionaryWithObject:notes forKey:@"notes"];
//    NSString *error;
//    NSData *data = [NSPropertyListSerialization dataFromPropertyList:plist format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
//    [data writeToFile:[[NSBundle mainBundle] pathForResource:@"notes" ofType:@"plist"] atomically:YES];
//}

#pragma mark Init

- (void)addNote {
    EditNoteController *c = [[EditNoteController alloc] initWithNibName:@"EditNoteView" bundle:nil];
    c.notePos = -1;
    c.notesViewController = self;
    [self.navigationController pushViewController:c animated:YES];
    [c release];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    self.title = @"Notes";
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNote)];
    self.navigationItem.rightBarButtonItem = add;
    [add release];
    
    self.navigationItem.leftBarButtonItem = [self editButtonItem];
    
    //[self loadNotes];
    
    [super viewDidLoad];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self notes] count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSDictionary *note = [[self notes] objectAtIndex:indexPath.row];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSString *date = [formatter stringFromDate:[note objectForKey:@"date"]];
    [formatter release];
    
    // Set up the cell...
    NSString *title = [note objectForKey:@"title"];
    NSLog(title);
    cell.textLabel.text = [title length] == 0 ? [note objectForKey:@"note"] : title;
    cell.detailTextLabel.text = date;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
    return cell;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
    ViewNoteController *c = [[ViewNoteController alloc] initWithNibName:@"EditNoteView" bundle:nil];
    c.notePos = indexPath.row;
    c.notesViewController = self;
    [self.navigationController pushViewController:c animated:YES];
    [c release];
}

- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[self notes] removeObjectAtIndex:indexPath.row];
        //[self saveNotes];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    }
}

- (void)dealloc {
    [tableView release];
    //[notes release];
    [super dealloc];
}

@end
