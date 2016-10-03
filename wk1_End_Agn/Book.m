//
//  Book.m
//  wk1_End_Agn
//
//  Created by User on 10/2/16.
//  Copyright © 2016 User. All rights reserved.
//

#import "Book.h"
#import "Chapter.h"

@implementation Book

//explains "@synthesize" briefly: http://stackoverflow.com/questions/3266467/what-exactly-does-synthesize-do
//more info on what "@synthesize" is: http://stackoverflow.com/questions/19784454/when-should-i-use-synthesize-explicitly
@synthesize title;
@synthesize chapters;

-(id) init
{
    self = [super init];
    if(self)
    {
        //now initialize object here
        title = @"Default Book Title";
        self.chapters = nil; //alternatively this could be "self.chapters = [NSMutableArray array]" so I don't have to manually init it later
        
        /*
        //MOVING THIS INITIALIZATION CODE TO APPDELEGATE.M
        NSMutableArray* newChapters = [NSMutableArray array];
        //info on initializing arrays with objects: http://stackoverflow.com/questions/3646787/making-an-array-of-objects-in-objective-c
        //more info on initializing arrays: http://stackoverflow.com/questions/14970412/initialize-array-of-objects-using-nsarray
        for(int i=0; i < 3; i++)
        {
            //create 3 chapters for a book by default
            Chapter* nChapter = [[Chapter alloc] init];
            int nValue = 10 + (i*10); //10, 20, and 30 should be page counts of each chapter respectively
            nChapter.pageCount = nValue;
            [newChapters addObject:nChapter];
        }
        self.chapters = [NSArray arrayWithArray:newChapters];
        */
        
    }
    return self;
}


@end
