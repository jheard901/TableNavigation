//
//  RowViewController.h
//  wk1_End_Agn
//
//  Created by User on 10/3/16.
//  Copyright © 2016 User. All rights reserved.
//

#import <UIKit/UIKit.h>

//for use with the view associated with a row that is selected from table
@interface RowViewController : UIViewController

//if you have trouble hooking up connections from storyboard to a subview controller class then try this advice: http://stackoverflow.com/questions/20293989/cannot-create-outlet-connections-to-subviews-in-interface-builder-xcode-5
//NOTE, my problem was that I forgot to type in the class name for this new view controller into its Identifier tab
@property (assign, nonatomic) IBOutlet UILabel* bookNumLabel;
@property (assign, nonatomic) IBOutlet UILabel* chapterNumLabel;
@property (assign, nonatomic) IBOutlet UILabel* pageCountLabel;

@property NSMutableArray* labels;

@end
