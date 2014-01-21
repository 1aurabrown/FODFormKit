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
        [_tableView registerNib:[self nibForCell:@"SwitchCell"] forCellReuseIdentifier:self.reuseIdentifierForFODBooleanRow];
        [_tableView registerNib:[self nibForCell:@"ExpandingSubformCell"] forCellReuseIdentifier:self.reuseIdentifierForFODExpandingSubform];
        [_tableView registerNib:[self nibForCell:@"InlineDatePickerCell"] forCellReuseIdentifier:self.reuseIdentifierForFODInlineDatePicker];
        [_tableView registerNib:[self nibForCell:@"InlinePickerCell"] forCellReuseIdentifier:self.reuseIdentifierForFODInlinePicker];
        [_tableView registerClass:self.classForSubformCell forCellReuseIdentifier:self.reuseIdentifierForFODForm];
        [_tableView registerClass:self.classForDatePickerCell forCellReuseIdentifier:self.reuseIdentifierForFODDateSelectionRow];
        [_tableView registerClass:self.classForPickerCell forCellReuseIdentifier:self.reuseIdentifierForFODSelectionRow];
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
            return self.reuseIdentifierForFODExpandingSubform;
        } else {
            return self.reuseIdentifierForFODForm;
        }
    }
    else if ([row isKindOfClass:[FODDateSelectionRow class]]) {
        if (row.displayInline) {
            return self.reuseIdentifierForFODInlineDatePicker;
        } else {
            return self.reuseIdentifierForFODDateSelectionRow;
        }
    }
    else if ([row isKindOfClass:[FODSelectionRow class]]) {
        if (row.displayInline) {
            return self.reuseIdentifierForFODInlinePicker;
        } else {
            return self.reuseIdentifierForFODSelectionRow;
        }
    }
    else {
        NSString *className = NSStringFromClass([row class]);
        SEL selector = NSSelectorFromString([NSString stringWithFormat:@"reuseIdentifierFor%@", className]);
        IMP imp = [self methodForSelector:selector];
        NSString* (*func)(id, SEL) = (void *)imp;
        return func(self,selector);
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
    return [UINib nibWithNibName: nibMap[cell] bundle:nil];
}

- (NSDictionary*) cellToNibMap {
    return @{};
}

#pragma  mark reuse identifiers

- (NSString *)reuseIdentifierForFODSelectionRow {
    return @"FODPickerCell";
}

- (NSString *)reuseIdentifierForFODDateSelectionRow {
    return @"FODDatePickerCell";
}

- (NSString*)reuseIdentifierForFODForm {
    return @"FODFormCell";
}

- (NSString*)reuseIdentifierForFODExpandingSubform {
    return @"FODExpandingSubformCell";
}

- (NSString*)reuseIdentifierForFODInlineDatePicker {
    return @"FODInlineDatePickerCell";
}

- (NSString*)reuseIdentifierForFODInlinePicker {
    return @"FODInlinePickerCell";
}

- (NSString *)reuseIdentifierForFODBooleanRow {
    return @"FODSwitchCell";
}

- (NSString*)reuseIdentifierForTextInputRowWithoutTitle:(FODFormRow*)row {
    return [NSString stringWithFormat:@"FODTextInputCell2_%@_%@", @(row.indexPath.section), @(row.indexPath.row)];
}

- (NSString*)reuseIdentifierForTextInputRowWithTitle:(FODFormRow*)row {
    return [NSString stringWithFormat:@"FODTextInputCell_%@_%@", @(row.indexPath.section), @(row.indexPath.row)];
}

@end
