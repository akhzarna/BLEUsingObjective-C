//
//  AddReminderViewController.m
//  iwowen
//
//  Created by Apple on 10/12/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import "AddReminderViewController.h"
#import "Globals.h"

@interface AddReminderViewController ()

@end

@implementation AddReminderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView.backgroundColor = [UIColor clearColor];
    _titleFld.leftView = leftView;
    _titleFld.leftViewMode = UITextFieldViewModeAlways;
    _titleFld.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    
    [self setStartDate:nil];
    [self setStartDateText:nil];
    [self setEndDateText:nil];
    [self setEndDate:nil];
    [self setTitleFld:nil];
    [super viewDidUnload];
    
}

- (IBAction)startDateClicked:(id)sender {
    
    [self.view endEditing:YES];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateFromString = [[NSDate alloc]init];
    
    if(_startDateText.text != nil && _startDateText.text.length > 0 ){
        [dateFormatter dateFromString:[_startDateText.text componentsSeparatedByString:@" "][0]];
    }
    
    _actionSheetPicker = [[ActionSheetDatePicker alloc] initWithTitle:@"Pick Date" datePickerMode:UIDatePickerModeDate selectedDate:dateFromString target:self action:@selector(startDateWasSelected:element:) origin:sender];
    
    [self.actionSheetPicker addCustomButtonWithTitle:@"Today" value:[NSDate date]];
    [self.actionSheetPicker addCustomButtonWithTitle:@"Yesterday" value:[[NSDate date] TC_dateByAddingCalendarUnits:NSDayCalendarUnit amount:-1]];
    self.actionSheetPicker.hideCancel = YES;
    [self.actionSheetPicker showActionSheetPicker];
}

- (IBAction)endDateClicked:(id)sender {
    
        [self.view endEditing:YES];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *dateFromString = [[NSDate alloc]init];
        
        if(_endDateText.text != nil && _endDateText.text.length > 0 ){
            [dateFormatter dateFromString:[_endDateText.text componentsSeparatedByString:@" "][0]];
        }
        
        _actionSheetPicker = [[ActionSheetDatePicker alloc] initWithTitle:@"Pick Date" datePickerMode:UIDatePickerModeDate selectedDate:dateFromString target:self action:@selector(endDateWasSelected:element:) origin:sender];
    
        
        [self.actionSheetPicker addCustomButtonWithTitle:@"Today" value:[NSDate date]];
        [self.actionSheetPicker addCustomButtonWithTitle:@"Yesterday" value:[[NSDate date] TC_dateByAddingCalendarUnits:NSDayCalendarUnit amount:-1]];
        self.actionSheetPicker.hideCancel = YES;
        [self.actionSheetPicker showActionSheetPicker];
}

- (IBAction)reminderTypeBtnClicked:(id)sender {
    
    types = [[NSArray alloc]initWithObjects:@"Walking",@"Running",@"Swimming",@"Cycling",@"Snow boarding", nil];
    
    _typeActionSheetPicker = [ActionSheetStringPicker showPickerWithTitle:@"Select Gender" rows:types initialSelection:0 target:self sucessAction:@selector(typeWasSelected:element:) cancelAction:nil origin:sender];
}

- (IBAction)cancelBtnClicked:(id)sender {
    
      [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count -2] animated:YES];
}

- (IBAction)saveBtnClicked:(id)sender {
    
    [self addReminder];
    
}

- (IBAction)backBtnclicked:(id)sender {
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count -2] animated:YES];
}

- (IBAction)timebtnClicked:(id)sender {
    
    [self.view endEditing:YES];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateFromString = [[NSDate alloc]init];
    
    if(_endDateText.text != nil && _endDateText.text.length > 0 ){
        [dateFormatter dateFromString:[_endDateText.text componentsSeparatedByString:@" "][0]];
    }
    
    _actionSheetPicker = [[ActionSheetDatePicker alloc] initWithTitle:@"Pick Date" datePickerMode:UIDatePickerModeTime selectedDate:dateFromString target:self action:@selector(timeWasSelected:element:) origin:sender];
    
    
    self.actionSheetPicker.hideCancel = NO;
    [self.actionSheetPicker showActionSheetPicker];
    
}

