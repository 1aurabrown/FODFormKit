//
//  FODCellFactory.h
//  FormKitDemo
//
//  Created by Frank on 28/12/2013.
//  Copyright (c) 2013 Frank O'Dwyer. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FODFormRow.h"
#import "FODFormCell.h"

@interface FODCellFactory : NSObject

- (id) initWithOverridesDict:(NSDictionary *)overrides;

- (id) initWithTableView:(UITableView*)tableView
   andFormViewController:(FODFormViewController*)parentViewController;

- (FODFormCell*) cellForRow:(FODFormRow*)row;

+ (UIColor*) editableItemColor;

@property (weak, nonatomic) UITableView *tableView;
@property (weak, nonatomic) FODFormViewController *formViewController;

@end
