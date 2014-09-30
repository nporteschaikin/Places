//
//  PinPostsTableViewController.m
//  Places
//
//  Created by Noah Portes Chaikin on 9/25/14.
//  Copyright (c) 2014 Noah Portes Chaikin. All rights reserved.
//

#import "PinPostsTableViewController.h"
#import "CreatePostViewController.h"

static NSString * const PinPostsTableViewControllerPinPredicateKey = @"PinPostsTableViewControllerPinPredicateKey";

@interface PinPostsTableViewController () <PinDelegate>

@property (strong, nonatomic, readwrite) UINavigationController *createPostNavigationController;
@property (strong, nonatomic, readwrite) CreatePostViewController *createPostViewController;

@end

@implementation PinPostsTableViewController

- (id)init {
    if (self = [super init]) {
        [self setupBarButtonItems];
    }
    return self;
}

- (NSPredicate *)defaultPredicate {
    return [Post predicateForPostsWithinRadius:self.radius
                                         ofPin:self.pin];
}

- (void)setPin:(Pin *)pin {
    _pin = pin;
    _pin.delegate = self;
    [pin reverseGeolocate];
    
    [self enableBarButtonItems];
    [self performRefreshIfNeeded];
}

- (void)setRadius:(double)radius {
    _radius = radius;
    [self performRefreshIfNeeded];
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

- (void)setupBarButtonItems {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                          target:self
                                                                                          action:@selector(addPinToFavorites)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
                                                                                           target:self
                                                                                           action:@selector(openCreatePostViewController)];
    [self disableBarButtonItems];
}

- (void)enableBarButtonItems {
    self.navigationItem.leftBarButtonItem.enabled = YES;
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

- (void)disableBarButtonItems {
    self.navigationItem.leftBarButtonItem.enabled = NO;
    self.navigationItem.rightBarButtonItem.enabled = NO;
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

// ================== PinDelegate ==================

- (void)pinDidReverseGeolocate:(Pin *)pin {
    if (pin.subLocality) {
        self.navigationItem.title = pin.subLocality;
    } else if (pin.locality) {
        self.navigationItem.title = pin.locality;
    } else if (pin.subThoroughfare) {
        self.navigationItem.title = pin.subThoroughfare;
    } else if (pin.thoroughfare) {
        self.navigationItem.title = pin.thoroughfare;
    } else if (pin.subAdministrativeArea) {
        self.navigationItem.title = pin.subAdministrativeArea;
    } else if (pin.administrativeArea) {
        self.navigationItem.title = pin.administrativeArea;
    } else {
        self.navigationItem.title = pin.name;
    }
}

@end
