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

NSString * const HerePostsTableViewControllerState = @"HerePostsTableViewControllerState";
NSString * const HerePostsTableViewControllerStateLatitudeKey = @"HerePostsTableViewControllerStateLatitudeKey";
NSString * const HerePostsTableViewControllerStateLongitudeKey = @"HerePostsTableViewControllerStateLongitudeKey";
NSString * const HerePostsTableViewControllerStateRadiusKey = @"HerePostsTableViewControllerStateRadiusKey";

@interface HerePostsTableViewController () <CLLocationManagerDelegate>
@property (strong, nonatomic, readwrite) CLLocationManager *locationManager;
@property (strong, nonatomic, readwrite) UINavigationController *createPostNavigationController;
@property (strong, nonatomic, readwrite) CreatePostViewController *createPostViewController;
@end

@implementation HerePostsTableViewController

- (id)init {
    if (self = [super init]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                              target:self
                                                                                              action:@selector(addPinToFavorites)];
        self.navigationItem.leftBarButtonItem.enabled = NO;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
                                                                                               target:self
                                                                                               action:@selector(openCreatePostViewController)];
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    return self;
}

- (id)initWithState {
    if (self = [self init]) {
        NSDictionary *state = (NSDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:HerePostsTableViewControllerState];
        if (state) {
            self.pin = [Pin findOrCreateByLocation:[[CLLocation alloc] initWithLatitude:[(NSNumber *)[state objectForKey:HerePostsTableViewControllerStateLatitudeKey] doubleValue]
                                                                              longitude:[(NSNumber *)[state objectForKey:HerePostsTableViewControllerStateLongitudeKey] doubleValue]]
                                         inContext:[CoreDataManager managedObjectContext]];
            self.radius = [(NSNumber *)[state objectForKey:HerePostsTableViewControllerStateRadiusKey] doubleValue];
        }
    }
    return self;
}

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

- (void)addPinToFavorites {
    NSLog(@"%@", self.pin);
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
    
    self.navigationItem.leftBarButtonItem.enabled = YES;
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    [super setPin:newPin];
}

- (void)updateState {
    NSDictionary *newState = @{HerePostsTableViewControllerStateRadiusKey: [NSNumber numberWithDouble:self.radius],
                               HerePostsTableViewControllerStateLatitudeKey: [NSNumber numberWithDouble:self.pin.latitude],
                               HerePostsTableViewControllerStateLongitudeKey: [NSNumber numberWithDouble:self.pin.longitude]};
    [[NSUserDefaults standardUserDefaults] setObject:newState
                                              forKey:HerePostsTableViewControllerState];
}

- (void)handleRefreshControl:(id)sender {
    [self.locationManager startUpdatingLocation];
#warning this should only trigger super handleRefreshControl: once location is updated and display an error message if location can't be updated (no GPS or no Internet)
    self.postImporter.path = @"posts";
    [super handleRefreshControl:sender];
}

// ================== CLLocationManagerDelegate ==================

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    
    [self.locationManager stopUpdatingLocation];
    
    Pin *pin = [Pin findOrCreateByLocation:location
                                 inContext:[CoreDataManager managedObjectContext]];
    [pin reverseGeolocateWithCompletionHandler:^{
        self.pin = pin;
        [self.postImporter importByPin:self.pin
                                radius:self.radius];
        [self reloadData];
        [self updateState];
    }];
}

// ================== ImporterDelegate ==================

- (void)importerDidCompleteCollectionImport:(Importer *)importer {
    NSLog(@"done!");
}

- (void)importer:(Importer *)importer didFailToCompleteRequestWithError:(NSError *)error {
    NSLog(@"%@", error);
}

- (void)importer:(Importer *)importer didFailToParseObjectWithError:(NSError *)error {
    NSLog(@"%@", error);
}

@end
