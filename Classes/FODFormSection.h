//
//  FODFormSection.h
//  FormKitDemo
//
//  Created by Frank on 27/12/2013.
//  Copyright (c) 2013 Frank O'Dwyer. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FODFormRow.h"

@class FODFormBuilder;

@interface FODFormSection : NSObject<NSFastEnumeration>

@property (nonatomic,copy) NSString *title;
@property (nonatomic,readonly) NSArray *rows;

- (id)initWithForm:(FODForm*)form;

- (id) objectAtIndexedSubscript:(NSInteger)index;

- (NSUInteger) numberOfRows;

- (void) addRow:(FODFormRow*)row;
- (void) insertRow:(FODFormRow*)row atIndex:(NSUInteger)index;
- (void) removeRowsInArray:(NSArray*)rows;

// serializes to a property list format (array or dictionary)
- (id) toPlist;

// constructs from an in memory plist
+ (FODFormSection*) fromPlist:(id)plist
                  withBuilder:(FODFormBuilder*)builder;

@end

