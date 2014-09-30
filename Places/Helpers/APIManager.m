//
//  APIManager.m
//  Places
//
//  Created by Noah Portes Chaikin on 9/29/14.
//  Copyright (c) 2014 Noah Portes Chaikin. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "APIManager.h"

// static NSString * const API_BASE_URL = @"http://places-api.herokuapp.com";
static NSString * const API_BASE_URL = @"http://localhost:3000";

@interface APIManager () {
    NSOperationQueue *operationQueue;
}
@end

@implementation APIManager

+ (APIManager *)sharedManager {
    static APIManager *sharedManager;
    if (!sharedManager) {
        sharedManager = [[self alloc] init];
    }
    return sharedManager;
}

- (id)init {
    if (self = [super init]) {
        operationQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

- (void)GET:(NSString *)path params:(NSDictionary *)params onComplete:(void(^)(NSURLResponse *response, NSData *data, NSError *connectionError))onComplete {
    NSURLRequest *request = [self getRequestWithPath:path
                                              params:params];
    [self sendRequest:request
           onComplete:onComplete];
}

- (void)POST:(NSString *)path params:(NSDictionary *)params onComplete:(void(^)(NSURLResponse *response, NSData *data, NSError *connectionError))onComplete {
    NSURLRequest *request = [self postRequestWithPath:path
                                               params:params];
    [self sendRequest:request
           onComplete:onComplete];
}

- (void)sendRequest:(NSURLRequest *)request onComplete:(void(^)(NSURLResponse *response, NSData *data, NSError *connectionError))onComplete {
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:operationQueue
                           completionHandler:onComplete];
}

- (NSURLRequest *)getRequestWithPath:(NSString *)path params:(NSDictionary *)params {
    NSURL *url = [self urlWithPath:path
                            params:params];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"GET";
    return request;
}

- (NSURLRequest *)postRequestWithPath:(NSString *)path params:(NSDictionary *)params {
    NSURL *url = [self urlWithPath:path];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"POST";
    request.HTTPBody = [self dataWithParams:params];
    return request;
}

- (NSURL *)urlWithPath:(NSString *)path {
    NSURL *baseURL = [NSURL URLWithString:API_BASE_URL];
    return [NSURL URLWithString:path relativeToURL:baseURL];
}

- (NSURL *)urlWithPath:(NSString *)path params:(NSDictionary *)params {
    NSURL *url = [self urlWithPath:path];
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:url
                                               resolvingAgainstBaseURL:YES];
    if (!(params.count == 0)) {
        components.percentEncodedQuery = [self paramsStringFromDictionary:params];
    }
    return [components URL];
}

- (NSData *)dataWithParams:(NSDictionary *)params {
    NSString *paramsString = [self paramsStringFromDictionary:params];
    return [paramsString dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)paramsStringFromDictionary:(NSDictionary *)dictionary {
    NSMutableArray *keyValues = [NSMutableArray array];
    NSString *value;
    for (NSString *key in dictionary) {
        value = [NSString stringWithFormat:@"%@", [dictionary valueForKey:key]];
        [keyValues addObject:[NSString stringWithFormat:@"%@=%@", key, value]];
    }
    return [keyValues componentsJoinedByString:@"&"];
}

@end
