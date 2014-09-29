//
//  PostTableViewCell.h
//  Places
//
//  Created by Noah Portes Chaikin on 9/25/14.
//  Copyright (c) 2014 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *userHandleLabel;
@property (strong, nonatomic) UILabel *messageLabel;
@property (strong, nonatomic) UILabel *timeAgoLabel;

@end
