//
//  PinViewController.m
//  Places
//
//  Created by Noah Portes Chaikin on 9/25/14.
//  Copyright (c) 2014 Noah Portes Chaikin. All rights reserved.
//

#import "PinViewController.h"

@interface PinViewController ()
@end

@implementation PinViewController

//- (id)initWithAndPredicate:(NSPredicate *)andPredicate
//       withSortDescriptors:(NSArray *)sortDescriptors
//    withSectionNameKeyPath:(NSString *)sectionNameKeyPath
//                    forPin:(Pin *)pin {
//    if (self = [super init]) {
//        self.andPredicate = andPredicate;
//        self.sortDescriptors = sortDescriptors;
//        self.sectionNameKeyPath = sectionNameKeyPath;
//        self.pin = pin;
//    }
//    return self;
//}
//
//- (void)setPin:(Pin *)pin {
//    self.predicate = [Post predicateForPostsWithinRadius:20 ofPin:pin];
//    if (self.andPredicate) {
//        self.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[self.predicate,
//                                                                              self.andPredicate]];
//    }
//    [self.fetchedResultsController performFetch:NULL];
//    NSLog(@"%@", self.predicate);
//    NSLog(@"%@ \n\n\n\n\n\n", self.fetchedResultsController.fetchRequest.predicate);
//    _pin = pin;
//}
//
//- (void(^)())reverseGeolocateCompletionHandler {
//    return ^(void) {
//        if (_pin.subLocality) {
//            self.navigationItem.title = _pin.subLocality;
//        } else if (_pin.locality) {
//            self.navigationItem.title = _pin.locality;
//        } else if (_pin.subThoroughfare) {
//            self.navigationItem.title = _pin.subThoroughfare;
//        } else if (_pin.thoroughfare) {
//            self.navigationItem.title = _pin.thoroughfare;
//        } else if (_pin.subAdministrativeArea) {
//            self.navigationItem.title = _pin.subAdministrativeArea;
//        } else if (_pin.administrativeArea) {
//            self.navigationItem.title = _pin.administrativeArea;
//        } else {
//            self.navigationItem.title = _pin.name;
//        }
//    };
//}

@end
