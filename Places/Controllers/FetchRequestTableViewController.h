//
//  FetchRequestTableViewController.h
//  Places
//
//  Created by Noah Portes Chaikin on 9/30/14.
//  Copyright (c) 2014 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface FetchRequestTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, readwrite) BOOL defaultPredicateDisabled;
@property (nonatomic, readwrite) BOOL defaultSortDescriptorsDisabled;

- (NSString *)entityName;
- (NSManagedObjectContext *)managedObjectContext;
- (NSArray *)defaultSortDescriptors;
- (NSPredicate *)defaultPredicate;
- (NSString *)sectionNameKeyPath;
- (NSString *)cacheName;

- (void)setPredicate:(NSPredicate *)predicate
               atKey:(NSString *)key;
- (void)removePredicateAtKey:(NSString *)key;
- (void)setSortDescriptor:(NSSortDescriptor *)sortDescriptor
                    atKey:(NSString *)key;
- (void)removeSortDescriptorAtKey:(NSString *)key;
- (void)performRefreshIfNeeded;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForObject:(id)object;

@end
