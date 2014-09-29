//
//  Post.m
//  Places
//
//  Created by Noah Portes Chaikin on 9/25/14.
//  Copyright (c) 2014 Noah Portes Chaikin. All rights reserved.
//

#import "Post.h"

static const double R = 6371009.; // radius of Earth in miles
static NSString * const latitudeKey = @"pin.latitude";
static NSString * const longitudeKey = @"pin.longitude";

@implementation Post

@dynamic message;
@dynamic pin;
@dynamic createdAt;

+ (NSFetchRequest *)fetchRequestForPostsWithinRadius:(double)radius
                                               ofPin:(Pin *)pin {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Post"];
    fetchRequest.predicate = [self predicateForPostsWithinRadius:radius
                                                           ofPin:pin];
    return fetchRequest;
}

+ (NSPredicate *)predicateForPostsWithinRadius:(double)radius
                                         ofPin:(Pin *)pin {
    double D = (radius * 1609.34) * 1.1;
    double meanLatitude = pin.latitude * M_PI / 180.;
    double deltaLatitude = D / R * 180. / M_PI;
    double deltaLongitude = D / (R * cos(meanLatitude)) * 180. / M_PI;
    double minLatitude = pin.latitude - deltaLatitude;
    double maxLatitude = pin.latitude + deltaLatitude;
    double minLongitude = pin.longitude - deltaLongitude;
    double maxLongitude = pin.longitude + deltaLongitude;
    
    return [NSPredicate predicateWithFormat:@"(%@ <= %K) AND (%K <= %@) AND (%@ <= %K) AND (%K <= %@)",
                @(minLongitude), longitudeKey, longitudeKey, @(maxLongitude),
                @(minLatitude), latitudeKey, latitudeKey, @(maxLatitude)];
}

- (void)awakeFromInsert {
    [super awakeFromInsert];
    self.createdAt = [NSDate date];
}

@end
