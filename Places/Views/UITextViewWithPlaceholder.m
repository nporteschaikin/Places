//
//  UITextViewWithPlaceholder.m
//  Places
//
//  Created by Noah Portes Chaikin on 9/28/14.
//  Copyright (c) 2014 Noah Portes Chaikin. All rights reserved.
//

#import "UITextViewWithPlaceholder.h"

@implementation UITextViewWithPlaceholder

- (id)init {
    if (self = [super init]) {
        [self addSubview:self.placeholderLabel];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textViewDidChange)
                                                     name:UITextViewTextDidChangeNotification
                                                   object:nil];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.placeholderLabel
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1
                                                          constant:1]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.placeholderLabel
                                                         attribute:NSLayoutAttributeLeft
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeLeft
                                                        multiplier:1
                                                          constant:4]];
        self.textContainerInset = UIEdgeInsetsZero;
    }
    return self;
}

- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _placeholderLabel.numberOfLines = 1;
        _placeholderLabel.textColor = [UIColor lightGrayColor];
    }
    return _placeholderLabel;
}

- (void)textViewDidChange {
    if (self.text.length) {
        self.placeholderLabel.hidden = YES;
    } else {
        self.placeholderLabel.hidden = NO;
    }
}

@end
