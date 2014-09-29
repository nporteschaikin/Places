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

@property (strong, nonatomic) UINavigationController *hereNavigationController;
@property (strong, nonatomic) HerePostsTableViewController *herePostsTableViewController;

@end

@implementation MainViewController


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
        _herePostsTableViewController = [[HerePostsTableViewController alloc] initWithState];
    }
    return _herePostsTableViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViewControllers:@[self.hereNavigationController]];
}


@end
