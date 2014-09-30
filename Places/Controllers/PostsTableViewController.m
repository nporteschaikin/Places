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
#import "NSDate+TimeAgo.h"

static NSString * const reuseIdentifier = @"PostTableViewCell";

@interface PostsTableViewController () <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic, readwrite) NSFetchRequest *fetchRequest;
@property (strong, nonatomic, readwrite) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic, readwrite) PostImporter *postImporter;

@end

@implementation PostsTableViewController


- (NSFetchRequest *)fetchRequest {
    if (!_fetchRequest) {
        _fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Post"];
        _fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"createdAt"
                                                                        ascending:NO]];
    }
    return _fetchRequest;
}

- (NSFetchedResultsController *)fetchedResultsController {
    if (!_fetchedResultsController) {
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:self.fetchRequest
                                                                        managedObjectContext:[[CoreDataManager sharedManager] managedObjectContext]
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
        _fetchedResultsController.delegate = self;
        [_fetchedResultsController performFetch:NULL];
    }
    return _fetchedResultsController;
}

- (PostImporter *)postImporter {
    if (!_postImporter) {
        _postImporter = [[PostImporter alloc] init];
        _postImporter.delegate = self;
    }
    return _postImporter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRefreshControl];
    
    [self.tableView registerClass:[PostTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    self.tableView.estimatedRowHeight = 55.0f;
}

- (void)reloadData {
    self.fetchedResultsController = nil;
    [self.tableView reloadData];
}

- (void)setupRefreshControl {
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self
                       action:@selector(handleRefreshControl:)
             forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
}

- (void)handleRefreshControl:(id)sender {
    [(UIRefreshControl *)sender endRefreshing];
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
    
    [self configureCell:cell withPost:post];
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}

- (void)configureCell:(PostTableViewCell *)cell withPost:(Post *)post {
    cell.messageLabel.text = post.message;
    cell.userHandleLabel.text = @"nporteschaikin";
    cell.timeAgoLabel.text = [post.createdAt timeAgo];
}

@end
