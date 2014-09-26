//
//  Pin.h
//  Places
//
//  Created by Noah Portes Chaikin on 9/25/14.
//  Copyright (c) 2014 Noah Portes Chaikin. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>

@interface Pin : NSManagedObject

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

+ (Pin *)findOrCreateByLocation:(CLLocation *)location
                      inContext:(NSManagedObjectContext *)managedObjectContext;
+ (Pin *)findOrCreateByLocation:(CLLocation *)location
                      inContext:(NSManagedObjectContext *)managedObjectContext
andReverseGeolocateWithCompletionHandler:(void (^)())completionHandler;
- (void)reverseGeolocateWithCompletionHandler:(void (^)())completionHandler;

@end
