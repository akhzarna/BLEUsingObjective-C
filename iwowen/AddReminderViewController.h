//
//  AddReminderViewController.h
//  iwowen
//
//  Created by Apple on 10/12/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionSheetDatePicker.h"
#import "ActionSheetStringPicker.h"
#import "NSDate+TCUtils.h"
#import "ALPickerView.h"
#import "BaseViewController.h"
#import "RNBlurModalView.h"
#import "NSDate+ADNExtensions.h"

@interface AddReminderViewController : BaseViewController <ALPickerViewDelegate>{
    
    NSMutableArray *nameOfDays;
    RNBlurModalView *modal;
    int selectedType;
    NSArray *types;
    
    NSMutableDictionary *selectionStates;
	
    NSMutableArray *repitionDays;
	ALPickerView *pickerView;
    UIView *masterView;
    NSString *selectedTime;
    
    NSDateFormatter *dateFormatStartDate;
    NSDateFormatter *dateFormatEndDate;
    NSString *noOfDaysBetween;
    
}

@property (weak, nonatomic) IBOutlet UIImageView *sundayImageView;
@property (weak, nonatomic) IBOutlet UIImageView *mondayImageView;
@property (weak, nonatomic) IBOutlet UIImageView *tuesdayImageView;
@property (weak, nonatomic) IBOutlet UIImageView *wednesdayImageView;
@property (weak, nonatomic) IBOutlet UIImageView *thursdayImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fridayImageView;
@property (weak, nonatomic) IBOutlet UIImageView *saturdayImageView;

@property (strong,nonatomic)AbstractActionSheetPicker *actionSheetPicker;
@property (strong,nonatomic)AbstractActionSheetPicker *typeActionSheetPicker;

@property (strong, nonatomic) NSMutableArray *nameOfDays;

@property (weak, nonatomic) IBOutlet UITextField *timeText;

@property (weak, nonatomic) IBOutlet UITextField *endDateText;

@property (weak, nonatomic) IBOutlet UITextField *startDateText;

@property (weak, nonatomic) IBOutlet UITextField *reminderTypeText;

@property (weak, nonatomic) IBOutlet UITextField *titleFld;
@property (weak, nonatomic) IBOutlet UILabel *startDate;
@property (weak, nonatomic) IBOutlet UILabel *endDate;

- (IBAction)startDateClicked:(id)sender;
- (IBAction)endDateClicked:(id)sender;
- (IBAction)reminderTypeBtnClicked:(id)sender;
- (IBAction)cancelBtnClicked:(id)sender;
- (IBAction)saveBtnClicked:(id)sender;
- (IBAction)backBtnclicked:(id)sender;
- (IBAction)timebtnClicked:(id)sender;
- (IBAction)repititionBtnClicked:(id)sender;

-(BOOL)isValidateFields;

@end
