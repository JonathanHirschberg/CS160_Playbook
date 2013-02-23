#import "ViewNoteController.h"
#import "EditNoteController.h"
#import "NotesViewController.h"

@implementation ViewNoteController

@synthesize tableView, notesViewController, notePos;

- (void)edit {
    EditNoteController *c = [[EditNoteController alloc] initWithNibName:@"EditNoteView" bundle:nil];
    c.notesViewController = notesViewController;
    c.viewNoteController = self;
    c.notePos = notePos;
    [self.navigationController pushViewController:c animated:YES];
    [c release];
}

#pragma mark Init

- (void)viewDidLoad {
    self.title = @"Note";
    
    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit)];
    self.navigationItem.rightBarButtonItem = edit;
    [edit release];
    
    [super viewDidLoad];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        NSString *note = [[[notesViewController notes] objectAtIndex:notePos] objectForKey:@"note"];
        CGSize size = [note sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(280, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
        return size.height + 20;
    }
    else {
        return 44;
    }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = indexPath.section == 0 ? @"TitleCell" : @"NoteCell";
    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        if (indexPath.section == 0)
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        else
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    // Set up the cell...
    if (indexPath.section == 0) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM/dd/yyyy"];
        NSString *date = [formatter stringFromDate:[[[notesViewController notes] objectAtIndex:notePos] objectForKey:@"date"]];
        [formatter release];
        
        NSString *title = [[[notesViewController notes] objectAtIndex:notePos] objectForKey:@"title"];
        cell.textLabel.text = [title length] > 0 ? title : @"Untitled Note";
        cell.detailTextLabel.text = date;
    }
    else {
        cell.textLabel.text = [[[notesViewController notes] objectAtIndex:notePos] objectForKey:@"note"];
        cell.textLabel.adjustsFontSizeToFitWidth = NO;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
	
    return cell;
}

- (void)dealloc {
    [tableView release];
    [notesViewController release];
    [super dealloc];
}

@end
