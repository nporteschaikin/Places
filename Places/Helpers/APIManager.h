//
//  APIManager.h
//  Places
//
//  Created by Noah Portes Chaikin on 9/29/14.
//  Copyright (c) 2014 Noah Portes Chaikin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIManager : NSObject

+ (APIManager *)sharedManager;
- (void)GET:(NSString *)path params:(NSDictionary *)params onComplete:(void(^)(NSURLResponse *response, NSData *data, NSError *connectionError))onComplete;
- (void)POST:(NSString *)path params:(NSDictionary *)params onComplete:(void(^)(NSURLResponse *response, NSData *data, NSError *connectionError))onComplete;

@end
