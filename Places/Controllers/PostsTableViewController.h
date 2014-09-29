//
//  PostsTableViewController.h
//  Places
//
//  Created by Noah Portes Chaikin on 9/25/14.
//  Copyright (c) 2014 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Post.h"
#import "PostImporter.h"

@interface PostsTableViewController : UITableViewController <ImporterDelegate>

@property (strong, nonatomic, readonly) NSFetchRequest *fetchRequest;
@property (strong, nonatomic, readonly) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic, readonly) PostImporter *postImporter;

- (void)reloadData;
- (void)handleRefreshControl:(id)sender;

@end
