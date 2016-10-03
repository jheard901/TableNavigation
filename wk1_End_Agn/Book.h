//
//  Book.h
//  wk1_End_Agn
//
//  Created by User on 10/2/16.
//  Copyright © 2016 User. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

@property NSString* title;
@property NSMutableArray* chapters;

- (id) init;

@end
