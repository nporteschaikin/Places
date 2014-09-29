//
//  PostImporter.h
//  Places
//
//  Created by Noah Portes Chaikin on 9/29/14.
//  Copyright (c) 2014 Noah Portes Chaikin. All rights reserved.
//

#import "Importer.h"
#import "Post.h"
#import "Pin.h"

@interface PostImporter : Importer

+ (void)importByPin:(Pin *)pin
             radius:(double)radius;

- (void)importByPin:(Pin *)pin
             radius:(double)radius;

@end
