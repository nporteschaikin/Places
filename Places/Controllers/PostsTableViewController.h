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

@interface PostsTableViewController : UITableViewController {
    NSFetchRequest * _fetchRequest;
    NSFetchedResultsController * _fetchedResultsController;
}

- (id)initWithFetchRequest:(NSFetchRequest *)fetchRequest;

@end
