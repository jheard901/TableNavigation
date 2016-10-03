//
//  ViewController.m
//  wk1_End_Agn
//
//  Created by User on 10/2/16.
//  Copyright © 2016 User. All rights reserved.
//

#import "ViewController.h"
#import "Book.h"
#import "Chapter.h"
#import "RowViewController.h"

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //setting up the segmentedControl is done based off this info: http://stackoverflow.com/questions/11638861/uisegmentedcontrol-change-number-of-segments-programmatically
    //note, this has to be done after the view has loaded, it won't work in the setup area of AppDelegate.m
    [self.bookSegmentControl removeAllSegments];
    for(Book* sBook in self.books)  //the 'in' operator explained: http://stackoverflow.com/questions/12389559/objective-c-in-operator
    {
        [self.bookSegmentControl insertSegmentWithTitle:sBook.title atIndex:self.bookSegmentControl.numberOfSegments animated:NO];
    }
    
    //need to use an underscore when referring to any objects that are a property || rather, use "self.[property]" instead
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.books count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    Book* book = [self.books objectAtIndex:section];
    return [book.chapters count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // The header for the section is the region name -- get this from the region at the section index.
    Book* book = [self.books objectAtIndex:section];
    
    //return ((Chapter*)[book.chapters objectAtIndex:0]).title; //debug testing
    return [book title];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"TableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:MyIdentifier];
    }
    Book* book = [self.books objectAtIndex:indexPath.section];
    Chapter* chapter = [book.chapters objectAtIndex:indexPath.row];
    cell.textLabel.text = chapter.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%i", chapter.pageCount];   //formatting a string to use an int: http://stackoverflow.com/questions/3414644/how-to-convert-integer-to-string-in-objective-c
    return cell;
}

//triggers when a row from a table is selected | info from: http://stackoverflow.com/questions/22759167/how-to-make-a-push-segue-when-a-uitableviewcell-is-selected
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //trigger segue to new view only if switch is on
    if(self.masterSwitch.isOn)
    {
        [self performSegueWithIdentifier:@"selectionSegue" sender:self];
    }
}

//prepare a segue to pass values to a view that it leads to
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure the segue identifier in storyboard is the same as here
    if ([[segue identifier] isEqualToString:@"selectionSegue"])
    {
        ////// If you need to pass data to the next controller do it here //////
        
        //get the destination controller of the segue
        RowViewController* rowViewController = (RowViewController*)segue.destinationViewController;
        
        //get indexPath of current selected row
        NSIndexPath* nRowPath = [self.tableView indexPathForSelectedRow];
        //add 1 because these are indexes (elements 0-2 should appear to users as books 1-3, eg)
        NSNumber* a = [NSNumber numberWithInt:(int)(nRowPath.section + 1)];
        NSNumber* b = [NSNumber numberWithInt:(int)(nRowPath.row + 1)];
        NSNumber* c = [NSNumber numberWithInt:(int)((Chapter*)[((Book*)[self.books objectAtIndex:nRowPath.section]).chapters objectAtIndex:nRowPath.row]).pageCount];
        
        //passing values has only worked using a NSMutableArray from that viewController that was initialized
        rowViewController.labels = [NSMutableArray array];
        [rowViewController.labels addObject:a];
        [rowViewController.labels addObject:b];
        [rowViewController.labels addObject:c];
        
        //trying to directly set the values of rowViewController won't work here because that class hasn't been initialized yet; instead I think it best for now to utilize viewDidLoad as the point for where you initialize the class with data passed to it from other classes
    }
}

//using alert controllers with objective c: http://hayageek.com/uialertcontroller-example-ios/
- (IBAction)pressedStepper:(UIStepper*)sender {
    
    ////// Check if the stepper was incremented or decremented //////
    
    //add a book if increased
    if(sender.value > (double)[self.books count])
    {
        //confirm a valid book title was entered, then enter it into array
        if(![self.titleTxtField.text  isEqual:@""])
        {
            //alert to inform user of new book being added
            UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Added a New Book" 
                message:[NSString stringWithFormat:@"You have %i books in table.", (int)sender.value]
                preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action)
                {
                    [alertController dismissViewControllerAnimated:YES completion:nil];
                }];
            [alertController addAction:ok];
            [self presentViewController:alertController animated:YES completion:nil];
            
            //add the new book to array
            Book* newBook = [[Book alloc] init];
            newBook.title = self.titleTxtField.text;
            [self.books addObject:newBook];
            
            //update the segmentControl with new book | info from: http://stackoverflow.com/questions/11638861/uisegmentedcontrol-change-number-of-segments-programmatically
            [self.bookSegmentControl insertSegmentWithTitle:newBook.title atIndex:([self.books count] - 1) animated:YES];
            
            //refresh the table
            [self RefreshTable:self.tableView];
            
            //side note, this explains how to call functions in Objective C:
            //http://stackoverflow.com/questions/2628538/how-do-i-call-an-objective-c-function
        }
        else
        {
            //if invalid text field, then we revert to the previous value
            sender.value -= 1;
            
            //alert to inform user nothing was added
            UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Error A1200"
                message:@"Please provide a title when adding books." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action)
                { [alertController dismissViewControllerAnimated:YES completion:nil]; }];
            [alertController addAction:ok];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
    //remove a book if decreased
    else
    {
        //this will always be true when decrementing the stepper except in the case when both the stepper and book count are at 0
        if(sender.value < (double)[self.books count])
        {
            //alert to inform user of last book being removed
            Book* lastBook = [self.books lastObject];   //on how to access last element of array: http://stackoverflow.com/questions/7175256/how-to-get-the-last-object-of-an-nsarray
            UIAlertController* alertController = [UIAlertController alertControllerWithTitle: [NSString stringWithFormat:@"Removed Book: %@",
                lastBook.title] message:[NSString stringWithFormat:@"You have %i books remaining in table.", (int)sender.value]
                preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action)
                {
                    [alertController dismissViewControllerAnimated:YES completion:nil];
                }];
            [alertController addAction:ok];
            [self presentViewController:alertController animated:YES completion:nil];
            
            //remove the last book from array | info from: http://stackoverflow.com/questions/33772579/how-to-remove-last-object-from-nsmutablearray-in-ios-without-app-crash
            [self.books removeLastObject];
            
            //update the segmentControl to remove last book
            [self.bookSegmentControl removeSegmentAtIndex:([self.bookSegmentControl numberOfSegments] - 1) animated:YES];
            
            //refresh the table
            [self RefreshTable:self.tableView];
        }
    }
}

