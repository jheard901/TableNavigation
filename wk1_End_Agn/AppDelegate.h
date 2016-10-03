//
//  AppDelegate.h
//  wk1_End_Agn
//
//  Created by Javier Heard on 10/2/16.
//  Copyright © 2016 User. All rights reserved.
//
//  Description:
//  In a nutshell, this app is simply a table of books and chapters allowing users
//  to add or remove books/chapters in the data as they desire.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

