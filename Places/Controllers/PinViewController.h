//
//  PinViewController.h
//  Places
//
//  Created by Noah Portes Chaikin on 9/25/14.
//  Copyright (c) 2014 Noah Portes Chaikin. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "PostsTableViewController.h"
#import "Pin.h"

@interface PinViewController : PostsTableViewController

@property (strong, nonatomic, readwrite) Pin *targetPin;

- (id)initWithTargetPin:(Pin *)targetPin;

@end
