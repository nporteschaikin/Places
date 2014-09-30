//
//  CreatePostViewController.m
//  Places
//
//  Created by Noah Portes Chaikin on 9/28/14.
//  Copyright (c) 2014 Noah Portes Chaikin. All rights reserved.
//

#import "CreatePostViewController.h"
#import "UITextViewWithPlaceholder.h"
#import "CoreDataManager.h"
#import "Post.h"

@interface CreatePostViewController ()
@property (strong, nonatomic) UITextViewWithPlaceholder *messageTextView;
@end

@implementation CreatePostViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.messageTextView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.title = @"New Post";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(dismissViewController)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Post"
                                                                              style:UIBarButtonItemStyleDone
                                                                            target:self
                                                                            action:@selector(savePost)];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.messageTextView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.topLayoutGuide
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1
                                                           constant:17]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.messageTextView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1
                                                           constant:17]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.messageTextView
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1
                                                           constant:-17]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.messageTextView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:0.5
                                                           constant:0]];
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.messageTextView becomeFirstResponder];
}

- (UITextView *)messageTextView {
    if (!_messageTextView) {
        _messageTextView = [[UITextViewWithPlaceholder alloc] init];
        _messageTextView.translatesAutoresizingMaskIntoConstraints = NO;
        _messageTextView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        _messageTextView.placeholderLabel.text = @"Write something...";
    }
    return _messageTextView;
}

- (void)savePost {
    Post *post = (Post *)[NSEntityDescription insertNewObjectForEntityForName:@"Post"
                                                       inManagedObjectContext:[[CoreDataManager sharedManager] managedObjectContext]];
    post.pin = self.pin;
    post.message = self.messageTextView.text;
    
    self.messageTextView.text = nil;
    [self dismissViewController];
}

- (void)dismissViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
