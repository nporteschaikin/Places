//
//  PinPostsTableViewController.m
//  Places
//
//  Created by Noah Portes Chaikin on 9/25/14.
//  Copyright (c) 2014 Noah Portes Chaikin. All rights reserved.
//

#import "PinPostsTableViewController.h"

@implementation PinPostsTableViewController

- (id)initWithPin:(Pin *)pin radius:(double)radius {
    if (self = [super init]) {
        self.pin = pin;
        self.radius = radius;
    }
    return self;
}

- (NSFetchRequest *)fetchRequest {
    NSFetchRequest *fetchRequest = [super fetchRequest];
    
    fetchRequest.predicate = [Post predicateForPostsWithinRadius:self.radius
                                                           ofPin:self.pin];
    
    return fetchRequest;
}

@end
