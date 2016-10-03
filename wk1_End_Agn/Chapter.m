//
//  Chapter.m
//  wk1_End_Agn
//
//  Created by User on 10/2/16.
//  Copyright © 2016 User. All rights reserved.
//

#import "Chapter.h"

@implementation Chapter

@synthesize title;
@synthesize pageCount;

-(id) init
{
    self = [super init];
    if(self)
    {
        //now initialize object here
        title = @"Default Chapter Title";
        pageCount = 0; //default used is 0
    }
    return self;
}

@end