- (IBAction)repititionBtnClicked:(id)sender {
    
    if(_startDateText.text.length <= 0 && _endDateText.text.length <= 0){
        RNBlurModalView *modal = [[RNBlurModalView alloc]initWithViewController:self title:@"Warning" message:@"Start and End date need to be picked first"];
        [modal show];
        return;
    }
    
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *startDate = [dateFormat dateFromString:_startDateText.text];
    NSDate *endDate = [dateFormat dateFromString:_endDateText.text];
    NSInteger difference = [startDate numberOfDaysUntil:endDate];
    
    if(difference >= 7){
        
        repitionDays = [[NSMutableArray alloc]initWithObjects:@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday", nil];
    }else{
        
        repitionDays = [[NSMutableArray alloc]init];
        unsigned unitFlags = NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit;
        NSCalendar *gregorian = [NSCalendar currentCalendar];
        NSDateComponents *comps = [gregorian components:unitFlags fromDate:startDate];
        for (int index = 0; index < difference; index++) {
            [repitionDays addObject:[self getWeekDayName:(comps.weekday+index)]];
        }
    }
    
    selectionStates = [[NSMutableDictionary alloc] init];
	for (NSString *key in repitionDays)
		[selectionStates setObject:[NSNumber numberWithBool:NO] forKey:key];
	
	// Init picker and add it to view
	pickerView = [[ALPickerView alloc] initWithFrame:CGRectMake(0, 44, 0, 0)];
	pickerView.delegate = self;
    
    masterView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-260, self.view.frame.size.width, 260)];
    UIToolbar *pickerToolbar = [self createPickerToolbarWithTitle:self.title];
    [pickerToolbar setBarStyle:UIBarStyleBlackTranslucent];
    [masterView addSubview:pickerToolbar];
    [masterView addSubview:pickerView];
	[self.view addSubview:masterView];
    
}

- (NSString *)getTimeStringFromDate:(NSDate *)date
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"HH:mm a"];
    NSString *result = [format stringFromDate:date];
    return result;
}

- (NSString*)getWeekDayName:(int)weekday
{
    
    NSString *name = @"KnownName";
    switch (weekday) {
        case 1:
            name = @"Sunday";
            break;
        case 2:
            name = @"Monday";
            break;
        case 3:
            name = @"Tuesday";
            break;
        case 4:
            name = @"Wednesday";
            break;
        case 5:
            name = @"Thurday";
            break;
        case 6:
            name = @"Friday";
            break;
        case 7:
            name = @"Saturday";
            break;
        default:
            break;
            
    }
    
    return name;
    
}


#pragma mark - ActionSheet Delgates

-(void)startDateWasSelected:(NSDate *)selectedDate element:(id)element {
    dateFormatStartDate = [[NSDateFormatter alloc] init];
    [dateFormatStartDate setDateFormat:@"yyyy-MM-dd"];
    _startDateText.text = [NSString stringWithFormat:@"%@",[dateFormatStartDate stringFromDate:selectedDate]];
    
}

