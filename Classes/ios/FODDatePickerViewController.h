//
//  FODDatePickerViewController.h
//  bigpicture
//
//  Created by frank on 5/26/13.
//  Copyright (c) 2013 Desirepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FODDatePickerDelegate <NSObject>
- (void) dateSelected:(NSDate*)date
             userInfo:(id)userInfo;
@end

@interface FODDatePickerViewController : UIViewController

@property (weak, nonatomic) id<FODDatePickerDelegate> delegate;

@property (strong, nonatomic) NSDate *startValue;
@property (strong, nonatomic) id userInfo;
@property (strong, nonatomic) NSArray *shortCutItems;
@property (strong, nonatomic) NSArray *shortCutDates;

@end
