//
//  Pin.m
//  Places
//
//  Created by Noah Portes Chaikin on 9/25/14.
//  Copyright (c) 2014 Noah Portes Chaikin. All rights reserved.
//

#import "Pin.h"

@interface Pin ()

@property (nonatomic, readwrite) float latitude;
@property (nonatomic, readwrite) float longitude;
@property (strong, nonatomic, readwrite) NSString *locality;
@property (strong, nonatomic, readwrite) NSString *subLocality;
@property (strong, nonatomic, readwrite) NSString *thoroughfare;
@property (strong, nonatomic, readwrite) NSString *subThoroughfare;
@property (strong, nonatomic, readwrite) NSString *administrativeArea;
@property (strong, nonatomic, readwrite) NSString *subAdministrativeArea;
@property (strong, nonatomic, readwrite) NSString *country;
@property (strong, nonatomic, readwrite) NSString *name;
@property (strong, nonatomic, readwrite) NSString *postalCode;
@property (nonatomic, readwrite) BOOL isReverseGeocoded;

@end

@implementation Pin

@synthesize delegate;
@dynamic latitude;
@dynamic longitude;
@dynamic locality;
@dynamic subLocality;
@dynamic thoroughfare;
@dynamic subThoroughfare;
@dynamic administrativeArea;
@dynamic subAdministrativeArea;
@dynamic country;
@dynamic name;
@dynamic postalCode;
@dynamic isReverseGeocoded;

+ (Pin *)findOrCreateByLocation:(CLLocation *)location
                      inContext:(NSManagedObjectContext *)managedObjectContext {
    float latitude = location.coordinate.latitude;
    float longitude = location.coordinate.longitude;
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Pin"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"%K = %f AND %K = %f", @"latitude", latitude, @"longitude", longitude];
    Pin *pin = [[managedObjectContext executeFetchRequest:fetchRequest
                                                    error:NULL] firstObject];
    if (!pin) {
        pin = (Pin *)[NSEntityDescription insertNewObjectForEntityForName:@"Pin"
                                                   inManagedObjectContext:managedObjectContext];
        pin.latitude = latitude;
        pin.longitude = longitude;
        
        [managedObjectContext insertObject:pin];
    }
    
    return pin;
}

- (id)initWithLocation:(CLLocation *)location {
    if (self = [super init]) {
        self.latitude = location.coordinate.latitude;
        self.longitude = location.coordinate.longitude;
    }
    return self;
}

- (CLLocation *)location {
    CLLocation *location = [[CLLocation alloc] initWithLatitude:self.latitude
                                                      longitude:self.longitude];
    return location;
}

- (void)reverseGeolocate {
    if (!self.isReverseGeocoded) {
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:self.location
                       completionHandler:^(NSArray *placemarks, NSError *error) {
                           CLPlacemark *placemark = [placemarks firstObject];
                           self.isReverseGeocoded = YES;
                           [self setDetailsWithPlacemark:placemark];
                           if ([self.delegate respondsToSelector:@selector(pinDidReverseGeolocate:)]) {
                               [self.delegate pinDidReverseGeolocate:self];
                           }
                       }];
    } else if ([self.delegate respondsToSelector:@selector(pinDidReverseGeolocate:)]) {
        [self.delegate pinDidReverseGeolocate:self];
    }
}

- (void)setDetailsWithPlacemark:(CLPlacemark *)placemark {
    self.locality = placemark.locality;
    self.subLocality = placemark.subLocality;
    self.thoroughfare = placemark.thoroughfare;
    self.subThoroughfare = placemark.subThoroughfare;
    self.administrativeArea = placemark.administrativeArea;
    self.subAdministrativeArea = placemark.subAdministrativeArea;
    self.country = placemark.country;
    self.name = placemark.name;
    self.postalCode = placemark.postalCode;
}
@end
