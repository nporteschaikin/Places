//
//  PostImporter.m
//  Places
//
//  Created by Noah Portes Chaikin on 9/29/14.
//  Copyright (c) 2014 Noah Portes Chaikin. All rights reserved.
//

#import "PostImporter.h"

@implementation PostImporter

+ (NSString *)entityName {
    return @"Post";
}

+ (NSString *)entityPrimaryKey {
    return @"remoteID";
}

+ (NSString *)remotePrimaryKey {
    return @"id";
}

- (void)importByPin:(Pin *)pin inRadius:(double)radius {
    self.path = @"/posts/in";
    self.params = @{@"latitude": [NSNumber numberWithDouble:pin.latitude],
                    @"longitude": [NSNumber numberWithDouble:pin.longitude],
                    @"radius": [NSNumber numberWithDouble:radius]};
    [self import];
}

- (void)useOrCreateManagedObject:(NSManagedObject *)managedObject
                  withDictionary:(NSDictionary *)dictionary {
    [super useOrCreateManagedObject:managedObject
                     withDictionary:dictionary];
    Post *mappedObject = (Post *)managedObject;
    double latitude = [(NSNumber *)dictionary[@"latitude"] doubleValue];
    double longitude = [(NSNumber *)dictionary[@"longitude"] doubleValue];
    NSString *message = dictionary[@"message"];
    mappedObject.message = message;
    mappedObject.pin = [Pin findOrCreateByLocation:[[CLLocation alloc] initWithLatitude:latitude
                                                                              longitude:longitude]
                                         inContext:[[CoreDataManager sharedManager] backgroundManagedObjectContext]];
}



@end
