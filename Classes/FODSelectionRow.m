//
//  FODSelectionRow.m
//  FormKitDemo
//
//  Created by Frank on 27/12/2013.
//  Copyright (c) 2013 Frank O'Dwyer. All rights reserved.
//

#import "FODSelectionRow.h"

@implementation FODSelectionRow

- (id) copyWithZone:(NSZone *)zone {
    FODSelectionRow *copy = [super copyWithZone:zone];
    copy.items = [self.items copyWithZone:zone];
    return copy;
}

@end