-(void)endDateWasSelected:(NSDate *)selectedDate element:(id)element {
    
    dateFormatEndDate = [[NSDateFormatter alloc] init];
    [dateFormatEndDate setDateFormat:@"yyyy-MM-dd"];
    _endDateText.text = [NSString stringWithFormat:@"%@",[dateFormatEndDate stringFromDate:selectedDate]];
    
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *startDate = [dateFormat dateFromString:_startDateText.text];
    NSDate *endDate = [dateFormat dateFromString:_endDateText.text];
    
    NSInteger difference = [startDate numberOfDaysUntil:endDate];
    noOfDaysBetween = [NSString stringWithFormat:@"%d",difference];
    
    NSDateComponents *components;
    [dateFormat setDateFormat:@"EEEE"];
    
    if ([startDate isKindOfClass:[NSDate class]] && [startDate isKindOfClass:[NSDate class]]) {
        
        components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit fromDate:startDate toDate:endDate options:0];
        
        int days = [components day];
        nameOfDays = [[NSMutableArray alloc]init];
        for (int x = 0; x <= days; x++) {
            [nameOfDays addObject:[dateFormat stringFromDate:startDate]];
            startDate = [startDate dateByAddingTimeInterval:(60 * 60 * 24)];
        }
    }
    
    [_sundayImageView setImage:[UIImage imageNamed:@"gray_bg.png"]];
    [_mondayImageView setImage:[UIImage imageNamed:@"gray_bg.png"]];
    [_tuesdayImageView setImage:[UIImage imageNamed:@"gray_bg.png"]];
    [_wednesdayImageView setImage:[UIImage imageNamed:@"gray_bg.png"]];
    [_thursdayImageView setImage:[UIImage imageNamed:@"gray_bg.png"]];
    [_fridayImageView setImage:[UIImage imageNamed:@"gray_bg.png"]];
    [_saturdayImageView setImage:[UIImage imageNamed:@"gray_bg.png"]];

    for (int j = 0; j<[nameOfDays count]; j++) {
        
        if ([[nameOfDays objectAtIndex:j] isEqualToString:@"Sunday"]) {
            
            [_sundayImageView setImage:[UIImage imageNamed:@"green-bg.png"]];
            
        }
        if ([[nameOfDays objectAtIndex:j] isEqualToString:@"Monday"]) {
            
            [_mondayImageView setImage:[UIImage imageNamed:@"green-bg.png"]];
            
        }
        if ([[nameOfDays objectAtIndex:j] isEqualToString:@"Tuesday"]) {
            
            [_tuesdayImageView setImage:[UIImage imageNamed:@"green-bg.png"]];
            
        }
        if ([[nameOfDays objectAtIndex:j] isEqualToString:@"Wednesday"]) {
            
            [_wednesdayImageView setImage:[UIImage imageNamed:@"green-bg.png"]];
            
        }
        if ([[nameOfDays objectAtIndex:j] isEqualToString:@"Thursday"]) {
            
            [_thursdayImageView setImage:[UIImage imageNamed:@"green-bg.png"]];
            
        }
        if ([[nameOfDays objectAtIndex:j] isEqualToString:@"Friday"]) {
            
            [_fridayImageView setImage:[UIImage imageNamed:@"green-bg.png"]];
            
        }
        if ([[nameOfDays objectAtIndex:j] isEqualToString:@"Saturday"]) {
            
            [_saturdayImageView setImage:[UIImage imageNamed:@"green-bg.png"]];
            
        }

    }
    
}


-(void)timeWasSelected:(NSDate *)selectedDate element:(id)element {
    
    selectedTime = [self getTimeStringFromDate:selectedDate];
    _timeText.text = [self getTimeStringFromDate:selectedDate];

}


- (void)typeWasSelected:(NSNumber *)selectedIndex element:(id)element {
    
    selectedType = selectedIndex.intValue;
    
    _reminderTypeText.text = [types objectAtIndex:selectedType];

}

- (IBAction)actionPickerDone:(id)sender {
    
    [masterView removeFromSuperview];

}

- (IBAction)actionPickerCancel:(id)sender {
    
    [masterView removeFromSuperview];

}

- (UIToolbar *)createPickerToolbarWithTitle:(NSString *)title  {
    
    CGRect frame = CGRectMake(0, 0, self.self.view.frame.size.width, 44);
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:frame];
    pickerToolbar.barStyle = UIBarStyleBlackOpaque;
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *cancelBtn = [self createButtonWithType:UIBarButtonSystemItemCancel target:self action:@selector(actionPickerCancel:)];
    [barItems addObject:cancelBtn];
    UIBarButtonItem *flexSpace = [self createButtonWithType:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [barItems addObject:flexSpace];
    UIBarButtonItem *doneButton = [self createButtonWithType:UIBarButtonSystemItemDone target:self action:@selector(actionPickerDone:)];
    [barItems addObject:doneButton];
    [pickerToolbar setItems:barItems animated:YES];
    return pickerToolbar;
    
}

- (UIBarButtonItem *)createButtonWithType:(UIBarButtonSystemItem)type target:(id)target action:(SEL)buttonAction {
    
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:type target:target action:buttonAction];

}


#pragma mark -
#pragma mark ALPickerView delegate methods

- (NSInteger)numberOfRowsForPickerView:(ALPickerView *)pickerView {
    
	return [repitionDays count];

}

- (NSString *)pickerView:(ALPickerView *)pickerView textForRow:(NSInteger)row {
    
	return [repitionDays objectAtIndex:row];

}

- (BOOL)pickerView:(ALPickerView *)pickerView selectionStateForRow:(NSInteger)row {

	return [[selectionStates objectForKey:[repitionDays objectAtIndex:row]] boolValue];

}

