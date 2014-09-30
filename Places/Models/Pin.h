//
//  Pin.h
//  Places
//
//  Created by Noah Portes Chaikin on 9/25/14.
//  Copyright (c) 2014 Noah Portes Chaikin. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>

@class Pin;

@protocol PinDelegate <NSObject>

- (void)pinDidReverseGeolocate:(Pin *)pin;

@end

@interface Pin : NSManagedObject

@property (strong, nonatomic) id<PinDelegate> delegate;
@property (nonatomic, readonly) float latitude;
@property (nonatomic, readonly) float longitude;
@property (nonatomic, readonly) CLLocation *location;
@property (strong, nonatomic, readonly) NSString *locality;
@property (strong, nonatomic, readonly) NSString *subLocality;
@property (strong, nonatomic, readonly) NSString *thoroughfare;
@property (strong, nonatomic, readonly) NSString *subThoroughfare;
@property (strong, nonatomic, readonly) NSString *administrativeArea;
@property (strong, nonatomic, readonly) NSString *subAdministrativeArea;
@property (strong, nonatomic, readonly) NSString *country;
@property (strong, nonatomic, readonly) NSString *name;
@property (strong, nonatomic, readonly) NSString *postalCode;
@property (nonatomic, readonly) BOOL isReverseGeocoded;

+ (Pin *)findOrCreateByLocation:(CLLocation *)location
                      inContext:(NSManagedObjectContext *)managedObjectContext;
- (void)reverseGeolocate;

@end
