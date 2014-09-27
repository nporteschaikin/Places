//
//  HerePostsTableViewController.m
//  Places
//
//  Created by Noah Portes Chaikin on 9/27/14.
//  Copyright (c) 2014 Noah Portes Chaikin. All rights reserved.
//

#import "HerePostsTableViewController.h"

@interface HerePostsTableViewController ()

@end

@implementation HerePostsTableViewController

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

@end
