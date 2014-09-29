//
//  Post.h
//  Places
//
//  Created by Noah Portes Chaikin on 9/25/14.
//  Copyright (c) 2014 Noah Portes Chaikin. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "Pin.h"

@interface Post : NSManagedObject

@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) Pin *pin;
@property (strong, nonatomic) NSDate *createdAt;

+ (NSFetchRequest *)fetchRequestForPostsWithinRadius:(double)radius
                                               ofPin:(Pin *)pin;

+ (NSPredicate *)predicateForPostsWithinRadius:(double)radius
                                         ofPin:(Pin *)pin;

@end
