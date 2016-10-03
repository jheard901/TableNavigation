//
//  RowViewController.m
//  wk1_End_Agn
//
//  Created by User on 10/3/16.
//  Copyright © 2016 User. All rights reserved.
//

#import "RowViewController.h"

@interface RowViewController ()

@end

@implementation RowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //this is hard coded for quickness, not good but it'll have to do for now
    self.bookNumLabel.text = [NSString stringWithFormat:@"%@", [self.labels objectAtIndex:0]];
    self.chapterNumLabel.text = [NSString stringWithFormat:@"%@", [self.labels objectAtIndex:1]];
    self.pageCountLabel.text = [NSString stringWithFormat:@"%@", [self.labels objectAtIndex:2]];
    
    //self.bookNumLabel.text = @"Work or Riot"; //debug test
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
