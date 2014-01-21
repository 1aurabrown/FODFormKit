//
//  FODCellFactory.m
//  FormKitDemo
//
//  Created by Frank on 28/12/2013.
//  Copyright (c) 2013 Frank O'Dwyer. All rights reserved.
//

#import "FODCellFactory.h"

#import "FODTextInputRow.h"
#import "FODSelectionRow.h"
#import "FODDateSelectionRow.h"
#import "FODFormRow.h"
#import "FODForm.h"

#import "FODTextInputCell.h"
#import "FODSubformCell.h"
#import "FODDatePickerCell.h"
#import "FODPickerCell.h"
#import "FODExpandingSubformCell.h"

@interface FODCellFactory()

@property (weak, nonatomic) UITableView *tableView;
@property (weak, nonatomic) FODFormViewController *formViewController;

@end


@implementation FODCellFactory

- (id) initWithTableView:(UITableView*)tableView andFormViewController:(FODFormViewController *)formViewController
{
    self = [super init];
    if (self) {
        _tableView = tableView;
        _formViewController = formViewController;
        [_tableView registerNib:[self nibForCell:@"SwitchCell"] forCellReuseIdentifier:[self reuseIdentifierForCell:@"FODBooleanRow"]];
        [_tableView registerNib:[self nibForCell:@"ExpandingSubformCell"] forCellReuseIdentifier:[self reuseIdentifierForCell:@"FODExpandingSubform"]];
        [_tableView registerNib:[self nibForCell:@"InlineDatePickerCell"] forCellReuseIdentifier:[self reuseIdentifierForCell:@"FODInlineDatePicker"]];
        [_tableView registerNib:[self nibForCell:@"InlinePickerCell"] forCellReuseIdentifier:[self reuseIdentifierForCell:@"FODInlinePicker"]];
        [_tableView registerClass:self.classForSubformCell forCellReuseIdentifier:[self reuseIdentifierForCell:@"FODForm"]];
        [_tableView registerClass:self.classForDatePickerCell forCellReuseIdentifier:[self reuseIdentifierForCell:@"FODDateSelectionRow"]];
        [_tableView registerClass:self.classForPickerCell forCellReuseIdentifier:[self reuseIdentifierForCell:@"FODSelectionRow"]];
    }
    return self;
}

+ (UIColor*) editableItemColor {
    return [UIColor blueColor];
}

- (FODFormCell*) cellForRow:(FODFormRow*)row {
    FODFormCell *result = ([self.tableView dequeueReusableCellWithIdentifier:[self reuseIdentifierForRow:row]]);
    result.tableView = self.tableView;
    result.formViewController = self.formViewController;
    return result;
}

- (NSString*)reuseIdentifierForRow:(FODFormRow*)row {
    if ([row isKindOfClass:[FODTextInputRow class]]) {
        if (row.title) {
            NSString *reuseIdentifier = [self reuseIdentifierForTextInputRowWithTitle:row];
            [_tableView registerNib:[self nibForCell:@"TextInputCellWithTitle"] forCellReuseIdentifier:reuseIdentifier];
            return reuseIdentifier;
        } else {
            NSString *reuseIdentifier = [self reuseIdentifierForTextInputRowWithoutTitle:row];
            [_tableView registerNib:[self nibForCell:@"TextInputCellNoTitle"] forCellReuseIdentifier:reuseIdentifier];
            return reuseIdentifier;
        }
    }
    else if ([row isKindOfClass:[FODForm class]]) {
        FODForm *form = (FODForm*)row;
        if (form.displayInline) {
            return [self reuseIdentifierForCell:@"FODExpandingSubform"];
        } else {
            return [self reuseIdentifierForCell:@"FODForm"];
        }
    }
    else if ([row isKindOfClass:[FODDateSelectionRow class]]) {
        if (row.displayInline) {
            return [self reuseIdentifierForCell:@"FODInlineDatePicker" ];
        } else {
            return [self reuseIdentifierForCell:@"FODDateSelectionRow"];
        }
    }
    else if ([row isKindOfClass:[FODSelectionRow class]]) {
        if (row.displayInline) {
            return [self reuseIdentifierForCell:@"FODInlinePicker"];
        } else {
            return [self reuseIdentifierForCell:@"FODSelectionRow"];
        }
    }
    else {
        return [self reuseIdentifierForCell:NSStringFromClass([row class])];
    }
}

#pragma mark classes / nibs

- (Class) classForSubformCell {
    return [FODSubformCell class];
}

- (Class) classForDatePickerCell {
    return [FODDatePickerCell class];
}

- (Class) classForPickerCell {
    return [FODPickerCell class];
}

- (UINib*) nibForCell:(NSString *) cell {
    NSMutableDictionary *nibMap = [NSMutableDictionary dictionaryWithDictionary: @{
                                   @"ExpandingSubformCell"   : @"FODExpandingSubformCell",
                                   @"InlineDatePickerCell"   : @"FODInlineDatePickerCell",
                                   @"InlinePickerCell"       : @"FODInlineDatePickerCell",
                                   @"TextInputCellNoTitle"   : @"FODTextInputCell",
                                   @"TextInputCellWithTitle" : @"FODTextInputCell2",
                                   @"SwitchCell"             : @"FODSwitchCell"
                                   }];
    [nibMap addEntriesFromDictionary:[self cellToNibMap]];
    NSString *nibName = nibMap[cell];
    return [UINib nibWithNibName: nibName  bundle:nil];
}

- (NSDictionary*) cellToNibMap {
    return @{};
}

#pragma  mark reuse identifiers

- (NSString*) reuseIdentifierForCell:(NSString *) cell {
    NSMutableDictionary *identifiersMap = [NSMutableDictionary dictionaryWithDictionary: @{
                                           @"FODSelectionRow"     : @"FODPickerCell",
                                           @"FODDateSelectionRow" : @"FODDatePickerCell",
                                           @"FODForm"             : @"FODFormCell",
                                           @"FODExpandingSubform" : @"FODExpandingSubformCell",
                                           @"FODInlineDatePicker" : @"FODInlineDatePickerCell",
                                           @"FODInlinePicker"     : @"FODInlinePickerCell",
                                           @"FODBooleanRow"       : @"FODSwitchCell"
                                           }];
    [identifiersMap addEntriesFromDictionary:[self cellToReuseIdentifiersMap]];
    return identifiersMap[cell];
}

- (NSDictionary*) cellToReuseIdentifiersMap {
    return @{};
}

- (NSString*)reuseIdentifierForTextInputRowWithoutTitle:(FODFormRow*)row {
    return [NSString stringWithFormat:@"FODTextInputCell2_%@_%@", @(row.indexPath.section), @(row.indexPath.row)];
}

- (NSString*)reuseIdentifierForTextInputRowWithTitle:(FODFormRow*)row {
    return [NSString stringWithFormat:@"FODTextInputCell_%@_%@", @(row.indexPath.section), @(row.indexPath.row)];
}

@end
