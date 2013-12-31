//
//  FODFormCell.h
//  FormKitDemo
//
//  Created by Frank on 28/12/2013.
//  Copyright (c) 2013 Frank O'Dwyer. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FODFormRow.h"
#import "FODDatePickerViewController.h"
#import "FODPickerViewController.h"

@protocol FODSwitchCellDelegate;
@protocol FODTextInputCellDelegate;

@protocol FODFormCellDelegate<FODDatePickerDelegate, FODPickerViewControllerDelegate, FODSwitchCellDelegate, FODTextInputCellDelegate>
- (void)adjustHeight:(CGFloat)newHeight forRowAtIndexPath:(NSIndexPath*)indexPath;
@end


@interface FODFormCell : UITableViewCell

@property (nonatomic,strong) FODFormRow *row;
@property (nonatomic,readonly) BOOL isEditable;
@property (nonatomic,weak) id<FODFormCellDelegate> delegate;
@property (nonatomic,weak) UITableView *tableView;

- (void) configureCellForRow:(FODFormRow*)row
                withDelegate:(id)delegate;

- (void) cellAction:(UINavigationController*)navController;

@end
