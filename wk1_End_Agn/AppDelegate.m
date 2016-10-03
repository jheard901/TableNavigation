//
//  AppDelegate.m
//  wk1_End_Agn
//
//  Created by User on 10/2/16.
//  Copyright © 2016 User. All rights reserved.
//

#import "AppDelegate.h"
#import "Book.h"
#import "Chapter.h"
#import "ViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

//modifying elements of an array explained here: http://stackoverflow.com/questions/4402853/change-values-inside-an-array
NSMutableArray* books;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    books = [NSMutableArray arrayWithCapacity:20];
    
    //1st book
    Book* book = [[Book alloc] init];
    book.title = @"My Little Pony";
    //Create 3 default chapters
    NSMutableArray* newChapters = [NSMutableArray array];
    for(int i=0; i < 3; i++)
    {
        Chapter* nChapter = [[Chapter alloc] init];
        [newChapters addObject:nChapter];
    }
    book.chapters = [NSMutableArray arrayWithArray:newChapters];
    //Modding 1st Chapter
    ((Chapter*)[book.chapters objectAtIndex:0]).title = @"Rise of the Ponies";
    ((Chapter*)[book.chapters objectAtIndex:0]).pageCount = 27;
    //Modding 2nd Chapter
    ((Chapter*)[book.chapters objectAtIndex:1]).title = @"Enter Rainbow Dash";
    ((Chapter*)[book.chapters objectAtIndex:1]).pageCount = 42;
    //Modding 3rd Chapter
    ((Chapter*)[book.chapters objectAtIndex:2]).title = @"Cutie Mark Clash";
    ((Chapter*)[book.chapters objectAtIndex:2]).pageCount = 18;
    [books addObject:book];
    
    //2nd book
    book = [[Book alloc] init];
    book.title = @"Kingdoms Fall";
    //Create 3 default chapters
    newChapters = [NSMutableArray array];
    for(int i=0; i < 3; i++)
    {
        Chapter* nChapter = [[Chapter alloc] init];
        [newChapters addObject:nChapter];
    }
    book.chapters = [NSMutableArray arrayWithArray:newChapters];
    //Modding 1st Chapter
    ((Chapter*)[book.chapters objectAtIndex:0]).title = @"Birth of a Noble House";
    ((Chapter*)[book.chapters objectAtIndex:0]).pageCount = 36;
    //Modding 2nd Chapter
    ((Chapter*)[book.chapters objectAtIndex:1]).title = @"The Mad King";
    ((Chapter*)[book.chapters objectAtIndex:1]).pageCount = 64;
    //Modding 3rd Chapter
    ((Chapter*)[book.chapters objectAtIndex:2]).title = @"The Long Winter";
    ((Chapter*)[book.chapters objectAtIndex:2]).pageCount = 43;
    [books addObject:book];
    
    //3rd book
    book = [[Book alloc] init];
    book.title = @"Drangleic";
    //Create 3 default chapters
    newChapters = [NSMutableArray array];
    for(int i=0; i < 3; i++)
    {
        Chapter* nChapter = [[Chapter alloc] init];
        [newChapters addObject:nChapter];
    }
    book.chapters = [NSMutableArray arrayWithArray:newChapters];
    //Modding 1st Chapter
    ((Chapter*)[book.chapters objectAtIndex:0]).title = @"Into the Fire";
    ((Chapter*)[book.chapters objectAtIndex:0]).pageCount = 21;
    //Modding 2nd Chapter
    ((Chapter*)[book.chapters objectAtIndex:1]).title = @"Legacy of the Flame";
    ((Chapter*)[book.chapters objectAtIndex:1]).pageCount = 36;
    //Modding 3rd Chapter
    ((Chapter*)[book.chapters objectAtIndex:2]).title = @"Dying Breath of a King";
    ((Chapter*)[book.chapters objectAtIndex:2]).pageCount = 42;
    [books addObject:book];
    
    //set the ViewController to use these initial books (dataSource)
    UINavigationController* navigationController = (UINavigationController*)self.window.rootViewController;
    ViewController *viewController = (ViewController*)[[navigationController viewControllers] objectAtIndex:0];
    viewController.books = books;
    
    //init segment index
    viewController.segmentIndex = 0;
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"wk1_End_Agn"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
