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

@property (strong, nonatomic, readonly) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic, readonly) NSManagedObjectContext *backgroundManagedObjectContext;

+ (CoreDataManager *)sharedManager;

@end