//
//  MyDayViewController.m
//  iwown
//
//  Created by Akhzar Nazir on 25/02/2014.
//  Copyright (c) 2014 Ali Asghar. All rights reserved.
//

#import "MyDayViewController.h"
#import "CalendarItem.h"
#import "PlanItem.h"
#import "CustomCellReminders.h"
#import "Globals.h"
#import "MJPopupBackgroundView.h"
#import "UIViewController+MJPopupViewController.h"
#import "CalendarViewController.h"
#import "Globals.h"

@interface MyDayViewController ()

@end

@implementation MyDayViewController

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
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedLeftButton:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedRightButton:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];

    [_weightImageView setImage:[UIImage imageNamed:@"gray_larg.png"]];
    [_stepsImageView setImage:[UIImage imageNamed:@"green_larg.png"]];
    [_reminderImageView setImage:[UIImage imageNamed:@"gray_larg.png"]];
    [self getCalendarItems];
    
    
}

-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if ([Globals sharedInstance].isPlanChangedForMyDay || [Globals sharedInstance].isNewReminderAdded || [Globals sharedInstance].isfromCalendar) {
        
        [self getCalendarItems];

    }
}


- (IBAction)tappedLeftButton:(id)sender
{
    if (_viewStepsDetai.isHidden == FALSE) {
        
        [_weightImageView setImage:[UIImage imageNamed:@"gray_larg.png"]];
        [_stepsImageView setImage:[UIImage imageNamed:@"gray_larg.png"]];
        [_reminderImageView setImage:[UIImage imageNamed:@"green_larg.png"]];
        
        [UIView beginAnimations:nil context:NULL];
        
        [UIView setAnimationDuration:0.5];
        [_viewStepsDetai setHidden:TRUE];
        [_viewWeightDetail setHidden:TRUE];
        [_ViewReminderDetail setHidden:FALSE];
        
        [UIView commitAnimations];


    } else  if (_viewWeightDetail.isHidden == FALSE) {
        
        [_weightImageView setImage:[UIImage imageNamed:@"gray_larg.png"]];
        [_stepsImageView setImage:[UIImage imageNamed:@"green_larg.png"]];
        [_reminderImageView setImage:[UIImage imageNamed:@"gray_larg.png"]];

        [_viewStepsDetai setHidden:FALSE];
        [_viewWeightDetail setHidden:TRUE];
        [_ViewReminderDetail setHidden:TRUE];
        
    }
}

- (IBAction)tappedRightButton:(id)sender
{
    
    if (_ViewReminderDetail.isHidden == FALSE) {
        
        [_weightImageView setImage:[UIImage imageNamed:@"gray_larg.png"]];
        [_stepsImageView setImage:[UIImage imageNamed:@"green_larg.png"]];
        [_reminderImageView setImage:[UIImage imageNamed:@"gray_larg.png"]];
        
        [_viewStepsDetai setHidden:FALSE];
        [_viewWeightDetail setHidden:TRUE];
        [_ViewReminderDetail setHidden:TRUE];
        
    } else  if (_viewStepsDetai.isHidden == FALSE) {
        
        [_weightImageView setImage:[UIImage imageNamed:@"green_larg.png"]];
        [_stepsImageView setImage:[UIImage imageNamed:@"gray_larg.png"]];
        [_reminderImageView setImage:[UIImage imageNamed:@"gray_larg.png"]];
        
        [_viewStepsDetai setHidden:TRUE];
        [_viewWeightDetail setHidden:FALSE];
        [_ViewReminderDetail setHidden:TRUE];
        
    }
}

