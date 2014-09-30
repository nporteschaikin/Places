//
//  HerePostsTableViewController.m
//  Places
//
//  Created by Noah Portes Chaikin on 9/27/14.
//  Copyright (c) 2014 Noah Portes Chaikin. All rights reserved.
//

#import "HerePostsTableViewController.h"
#import "CoreDataManager.h"

@interface HerePostsTableViewController () <CLLocationManagerDelegate>
@property (strong, nonatomic, readwrite) CLLocationManager *locationManager;
@end

@implementation HerePostsTableViewController

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.delegate = self;
    }
    return _locationManager;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}

- (void)handleRefreshControl:(id)sender {
    [self.locationManager startUpdatingLocation];
    [super handleRefreshControl:sender];
}

// ================== CLLocationManagerDelegate ==================

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    
    [self.locationManager stopUpdatingLocation];
    
    Pin *pin = [Pin findOrCreateByLocation:location
                                 inContext:[[CoreDataManager sharedManager] managedObjectContext]];
    self.pin = pin;
}

@end
