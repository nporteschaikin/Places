//
//  HerePostsTableViewController.m
//  Places
//
//  Created by Noah Portes Chaikin on 9/27/14.
//  Copyright (c) 2014 Noah Portes Chaikin. All rights reserved.
//

#import "HerePostsTableViewController.h"
#import "CreatePostViewController.h"
#import "CoreDataManager.h"

@interface HerePostsTableViewController () <CLLocationManagerDelegate>
@property (strong, nonatomic, readwrite) CLLocationManager *locationManager;
@property (strong, nonatomic, readwrite) UINavigationController *createPostNavigationController;
@property (strong, nonatomic, readwrite) CreatePostViewController *createPostViewController;
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

- (UINavigationController *)createPostNavigationController {
    if (!_createPostNavigationController) {
        _createPostNavigationController = [[UINavigationController alloc] initWithRootViewController:self.createPostViewController];
        _createPostNavigationController.automaticallyAdjustsScrollViewInsets = NO;
    }
    return _createPostNavigationController;
}

- (CreatePostViewController *)createPostViewController {
    if (!_createPostViewController) {
        _createPostViewController = [[CreatePostViewController alloc] init];
    }
    return _createPostViewController;
}

- (void)viewDidLoad {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                           target:self
                                                                                           action:@selector(openCreatePostViewController)];
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}

- (void)openCreatePostViewController {
    self.createPostViewController.pin = self.pin;
    
    [self presentViewController:self.createPostNavigationController
                       animated:YES
                     completion:nil];
}

- (void)setPin:(Pin *)newPin {
    
    if (newPin.subLocality) {
        self.navigationItem.title = newPin.subLocality;
    } else if (newPin.locality) {
        self.navigationItem.title = newPin.locality;
    } else if (newPin.subThoroughfare) {
        self.navigationItem.title = newPin.subThoroughfare;
    } else if (newPin.thoroughfare) {
        self.navigationItem.title = newPin.thoroughfare;
    } else if (newPin.subAdministrativeArea) {
        self.navigationItem.title = newPin.subAdministrativeArea;
    } else if (newPin.administrativeArea) {
        self.navigationItem.title = newPin.administrativeArea;
    } else {
        self.navigationItem.title = newPin.name;
    }
    
    [super setPin:newPin];
}

// ================== CLLocationManagerDelegate ==================

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    
    [self.locationManager stopUpdatingLocation];
    
    Pin *pin = [Pin findOrCreateByLocation:location
                                 inContext:[CoreDataManager managedObjectContext]];
    [pin reverseGeolocateWithCompletionHandler:^{
        self.pin = pin;
        [self reloadData];
    }];
}

@end
