//
//  FetchRequestTableViewController.m
//  Places
//
//  Created by Noah Portes Chaikin on 9/30/14.
//  Copyright (c) 2014 Noah Portes Chaikin. All rights reserved.
//

#import "FetchRequestTableViewController.h"

@interface FetchRequestTableViewController ()

@property (strong, nonatomic, readwrite) NSFetchedResultsController *fetchedResultsController;

@property (strong, nonatomic, readwrite) NSMutableDictionary *predicates;
@property (strong, nonatomic, readwrite) NSMutableDictionary *sortDescriptors;

@property (nonatomic, readwrite) BOOL fetchedResultsControllerHasPerformedFetch;

@end

@implementation FetchRequestTableViewController

- (NSString *)entityName {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (NSManagedObjectContext *)managedObjectContext {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (NSPredicate *)defaultPredicate {
    return nil;
}

- (NSArray *)defaultSortDescriptors {
    return nil;
}

- (NSString *)sectionNameKeyPath {
    return nil;
}

- (NSString *)cacheName {
    return nil;
}

- (NSMutableDictionary *)predicates {
    if (!_predicates) {
        _predicates = [NSMutableDictionary dictionary];
    }
    return _predicates;
}

- (NSMutableDictionary *)sortDescriptors {
    if (!_sortDescriptors) {
        _sortDescriptors = [NSMutableDictionary dictionary];
    }
    return _sortDescriptors;
}

- (void)setDefaultPredicateDisabled:(BOOL)defaultPredicateDisabled {
    _defaultPredicateDisabled = defaultPredicateDisabled;
}

- (void)setDefaultSortDescriptorsDisabled:(BOOL)defaultSortDescriptorsDisabled {
    _defaultSortDescriptorsDisabled = defaultSortDescriptorsDisabled;
}

- (NSFetchRequest *)fetchRequest {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self entityName]];
    fetchRequest.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:[self predicatesArray]];
    fetchRequest.sortDescriptors = [self sortDescriptorsArray];
    return fetchRequest;
}

- (NSFetchedResultsController *)fetchedResultsController {
    if (!_fetchedResultsController) {
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:self.fetchRequest
                                                                        managedObjectContext:[self managedObjectContext]
                                                                          sectionNameKeyPath:[self sectionNameKeyPath]
                                                                                   cacheName:[self cacheName]];
        
        _fetchedResultsController.delegate = self;
        [_fetchedResultsController performFetch:NULL];
    }
    return _fetchedResultsController;
}

- (void)setPredicate:(NSPredicate *)predicate
               atKey:(NSString *)key {
    [self.predicates setObject:predicate
                        forKey:key];
    [self performRefreshIfNeeded];
}

- (void)removePredicateAtKey:(NSString *)key {
    [self.predicates removeObjectForKey:key];
    [self performRefreshIfNeeded];
}

- (void)setSortDescriptor:(NSSortDescriptor *)sortDescriptor
                    atKey:(NSString *)key {
    [self.sortDescriptors setObject:sortDescriptor
                             forKey:key];
    [self performRefreshIfNeeded];
}

- (void)removeSortDescriptorAtKey:(NSString *)key {
    [self.predicates removeObjectForKey:key];
    [self performRefreshIfNeeded];
}

- (NSArray *)predicatesArray {
    NSMutableArray *predicatesArray = [NSMutableArray arrayWithObject:[self defaultPredicate]];
    [predicatesArray addObjectsFromArray:[self.predicates allValues]];
    return predicatesArray;
}

- (NSArray *)sortDescriptorsArray {
    NSMutableArray *sortDescriptorsArray = [NSMutableArray arrayWithArray:[self defaultSortDescriptors]];
    [sortDescriptorsArray addObjectsFromArray:[self.sortDescriptors allValues]];
    return sortDescriptorsArray;
}

- (void)performRefreshIfNeeded {
    self.fetchedResultsController = nil;
    if ([self fetchedResultsControllerHasPerformedFetch]) {
        [self.tableView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.fetchedResultsController performFetch:NULL];
    self.fetchedResultsControllerHasPerformedFetch = YES;
}

// ================== NSFetchedResultsControllerDelegate ==================

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath]
                                  withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeMove:
            [self.tableView moveRowAtIndexPath:indexPath
                                   toIndexPath:newIndexPath];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                                  withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:@[indexPath]
                                  withRowAnimation:UITableViewRowAnimationNone];
            break;
    }
}

// ================== UITableViewDataSource ==================

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)index {
    id<NSFetchedResultsSectionInfo> section = self.fetchedResultsController.sections[index];
    return section.numberOfObjects;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    return [self tableView:tableView cellForObject:object];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForObject:(id)object {
    return nil;
}

@end

