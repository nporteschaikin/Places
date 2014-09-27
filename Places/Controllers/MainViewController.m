//
//  MainViewController.m
//  Places
//
//  Created by Noah Portes Chaikin on 9/25/14.
//  Copyright (c) 2014 Noah Portes Chaikin. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "MainViewController.h"
#import "HerePostsTableViewController.h"
#import "CoreDataManager.h"

@interface MainViewController () <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) UINavigationController *hereNavigationController;
@property (strong, nonatomic) HerePostsTableViewController *herePostsTableViewController;

@end

@implementation MainViewController

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.delegate = self;
    }
    return _locationManager;
}

- (UINavigationController *)hereNavigationController {
    if (!_hereNavigationController) {
        _hereNavigationController = [[UINavigationController alloc] init];
        _hereNavigationController.tabBarItem.title = @"Here";
        [_hereNavigationController pushViewController:self.herePostsTableViewController
                                             animated:YES];
    }
    return _hereNavigationController;
}

- (HerePostsTableViewController *)herePostsTableViewController {
    if (!_herePostsTableViewController) {
        Pin *pin = [Pin findOrCreateByLocation:[[CLLocation alloc] initWithLatitude:-40
                                                                          longitude:-70]
                                     inContext:[CoreDataManager managedObjectContext]];
        _herePostsTableViewController = [[HerePostsTableViewController alloc] initWithPin:pin
                                                                                   radius:20];
    }
    return _herePostsTableViewController;
}

- (void)updateLocation {
    [self.locationManager startUpdatingLocation];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.locationManager requestWhenInUseAuthorization];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViewControllers:@[self.hereNavigationController]];
    [self updateLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    Pin *pin = [Pin findOrCreateByLocation:[locations firstObject]
                                 inContext:[CoreDataManager managedObjectContext]];
    
    [pin reverseGeolocateWithCompletionHandler:^{
        self.herePostsTableViewController.pin = pin;
        [self.herePostsTableViewController reloadData]; }];
    
    [self.locationManager stopUpdatingLocation];
};


@end
