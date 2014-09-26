//
//  CoreDataManager.h
//  Places
//
//  Created by Noah Portes Chaikin on 9/25/14.
//  Copyright (c) 2014 Noah Portes Chaikin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

+ (NSManagedObjectContext *)managedObjectContext;

+ (NSManagedObjectContext *)backgroundManagedObjectContext;

+ (NSFetchRequest *)fetchRequestFromEntityByName:(NSString *)table
                                       batchSize:(NSInteger)batchSize;

+ (NSFetchRequest *)fetchRequestFromEntityByName:(NSString *)table
                              matchedByPredicate:(NSPredicate *)predicate
                                       batchSize:(NSInteger)batchSize;

+ (NSFetchRequest *)fetchRequestFromEntityByName:(NSString *)table
                             withSortDescriptors:(NSArray *)sortDescriptors
                                       batchSize:(NSInteger)batchSize;

+ (NSFetchRequest *)fetchRequestFromEntityByName:(NSString *)table
                              matchedByPredicate:(NSPredicate *)predicate
                             withSortDescriptors:(NSArray *)sortDescriptors
                                       batchSize:(NSInteger)batchSize;

+ (NSArray *)fetchFromEntityByName:(NSString *)table
                matchedByPredicate:(NSPredicate *)predicate
               withSortDescriptors:(NSArray *)sortDescriptors
                         inContext:(NSManagedObjectContext *)context
                         batchSize:(NSInteger)batchSize;

+ (NSArray *)fetchFromEntityByName:(NSString *)table
                matchedByPredicate:(NSPredicate *)predicate
               withSortDescriptors:(NSArray *)sortDescriptors
                         batchSize:(NSInteger)batchSize;

+ (NSManagedObject *)newObjectInEntityByName:(NSString *)table
                                   inContext:(NSManagedObjectContext *)context;

+ (NSManagedObject *)newObjectInEntityByName:(NSString *)table;

+ (NSManagedObject *)newObjectInEntityByName:(NSString *)table
                                  withValues:(NSDictionary *)values
                                   inContext:(NSManagedObjectContext *)context;

+ (NSManagedObject *)newObjectInEntityByName:(NSString *)table
                                  withValues:(NSDictionary *)values;

+ (NSError *) saveContext:(NSManagedObjectContext *)context;

+ (NSError *) saveContext;

@end