-(void) setviewStrings{
    
    [_currentDateLabel setText:currentDateWithYear];

    // For Weight //
    
    [_weightAchieveLabel setText:calenderObj.workout_weight];
    [_weightTargetLabel setText:calenderObj.plan_weight];
    [_syncTimeLabel setText:calenderObj.update_date];
    
    if (([calenderObj.workout_weight integerValue] >= [calenderObj.plan_weight integerValue]) && [calenderObj.workout_weight integerValue] > 0) {
        
        [_weightGoalAchieveLabel setHidden:FALSE];
        [_weightGoalAchievImage setHidden:FALSE];
        
    }
    
    // ..........End Weight //
    
    // For Steps ///
    
    [_stepAchieveLabel setText:calenderObj.workout_stpes];
    [_stepTargetLabel setText:calenderObj.plan_steps];
    
    if (([calenderObj.workout_stpes integerValue] >= [calenderObj.plan_steps integerValue]) && [calenderObj.workout_stpes integerValue] > 0) {
        
        [_stepGoalAchieveLabel setHidden:FALSE];
        [_stepGoalAchievImage setHidden:FALSE];
        
    }

    if ((([calenderObj.workout_stpes integerValue] >= [calenderObj.plan_steps integerValue]) || ([calenderObj.workout_weight integerValue] >= [calenderObj.plan_weight integerValue])) && ([calenderObj.workout_stpes integerValue] > 0 && [calenderObj.workout_weight integerValue] > 0)){
        
        //    For PopUp Testing
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
        CalendarViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CalendarViewControllerID"];
        //    [vc.view setFrame:CGRectMake(0, 0, 320, 400)];
        [self presentPopupViewController:vc animationType:0];
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)WeightAction:(id)sender{
    
    [_weightImageView setImage:[UIImage imageNamed:@"green_larg.png"]];
    [_stepsImageView setImage:[UIImage imageNamed:@"gray_larg.png"]];
    [_reminderImageView setImage:[UIImage imageNamed:@"gray_larg.png"]];
    
    [_viewStepsDetai setHidden:TRUE];
    [_viewWeightDetail setHidden:FALSE];
    [_ViewReminderDetail setHidden:TRUE];
    
}

-(IBAction)StepsAction:(id)sender{
    
    [_weightImageView setImage:[UIImage imageNamed:@"gray_larg.png"]];
    [_stepsImageView setImage:[UIImage imageNamed:@"green_larg.png"]];
    [_reminderImageView setImage:[UIImage imageNamed:@"gray_larg.png"]];

    [_viewStepsDetai setHidden:FALSE];
    [_viewWeightDetail setHidden:TRUE];
    [_ViewReminderDetail setHidden:TRUE];

    
}

-(IBAction)ReminderAction:(id)sender{
    
    [_weightImageView setImage:[UIImage imageNamed:@"gray_larg.png"]];
    [_stepsImageView setImage:[UIImage imageNamed:@"gray_larg.png"]];
    [_reminderImageView setImage:[UIImage imageNamed:@"green_larg.png"]];
    
    [_viewStepsDetai setHidden:TRUE];
    [_viewWeightDetail setHidden:TRUE];
    [_ViewReminderDetail setHidden:FALSE];
    
}

- (void)getCalendarItems {
    
    @try{
       
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        dateFromString = [[NSDate alloc]init];
        
        if ([Globals sharedInstance].isfromCalendar) {
            
            currentDateWithYear = [Globals sharedInstance].calendarItem.date;
            currentDateis = [currentDateWithYear substringFromIndex: [currentDateWithYear length] - 2];

        }else{
            
            currentDateWithYear = [dateFormatter stringFromDate:dateFromString];
            currentDateis = [currentDateWithYear substringFromIndex: [currentDateWithYear length] - 2];
        }
        
        @autoreleasepool {
            
            [self startProgressView];
            
            NSString *params = @"date=";
            params = [params stringByAppendingString:currentDateWithYear];
            params = [params stringByAppendingString:@"&user_id="];
            params = [params stringByAppendingString:[NSString stringWithFormat:@"%@",[UserDefaultsUtil getObjectForKey:@"user_id"]]];
            [self sendPostRequestTo:@"calendar/show" withParams:params action:@selector(getCalendarItemsRequestComplete:)];
        }
    }@catch (NSException *exception) {
        NSLog(@"Exception :::: %@",[exception debugDescription]);
    }
    
}

-(void)getCalendarItemsRequestComplete:(NSData *)data{
    
    NSString *response = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *responseDict = [NSJSONSerialization
                                  JSONObjectWithData:data
                                  options:kNilOptions
                                  error:&error];
    
    if( error )
    {
        
    }else {
        
        NSDictionary *daysData = [responseDict objectForKey:@"days_data"];
        NSString *month = [responseDict objectForKey:@"month"];
        NSString *year = [responseDict objectForKey:@"year"];
        if ([currentDateis isEqualToString:@"01"]) {
            
            currentDateis = @"1";
            
        }if ([currentDateis isEqualToString:@"02"]) {
            
            currentDateis = @"2";
        
        }
        if ([currentDateis isEqualToString:@"03"]) {
        
            currentDateis = @"3";
        
        }
        if ([currentDateis isEqualToString:@"04"]) {
            
            currentDateis = @"4";
        
        }
        if ([currentDateis isEqualToString:@"05"]) {
            
            currentDateis = @"5";
        
        }
        if ([currentDateis isEqualToString:@"06"]) {
            
            currentDateis = @"6";
        
        }
        if ([currentDateis isEqualToString:@"07"]) {
            
            currentDateis = @"7";
        
        }
        if ([currentDateis isEqualToString:@"08"]) {
            
            currentDateis = @"8";
        
        }
        if ([currentDateis isEqualToString:@"09"]) {
            
            currentDateis = @"9";
        
        }
        calenderObj = nil;
        if ([[daysData objectForKey:currentDateis] isKindOfClass:[NSDictionary class]]) {
            calenderObj = [[CalendarItem alloc]initWithDict:[daysData objectForKey:currentDateis]];
        }
    }
    
    [Globals sharedInstance].isfromCalendar = FALSE;
    [self stopProgressView];
    [self getReminders];

}


- (void)getReminders{
    
    [self startProgressView];
    
    @try{
        
        @autoreleasepool {
            [self sendGETRequestTo:[NSString stringWithFormat:@"calendar/getreminder/date/%@/user_id/%@",[dateFormatter stringFromDate:dateFromString],[UserDefaultsUtil getObjectForKey:@"user_id"]] withParams:nil action:@selector(getRemindersRequestComplete:)];
        }
        
    }@catch (NSException *exception) {
        NSLog(@"Exception :::: %@",[exception debugDescription]);
    
    }
    
}

-(void)getRemindersRequestComplete:(NSData *)data{
    
    items = [[NSMutableArray alloc]init];
    NSString *response = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *responseDict = [NSJSONSerialization
                                  JSONObjectWithData:data
                                  options:kNilOptions
                                  error:&error];
    if( error )
    {
        NSLog(@"%@", [error localizedDescription]);
    }else {
        
        NSDictionary *reminders = [responseDict objectForKey:@"Plan Data"];
        item = nil;
        for (NSDictionary *reminder in reminders) {
            item = [[PlanItem alloc]init];
            [item setTime:[reminder objectForKey:@"time"]];
            [item setDesc:[reminder objectForKey:@"type"]];
            [item setReminder_id:[reminder objectForKey:@"reminder_id"]];
            [items addObject:item];
        }
        [self.reminderTableView reloadData];
    }
    
    [self stopProgressView];
    [self setviewStrings];
    
    [Globals sharedInstance].isPlanChangedForMyDay = FALSE;
    [Globals sharedInstance].isNewReminderAdded = FALSE;

}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellReminder";
    
    CustomCellReminders *cell;
    
    if([tableView respondsToSelector:@selector(dequeueReusableCellWithIdentifier:forIndexPath:)]) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    
    if (cell == nil) {
        cell = [[CustomCellReminders alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    PlanItem* obj = (PlanItem*)[items objectAtIndex:indexPath.row];
    
    cell.timeAlarm.text = obj.time;
    cell.descriptionAlarm.text = obj.desc;
//    reminder_id = obj.reminder_id;
    
    [cell.deleteAlarmButton addTarget:self action:@selector(deleteAlarmBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.deleteAlarmButton setTag:indexPath.row];
    
    tableView.backgroundColor=[UIColor clearColor];
    
    return cell;
}

-(void) deleteAlarmBtnClicked:(id)sender{
    
    PlanItem* obj = (PlanItem*)[items objectAtIndex:[sender tag]];
    [self startProgressView];
    @try{
        @autoreleasepool {
            [self sendGETRequestTo:[NSString stringWithFormat:@"clientplan/deletereminder/id/%@", obj.reminder_id] withParams:nil action:@selector(deleteRemindersRequestComplete:)];
        }
        
    }@catch (NSException *exception) {
        
        NSLog(@"Exception :::: %@",[exception debugDescription]);
        
    }
    
}

-(void)deleteRemindersRequestComplete:(NSData *)data{
    
    NSString *response = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *responseDict = [NSJSONSerialization
                                  JSONObjectWithData:data
                                  options:kNilOptions
                                  error:&error];
    if( error )
    {
        NSLog(@"%@", [error localizedDescription]);
    }else
        
    [self stopProgressView];
    [self getCalendarItems];
    
}


-(IBAction)AddReminderAction:(id)sender{
    
    [self performSegueWithIdentifier:@"SToAddReminder" sender:self];
}

// Code For Swipe View //

# pragma mark - Swipe View Data Source and Delegates

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return 3;
    
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    
    if (index == 0) {
        
        view = [[NSBundle mainBundle] loadNibNamed:@"WeightView" owner:self options:nil][0];

        
        if (!view)
        {
            
        }
        
    }else if (index == 1) {

        view = [[NSBundle mainBundle] loadNibNamed:@"StepsView" owner:self options:nil][0];
        if (!view)
        {
        }
    } else if (index == 2) {
        
        view = [[NSBundle mainBundle] loadNibNamed:@"ReminderView" owner:self options:nil][0];
        if (!view)
        {

        }
        
    }
    return view;
    
}

#pragma mark -
#pragma mark Control events

- (IBAction)ButtonOnePressed:(id)sender{
    
    [self performSegueWithIdentifier:@"SToProfileView" sender:self];
    
    
}

- (IBAction)ButtonTwoPressed:(id)sender{
    
    [self performSegueWithIdentifier:@"SToSettingView" sender:self];
    
}

- (IBAction)ButtonThreePressed:(id)sender{
    
    [self performSegueWithIdentifier:@"SToDevicesView" sender:self];
    
}

- (IBAction)pressedButton:(id)sender
{
    
}

- (IBAction)toggledSwitch:(id)sender
{
    
}

- (IBAction)changedSlider:(id)sender
{
    
}

-(IBAction)CalendarViewAction:(id)sender{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    CalendarViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CalendarViewControllerID"];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
