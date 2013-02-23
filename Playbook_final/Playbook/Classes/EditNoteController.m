#import "EditNoteController.h"
#import "NotesViewController.h"
#import "ViewNoteController.h"

#define kTextFieldWidth	280.0
#define kLeftMargin				10.0
#define kTopMargin				10.0
#define kRightMargin			10.0
#define kTextFieldHeight		30.0

@implementation EditNoteController

@synthesize tableView, notesViewController, viewNoteController, notePos;

const NSInteger kViewTag = 1;

#pragma mark Text inputs

- (void)updateDoneButton {
    if ([noteTextView.text length] > 0)
        self.navigationItem.rightBarButtonItem.enabled = YES;
    else
        self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [noteTextView becomeFirstResponder];
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    [self updateDoneButton];
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    [self updateDoneButton];
}

- (UITextField *)titleTextField {
    if (titleTextField == nil) {
        CGRect frame = CGRectMake(kLeftMargin, kTopMargin, kTextFieldWidth, kTextFieldHeight);
        titleTextField = [[UITextField alloc] initWithFrame:frame];
        
        titleTextField.borderStyle = UITextBorderStyleNone;
        titleTextField.textColor = [UIColor blackColor];
        titleTextField.font = [UIFont systemFontOfSize:17.0];
        titleTextField.placeholder = @"Enter Title";
        titleTextField.backgroundColor = [UIColor whiteColor];
        
        titleTextField.keyboardType = UIKeyboardTypeDefault;
        titleTextField.returnKeyType = UIReturnKeyNext;
        
        titleTextField.tag = kViewTag;		// tag this control so we can remove it later for recycled cells
        
        titleTextField.delegate = self;	// let us be the delegate so we know when the keyboard's "Done" button is pressed
        
        if (notePos != -1) {
            titleTextField.text = [[[notesViewController notes] objectAtIndex:notePos] objectForKey:@"title"];
        }
    }
    
	return titleTextField;
}

- (UITextView *)noteTextView {
    if (noteTextView == nil) {
        CGRect frame = CGRectMake(kLeftMargin, kTopMargin, kTextFieldWidth, 76 + kTextFieldHeight);
        noteTextView = [[UITextView alloc] initWithFrame:frame];
        
        noteTextView.font = [UIFont systemFontOfSize:14];
        noteTextView.editable = YES;
        noteTextView.tag = kViewTag;
        
        noteTextView.delegate = self;
        
        if (notePos != -1) {
            noteTextView.text = [[[notesViewController notes] objectAtIndex:notePos] objectForKey:@"note"];
        }
    }
    
    return noteTextView;
}

#pragma mark Saving

- (void)save {
    if (notesViewController != nil) {
        NSDictionary *newNote = [NSDictionary dictionaryWithObjectsAndKeys:
                titleTextField.text, @"title",
                [NSDate date], @"date",
                 noteTextView.text, @"note", nil];
        if (notePos == -1)
            [[notesViewController notes] insertObject:newNote atIndex:0];
        else
            [[notesViewController notes] replaceObjectAtIndex:notePos withObject:newNote];
        
        //[notesViewController saveNotes];
        [notesViewController.tableView reloadData];
    }
    
    if (viewNoteController != nil) {
        [viewNoteController.tableView reloadData];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Init

- (void)viewDidLoad {
    if (notePos == -1) {
        self.title = @"New Note";
    }
    else {
        self.title = @"Edit Note";
    }
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = done;
    [done release];
    
    [self titleTextField];
    [self noteTextView];
    [self updateDoneButton];
    
    [super viewDidLoad];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	switch (section) {
        case 0:
            return @"Title";
        case 1:
            return @"Date";
        case 2:
            return @"Note";
    }
    
    return nil;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (void)setUpTitleCell:(UITableViewCell *)cell {
    [cell.contentView addSubview:[self titleTextField]];
}

- (void)setUpDateCell:(UITableViewCell *)cell {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    
    NSDate *date;
    if (notePos == -1) {
        date = [NSDate date];
    }
    else {
        date = [[[notesViewController notes] objectAtIndex:notePos] objectForKey:@"date"];
    }
    
    NSString *dateString = [formatter stringFromDate:date];
    [formatter release];
    
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    cell.textLabel.text = dateString;
}

- (void)setUpNoteCell:(UITableViewCell *)cell {
    [cell.contentView addSubview:[self noteTextView]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2)
        return 120;
    else
        return 44;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else {
        // a cell is being recycled, remove the old edit field (if it contains one of our tagged edit fields)
        UIView *viewToCheck = nil;
        viewToCheck = [cell.contentView viewWithTag:kViewTag];
        if (!viewToCheck)
            [viewToCheck removeFromSuperview];
    }
    
    // Set up the cell...
    if (indexPath.section == 0)
        [self setUpTitleCell:cell];
    else if (indexPath.section == 1)
        [self setUpDateCell:cell];
    else
        [self setUpNoteCell:cell];
	
    return cell;
}

- (void)dealloc {
    [tableView release];
    [notesViewController release];
    [viewNoteController release];
    [titleTextField release];
    [noteTextView release];
    [super dealloc];
}

@end
