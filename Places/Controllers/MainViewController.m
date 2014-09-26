//
//  MainViewController.m
//  Places
//
//  Created by Noah Portes Chaikin on 9/25/14.
//  Copyright (c) 2014 Noah Portes Chaikin. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "MainViewController.h"
#import "PinViewController.h"
#import "CoreDataManager.h"

@interface MainViewController () <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) UINavigationController *hereNavigationController;
@property (strong, nonatomic) PinViewController *herePinViewController;

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
        [_hereNavigationController pushViewController:self.herePinViewController
                                             animated:YES];
    }
    return _hereNavigationController;
}

- (PinViewController *)herePinViewController {
    if (!_herePinViewController) {
        Pin *pin = [Pin findOrCreateByLocation:[[CLLocation alloc] initWithLatitude:-40
                                                                          longitude:-70]
                                     inContext:[CoreDataManager managedObjectContext]];
        _herePinViewController = [[PinViewController alloc] initWithAndPredicate:nil
                                                             withSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"message"
                                                                                                                 ascending:NO]]
                                                          withSectionNameKeyPath:nil
                                                                          forPin:pin];
    }
    return _herePinViewController;
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
    CLLocation *location = [locations firstObject];
    [self updateHerePinViewControllerWithLocation:location];
    [self.locationManager stopUpdatingLocation];
};

- (void)updateHerePinViewControllerWithLocation:(CLLocation *)location {
    Post *post = [NSEntityDescription insertNewObjectForEntityForName:@"Post"
                                               inManagedObjectContext:[CoreDataManager managedObjectContext]];
    post.message = @"Hello";
    Pin *pin = [Pin findOrCreateByLocation:location
                                 inContext:[CoreDataManager managedObjectContext]];
    post.pin = pin;
    [self.herePinViewController setPin:pin];
}


@end
