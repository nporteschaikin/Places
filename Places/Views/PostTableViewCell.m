//
//  PostTableViewCell.m
//  Places
//
//  Created by Noah Portes Chaikin on 9/25/14.
//  Copyright (c) 2014 Noah Portes Chaikin. All rights reserved.
//

#import "PostTableViewCell.h"

@interface PostTableViewCell ()

@property (nonatomic, readwrite) BOOL didSetupConstraints;

@end

@implementation PostTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.messageLabel];
        [self.contentView addSubview:self.userHandleLabel];
        [self.contentView addSubview:self.timeAgoLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    self.messageLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.messageLabel.bounds);
}

- (void) updateConstraints {
    if (!self.didSetupConstraints) {
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.userHandleLabel
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:17]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.timeAgoLabel
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:17]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.userHandleLabel
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1
                                                                      constant:17]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.messageLabel
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.userHandleLabel
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:5]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.messageLabel
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.userHandleLabel
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1
                                                                      constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.messageLabel
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:-17]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.timeAgoLabel
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.messageLabel
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.messageLabel
                                                                     attribute:NSLayoutAttributeBottom
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:-17]];

        
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}

- (UILabel *)userHandleLabel {
    if (!_userHandleLabel) {
        _userHandleLabel = [[UILabel alloc] init];
        _userHandleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _userHandleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
        _userHandleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _userHandleLabel.numberOfLines = 1;
    }
    return _userHandleLabel;
}

- (UILabel *)timeAgoLabel {
    if (!_timeAgoLabel) {
        _timeAgoLabel = [[UILabel alloc] init];
        _timeAgoLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _timeAgoLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
        _timeAgoLabel.textColor = [UIColor grayColor];
        _timeAgoLabel.numberOfLines = 1;
    }
    return _timeAgoLabel;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _messageLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
        _messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _messageLabel.numberOfLines = 0;
    }
    return _messageLabel;
}

@end
