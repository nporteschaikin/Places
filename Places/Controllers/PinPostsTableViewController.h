//
//  PinPostsTableViewController.h
//  Places
//
//  Created by Noah Portes Chaikin on 9/25/14.
//  Copyright (c) 2014 Noah Portes Chaikin. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "PostsTableViewController.h"
#import "Pin.h"

@interface PinPostsTableViewController : PostsTableViewController

@property (strong, nonatomic, readwrite) Pin *pin;
@property (nonatomic, readwrite) double radius;

- (id)initWithPin:(Pin *)pin radius:(double)radius;

@end
