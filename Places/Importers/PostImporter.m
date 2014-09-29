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

- (id)init {
    if (self = [super init]) {
        self.path = @"posts";
    }
    return self;
}

- (void)importByPin:(Pin *)pin
             radius:(double)radius {
    self.params = @{@"latitude": [NSNumber numberWithDouble:pin.latitude],
                    @"longitude": [NSNumber numberWithDouble:pin.longitude],
                    @"longitude": [NSNumber numberWithDouble:radius]};
    [self import];
}

@end