//this info helped me think of a solution for getting the segmented index: http://stackoverflow.com/questions/20780001/how-to-get-value-from-segmented-control-to-know-which-one-was-picked
- (IBAction)selectedSegment:(UISegmentedControl*)sender
{
    self.segmentIndex = (int)sender.selectedSegmentIndex;
}

//when button is touched, the next action depends on position of masterSwitch
- (IBAction)pressedButton:(UIButton *)sender {
    
    //add a new chapter if possible
    if(self.masterSwitch.isOn)
    {
        //confirm a valid chapter title and page count was entered || info on conditional for string with numbers only from: http://stackoverflow.com/questions/6091414/finding-out-whether-a-string-is-numeric-or-not
        NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        if(![self.titleTxtField.text  isEqual:@""] && ![self.pageTxtField.text  isEqual:@""] && [self.pageTxtField.text rangeOfCharacterFromSet:notDigits].location == NSNotFound)
        {
            //if we make it here, then the input was valid || assume we don't have to check if a segment is currently selected
            
            //get index of currently selected book
            NSInteger nIndex = self.bookSegmentControl.selectedSegmentIndex;
            
            //confirm the index is valid
            if(nIndex >= 0)
            {
                Book* nBook = [self.books objectAtIndex:nIndex];
                
                //add the new chapter to current selected book array
                Chapter* newChapter = [[Chapter alloc] init];
                newChapter.title = self.titleTxtField.text;
                //info on filtering string to int: http://stackoverflow.com/questions/3559088/objectivec-parse-integer-from-string
                newChapter.pageCount = self.pageTxtField.text.intValue;
                
                //allocate/initialize chapters array if it is nil (null?)
                if(nBook.chapters == nil)
                {
                    nBook.chapters = [NSMutableArray array];
                }
                [nBook.chapters addObject:newChapter];  //had to change Book.chapters to NSMutableArray for this to work | is there no way around that?
                
                //refresh the table
                [self RefreshTable:self.tableView];
            }
            //display error message for invalid index (no segment selected)
            else
            {
                //alert to inform user to select a segment
                UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Error A1212"
                    message:@"Please select a book before adding new chapters." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action)
                    { [alertController dismissViewControllerAnimated:YES completion:nil]; }];
                [alertController addAction:ok];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }
        else
        {
            //alert to inform user nothing was added
            UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Error A1223"
                message:@"Please provide a title, and page count as a number when adding books." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action)
                                 { [alertController dismissViewControllerAnimated:YES completion:nil]; }];
            [alertController addAction:ok];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
    //delete the selected chapter from table
    else
    {
        //check first if a chapter (cell in the table) is selected || info from: http://stackoverflow.com/questions/4318386/uitableview-detect-selected-cell
        NSIndexPath* nCellPath = [self.tableView indexPathForSelectedRow];
        UITableViewCell* nCell = [self.tableView cellForRowAtIndexPath:nCellPath];
        if(nCell.isSelected)
        {
            //a cell is selected and can be deleted from table
            
            //ask user if they are sure they want to delete the chapter
            UIAlertController* alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Remove Chapter: %@?",
                nCell.textLabel.text] message:@"Are you sure you want to remove this chapter from the book?"
                preferredStyle:UIAlertControllerStyleAlert];
            //OK to confirm delete
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action)
            {
                //syntax for deleting rows from "RatingsTut" project | I need to delete object from array before removing the row
                
                //I had the biggest issue with removing cells from table because I didn't delete the object from the array prior to attempting to remove that cell from the table. A little supporting info can be found here: http://stackoverflow.com/questions/13750980/delete-a-cell-row-in-objective-c
                [((Book*)[self.books objectAtIndex:nCellPath.section]).chapters removeObjectAtIndex:nCellPath.row];
                [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:nCellPath, nil] withRowAnimation:UITableViewRowAnimationFade];
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }];
            //CANCEL to back out without deleting
            UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"CANCEL" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action)
            {
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertController addAction:ok];
            [alertController addAction:cancel];
            [self presentViewController:alertController animated:YES completion:nil];
            
            
            //refresh the table
            [self RefreshTable:self.tableView];
        }
        //inform user to select a cell (chapter) to delete
        else
        {
            //alert to inform user to select a Chapter for deletion
            UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Error A1213"
                message:@"Please select a chapter before attempting deletion." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action)
                { [alertController dismissViewControllerAnimated:YES completion:nil]; }];
            [alertController addAction:ok];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
}

- (void)RefreshTable:(UITableView *)aTable
{
    [aTable reloadData];
}



@end
