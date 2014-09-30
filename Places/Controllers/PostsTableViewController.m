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

@implementation PostsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupRefreshControl];
    
    [self.tableView registerClass:[PostTableViewCell class]
           forCellReuseIdentifier:reuseIdentifier];
    self.tableView.estimatedRowHeight = 55.0f;
}

// ================== FetchRequestTableViewController ==================

- (NSString *)entityName {
    return @"Post";
}

- (NSManagedObjectContext *)managedObjectContext {
    return [[CoreDataManager sharedManager] managedObjectContext];
}

- (NSArray *)defaultSortDescriptors {
    return @[[NSSortDescriptor sortDescriptorWithKey:@"createdAt"
                                           ascending:NO]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForObject:(Post *)post {
    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    cell.messageLabel.text = post.message;
    cell.userHandleLabel.text = @"nporteschaikin";
    cell.timeAgoLabel.text = [post.createdAt timeAgo];
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}

// ================== UIRefreshControl ==================

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

@end
