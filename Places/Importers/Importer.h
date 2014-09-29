//
//  Importer.h
//  Places
//
//  Created by Noah Portes Chaikin on 9/29/14.
//  Copyright (c) 2014 Noah Portes Chaikin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataManager.h"
#import "APIManager.h"

@class Importer;

@protocol ImporterDelegate <NSObject>

@optional
- (void)importer:(Importer *)importer didFailToCompleteRequestWithError:(NSError *)error;
- (void)importer:(Importer *)importer didFailToParseObjectWithError:(NSError *)error;
- (void)importer:(Importer *)importer didUseOrCreateManagedObject:(NSManagedObject *)managedObject;
- (void)importerDidCompleteImport:(Importer *)importer;
- (void)importerDidCompleteSingleImport:(Importer *)importer;
- (void)importerDidCompleteCollectionImport:(Importer *)importer;

@end

@interface Importer : NSObject

@property (strong, nonatomic) id<ImporterDelegate> delegate;
@property (strong, nonatomic, readwrite) NSString *path;
@property (strong, nonatomic, readwrite) NSDictionary *params;

+ (NSString *)entityName;
+ (NSString *)entityPrimaryKey;
+ (NSString *)remotePrimaryKey;

- (void)import;

@end
