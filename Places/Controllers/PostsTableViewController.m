//
//  PostsTableViewController.m
//  Places
//
//  Created by Noah Portes Chaikin on 9/25/14.
//  Copyright (c) 2014 Noah Portes Chaikin. All rights reserved.
//

#import "PostsTableViewController.h"
#import "PostTableViewCell.h"
#import "CoreDataManager.h"

static NSString * const reuseIdentifier = @"PostTableViewCell";

@interface PostsTableViewController () <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic, readwrite) NSFetchedResultsController *fetchedResultsController;

@end

@implementation PostsTableViewController

- (id)initWithFetchRequest:(NSFetchRequest *)theFetchRequest {
    if (self = [super init]) {
        _fetchRequest = theFetchRequest;
        [self setupFetchedResultsController];
    }
    return self;
}

- (void)setupFetchedResultsController {
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:_fetchRequest managedObjectContext:[CoreDataManager managedObjectContext] sectionNameKeyPath:nil cacheName:nil];
    self.fetchedResultsController.delegate = self;
    [self.fetchedResultsController performFetch:NULL];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[PostTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
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
    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    Post *post = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    [self configureCell:cell
               withPost:post];
    return cell;
}

- (void)configureCell:(PostTableViewCell *)cell
             withPost:(Post *)post {
    NSLog(@"%@", post.message);
    cell.messageLabel.text = post.message;
    cell.userHandleLabel.text = @"NPC";
}

@end
