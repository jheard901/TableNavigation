//
//  ViewController.h
//  wk1_End_Agn
//
//  Created by User on 10/2/16.
//  Copyright © 2016 User. All rights reserved.
//

#import <UIKit/UIKit.h>

//instructions on creating a table view manually without using the table view controller object in storyboard: https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/TableView_iPhone/CreateConfigureTableView/CreateConfigureTableView.html#//apple_ref/doc/uid/TP40007451-CH6-SW4
//additional resource material on creating a table: http://stackoverflow.com/questions/17534413/how-to-use-tableview-inside-viewcontroller

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

//The largest issue I had was not knowing to setup the dataSource and delegate for the TableView in the view controller. Figured this out by control dragging from the table view to the view controller for both the dataSource and delegate. Main info found in comments below example pictures here: http://stackoverflow.com/questions/11068498/connect-uitableview-datasource-delegate-to-base-uiviewcontroller-class

@property (nonatomic, strong) NSMutableArray* books;

@property (nonatomic, assign) int segmentIndex;


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UITextField *titleTxtField;

@property (weak, nonatomic) IBOutlet UITextField *pageTxtField;

@property (weak, nonatomic) IBOutlet UIStepper *bookStepper;

@property (weak, nonatomic) IBOutlet UISegmentedControl *bookSegmentControl;

@property (weak, nonatomic) IBOutlet UISwitch *masterSwitch;


- (IBAction)pressedStepper:(UIStepper*)sender;

- (IBAction)selectedSegment:(UISegmentedControl*)sender;

- (IBAction)pressedButton:(UIButton*)sender;


-(void)RefreshTable:(UITableView*)aTable;

@end

