//
//  Importer.m
//  Places
//
//  Created by Noah Portes Chaikin on 9/29/14.
//  Copyright (c) 2014 Noah Portes Chaikin. All rights reserved.
//

#import "Importer.h"

@interface Importer ()
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end

@implementation Importer

+ (NSString *)entityName {
    return nil;
}

+ (NSString *)entityPrimaryKey {
    return nil;
}

+ (NSString *)remotePrimaryKey {
    return nil;
}

+ (NSManagedObjectContext *)managedObjectContext {
    static NSManagedObjectContext *managedObjectContext;
    if (!managedObjectContext) {
        managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    }
    return managedObjectContext;
}

+ (NSArray *)managedObjectsFromEntityWherePrimaryKeyInArray:(NSArray *)array {
    NSString *eN = [[self class] entityName];
    NSString *ePK = [[self class] entityPrimaryKey];
    
    NSFetchRequest *fR = [NSFetchRequest fetchRequestWithEntityName:eN];
    fR.predicate = [NSPredicate predicateWithFormat:@"(%K IN (%@))", ePK, array];
    fR.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:ePK ascending:YES]];
    
    return [[[self class] managedObjectContext] executeFetchRequest:fR error:nil];
}

- (void)import {
    [[APIManager sharedManager] GET:self.path params:self.params onComplete:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error) {
            [self.delegate importer:self didFailToCompleteRequestWithError:error];
        } else {
            [self didCompleteRequestWithData:data];
        }
    }];
}

- (void)didCompleteRequestWithData:(NSData *)data {
    NSError *error;
    id object = [NSJSONSerialization JSONObjectWithData:data
                                                options:NSJSONReadingAllowFragments
                                                  error:&error];
    if (error) {
        [self.delegate importer:self didFailToCompleteRequestWithError:error];
    } else {
        [self didParseObject:object];
    }
}

- (void)didParseObject:(id)object {
    NSString *remotePrimaryKey = [[self class] remotePrimaryKey];
    NSDictionary *dictionary;
    NSManagedObject *existingManagedObject;
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = (NSDictionary *)object;
        NSArray *remotePrimaryKeyValue = [dictionary valueForKey:[[self class] remotePrimaryKey]];
        existingManagedObject = [[[self class] managedObjectsFromEntityWherePrimaryKeyInArray:@[remotePrimaryKeyValue]] firstObject];
        [self useOrCreateManagedObject:existingManagedObject
                        withDictionary:dictionary];
        [self.delegate importerDidCompleteSingleImport:self];
    } else if ([object isKindOfClass:[NSArray class]]) {
        NSArray *collection = (NSArray *)object;
        NSArray *remotePrimaryKeyValues = [collection valueForKey:remotePrimaryKey];
        NSArray *managedObjects = [[self class] managedObjectsFromEntityWherePrimaryKeyInArray:remotePrimaryKeyValues];
        NSString *remotePrimaryKeyValue;
        NSPredicate *managedObjectsPredicate;
        for (dictionary in collection) {
            remotePrimaryKeyValue = [dictionary valueForKey:remotePrimaryKey];
            managedObjectsPredicate = [NSPredicate predicateWithFormat:@"%K = %@", remotePrimaryKey, remotePrimaryKeyValue];
            existingManagedObject = [[managedObjects filteredArrayUsingPredicate:managedObjectsPredicate] firstObject];
            [self useOrCreateManagedObject:existingManagedObject
                            withDictionary:dictionary];
            [self.delegate importerDidCompleteCollectionImport:self];
        }
    }
    [self.delegate importerDidCompleteImport:self];
}

- (NSManagedObject *)useOrCreateManagedObject:(NSManagedObject *)managedObject
                               withDictionary:(NSDictionary *)dictionary {
    NSString *remotePrimaryKey = [[self class] remotePrimaryKey];
    NSString *entityPrimaryKey = [[self class] entityPrimaryKey];
    NSString *entityName = [[self class] entityName];
    NSManagedObjectContext *managedObjectContext = [[self class] managedObjectContext];
    if (!managedObject) {
        id remotePrimaryKeyValue = [dictionary valueForKey:remotePrimaryKey];
        managedObject = [NSEntityDescription insertNewObjectForEntityForName:entityName
                                                      inManagedObjectContext:managedObjectContext];
        [managedObject setValue:remotePrimaryKeyValue
                         forKey:entityPrimaryKey];
    }
    return managedObject;
}

@end