- (void)pickerView:(ALPickerView *)pickerView didCheckRow:(NSInteger)row {
    
    if (row == -1)
    
    for (id key in [selectionStates allKeys])
        
        [selectionStates setObject:[NSNumber numberWithBool:YES] forKey:key];
	
    else
	
        [selectionStates setObject:[NSNumber numberWithBool:YES] forKey:[repitionDays objectAtIndex:row]];
    
}

- (void)pickerView:(ALPickerView *)pickerView didUncheckRow:(NSInteger)row {
    
	if (row == -1)
		for (id key in [selectionStates allKeys])
			[selectionStates setObject:[NSNumber numberWithBool:NO] forKey:key];
	else
		[selectionStates setObject:[NSNumber numberWithBool:NO] forKey:[repitionDays objectAtIndex:row]];

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if([textField.text length]==0){
        if([string isEqualToString:@" "]){
            return NO;
        }
    }
    return YES;
}

-(BOOL)isValidateFields{
    
    if ([_titleFld text] == nil ||[[_titleFld text] isEqualToString:@""] || [[_reminderTypeText text] isEqualToString:@""] || [[_startDateText text] isEqualToString:@""] || [[_endDateText text] isEqualToString:@""] || [[_timeText text] isEqualToString:@""]) {
        
        return FALSE;
        
    }else{
        
        return TRUE;
    }
    
}

#pragma mark - Webservice

- (void)addReminder{
    
    if ([self isValidateFields]) {
        
        [self startProgressView];
        
        NSString *days = @"";
        
        for (NSString *aKey in selectionStates) {
            if ([(NSString*)[selectionStates objectForKey:aKey] intValue] == 1) {
                if (days.length > 0) {
                    days = [days stringByAppendingFormat:@",%@",aKey];
                }else{
                    days = aKey;
                }
            }
        }
        
        @try{
            
            
            @autoreleasepool {

                NSString *params = @"title=";
                params = [params stringByAppendingString:self.titleFld.text];
                params = [params stringByAppendingString:@"&type="];
                params = [params stringByAppendingString:self.reminderTypeText.text];
                params = [params stringByAppendingString:@"&start_date="];
                params = [params stringByAppendingString:self.startDateText.text];
                params = [params stringByAppendingString:@"&end_date="];
                params = [params stringByAppendingString:self.endDateText.text];
                params = [params stringByAppendingString:@"&days="];
                params = [params stringByAppendingString:noOfDaysBetween];
                params = [params stringByAppendingString:@"&timepick="];
                params = [params stringByAppendingString:selectedTime];
                params = [params stringByAppendingString:@"&user_id="];
                params = [params stringByAppendingString:[NSString stringWithFormat:@"%@",[UserDefaultsUtil getObjectForKey:@"user_id"]]];
                
                [self sendPostRequestTo:@"clientplan/addreminder" withParams:params action:@selector(addReminderRequestComplete:)];
            }
            
        }@catch (NSException *exception) {
            NSLog(@"Exception :::: %@",[exception debugDescription]);
        }
        

        
    }else{
        
        modal = [[RNBlurModalView alloc]initWithViewController:self title:@"Warning" message:@"All fields are required."];
        [modal show];
        [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(HideAlertView) userInfo:nil repeats:NO];

        
    }
    
    
}

-(void)addReminderRequestComplete:(NSData *)data{
    
    NSString *response = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if (response.length <= 0) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count -2] animated:YES];
    }
    NSError *error;
    NSDictionary *responseDict = [NSJSONSerialization
                                  JSONObjectWithData:data
                                  options:kNilOptions
                                  error:&error];
    
    if( error )
    {
        NSLog(@"%@", [error localizedDescription]);
    }else {
        NSString *status = [responseDict objectForKey:@"status"];
        if([status isEqualToString:@"warning"]){
        }else if ([status isEqualToString:@"failure"]){
            modal = [[RNBlurModalView alloc]initWithViewController:self title:@"Warning" message:@"Please fill the required fields"];
            [modal show];
            [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(HideAlertView) userInfo:nil repeats:NO];
        }else if ([status isEqualToString:@"success"]){
            [self.navigationController popViewControllerAnimated:YES];
            [Globals sharedInstance].isNewReminderAdded = TRUE;
        }
    }
    [self stopProgressView];
    
}

-(void) HideAlertView{
    
    [modal hide];
}

#pragma mark - UITextField Delegates

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // Any additional checks to ensure you have the correct textField here.
    [textField resignFirstResponder];
    return YES;
}



@end
