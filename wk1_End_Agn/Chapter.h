//
//  Chapter.h
//  wk1_End_Agn
//
//  Created by User on 10/2/16.
//  Copyright © 2016 User. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Chapter : NSObject

//info on assigning NSInteger here: http://stackoverflow.com/questions/12275423/assigning-nsinteger-property-in-iphone-app
@property NSString* title;
@property (nonatomic, assign) int pageCount; //number of pages in a chapter

- (id) init;

@end
