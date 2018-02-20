//
//  CalendarViewController.m
//  iwowen
//
//  Created by Apple on 22/11/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import "CalendarViewController.h"
#import "Globals.h"
#import "MJPopupBackgroundView.h"
#import "UIViewController+MJPopupViewController.h"

@interface CalendarViewController ()

@end

@implementation CalendarViewController

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
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getCalendarItems];
}

-(void)loadCalendar{
    
    [calendar removeFromSuperview];
    calendar = [ITTCalendarView viewFromNib];
    ITTBaseDataSourceImp *dataSource = [[ITTBaseDataSourceImp alloc] init];
    calendar.date = [NSDate dateWithTimeIntervalSinceNow:2*24*60*60];
    calendar.dataSource = dataSource;
    calendar.delegate = self;
    calendar.frame = CGRectMake(0, 0, 320, self.calendarView.frame.size.height);
    calendar.allowsMultipleSelection = TRUE;
    [calendar setselectedDayDictionary:datesDict];
    [calendar showInView:self.calendarView];
    
}

- (ITTCalendarGridView*)dequeueCalendarGridViewWithIdentifier:(NSString*)identifier{
    
}

- (void)calendarViewDidSelectDay:(ITTCalendarView*)calendarView calDay:(ITTCalDay*)calDay{
    if (calDay.isToday) {
    }
    NSString *key = @"";
    if([calDay getDay] < 10){
        if ([calDay getMonth] < 10) {
            key = [NSString stringWithFormat:@"%i0%i0%i",[calDay getYear],[calDay getMonth], [calDay getDay]];
        }else{
            key = [NSString stringWithFormat:@"%i%i0%i",[calDay getYear],[calDay getMonth], [calDay getDay]];
        }
    }else{
        if ([calDay getMonth] < 10) {
            key = [NSString stringWithFormat:@"%i0%i%i",[calDay getYear],[calDay getMonth], [calDay getDay]];
        }else{
            key = [NSString stringWithFormat:@"%i%i%i",[calDay getYear],[calDay getMonth], [calDay getDay]];
        }
    }
    selectedItem = [calendarItemsDict objectForKey:key];
    if(selectedItem != nil){
        [Globals sharedInstance].calendarItem = selectedItem;
        [Globals sharedInstance].isfromCalendar = TRUE;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)settingsBtnClicked:(id)sender {
    
    [self performSegueWithIdentifier:@"SToSettings" sender:self];
    
}

- (IBAction)planBtnClicked:(id)sender {
    
    [self performSegueWithIdentifier:@"SToPlan" sender:self];
    
}

- (void)viewDidUnload {
    [self setCalendarView:nil];
    [self setRemindersTV:nil];
    [super viewDidUnload];
}

#pragma mark- webservice

- (void)getCalendarItems {
    
    @try{
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM"];
        NSDate *dateFromString = [[NSDate alloc]init];
        NSLog(@"%@",[dateFormatter stringFromDate:dateFromString]);
        
        @autoreleasepool {
            [self startProgressView];
            NSString *params = @"date=";
            params = [params stringByAppendingString:[dateFormatter stringFromDate:dateFromString]];
            params = [params stringByAppendingString:@"&user_id="];
            params = [params stringByAppendingString:[NSString stringWithFormat:@"%@",[UserDefaultsUtil getObjectForKey:@"user_id"]]];
            [self sendPostRequestTo:@"calendar/show" withParams:params action:@selector(getCalendarItemsRequestComplete:)];
        }
    }@catch (NSException *exception) {
        NSLog(@"Exception :::: %@",[exception debugDescription]);
    }
    
}

-(void)getCalendarItemsRequestComplete:(NSData *)data{
    
    datesDict = [[NSMutableDictionary alloc]init];
    calendarItemsDict = [[NSMutableDictionary alloc]init];
    NSString *response = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    [self stopProgressView];
    NSError *error;
    NSDictionary *responseDict = [NSJSONSerialization
                                  JSONObjectWithData:data
                                  options:kNilOptions
                                  error:&error];
    if( error )
    {
        NSLog(@"%@", [error localizedDescription]);
        
    }else {
        
        [Globals sharedInstance].CalendarDataForStepsWeights = [responseDict objectForKey:@"days_data"];
        NSDictionary *daysData = [responseDict objectForKey:@"days_data"];
        NSString *year = [responseDict objectForKey:@"year"];
        NSString *month = [responseDict objectForKey:@"month"];
        
        CalendarItem *obj = nil;
        
        for (int index = 1 ; index < 31 ; index++) {
            if([[[daysData objectForKey:[NSString stringWithFormat:@"%i",index]] class] isSubclassOfClass:[NSDictionary class]]){
                NSDictionary *plan = [daysData objectForKey:[NSString stringWithFormat:@"%i",index]];
                obj = [[CalendarItem alloc]initWithDict:plan];
                if (index < 10) {
                    [datesDict setObject:@"1" forKey:[NSString stringWithFormat:@"%@%@0%i",year,month,index]];
                    obj.date = [NSString stringWithFormat:@"%@-%@-0%i",year,month,index];
                    [calendarItemsDict setObject:obj forKey:[NSString stringWithFormat:@"%@%@0%i",year,month,index]];
                }else{
                    [datesDict setObject:@"1" forKey:[NSString stringWithFormat:@"%@%@%i",year,month,index]];
                    obj.date = [NSString stringWithFormat:@"%@-%@-%i",year,month,index];
                    [calendarItemsDict setObject:obj forKey:[NSString stringWithFormat:@"%@%@%i",year,month,index]];
                }
            }
            
        }
    }
    [self loadCalendar];
}

- (void)getReminders{
    
    [self startProgressView];
    @try{
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *dateFromString = [[NSDate alloc]init];
        @autoreleasepool {
            [self sendGETRequestTo:[NSString stringWithFormat:@"calendar/getreminder/date/%@/user_id/%@",[dateFormatter stringFromDate:dateFromString],[UserDefaultsUtil getObjectForKey:@"user_id"]] withParams:nil action:@selector(getRemindersRequestComplete:)];
        }
        
    }@catch (NSException *exception) {
        NSLog(@"Exception :::: %@",[exception debugDescription]);
        
    }
    
}

-(void)getRemindersRequestComplete:(NSData *)data{
    [self stopProgressView];
    NSString *response = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *responseDict = [NSJSONSerialization
                                  JSONObjectWithData:data
                                  options:kNilOptions
                                  error:&error];
    if( error )
    {
    }else {
        NSDictionary *reminders = [responseDict objectForKey:@"Plan Data"];
        NSString *reminderString = @"";
        for (NSDictionary *reminder in reminders) {
            reminderString = [reminderString stringByAppendingFormat:@"%@ at %@ \n",[reminder objectForKey:@"type"],[reminder objectForKey:@"time"]];
        }
        _remindersTV.text = reminderString;
    }
        [self getCurrentPlan];
}


- (void)getCurrentPlan{
    
    @try{
        @autoreleasepool {
            [self startProgressView];
            [self sendGETRequestTo:[NSString stringWithFormat:@"clientplan/userCurrentPlanbyId/user_id/%@",[UserDefaultsUtil getObjectForKey:@"user_id"]] withParams:nil action:@selector(getCurrentPlanRequestComplete:)];
        }
    }@catch (NSException *exception) {
        NSLog(@"Exception :::: %@",[exception debugDescription]);
    }
    
}

-(void)getCurrentPlanRequestComplete:(NSData *)data{
    
    NSString *response = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    [self stopProgressView];
    NSError *error;
    NSDictionary *responseDict = [NSJSONSerialization
                                  JSONObjectWithData:data
                                  options:kNilOptions
                                  error:&error];
    
    if( error )
    {
    }else {
        //
        NSDictionary *currentPlan = [responseDict objectForKey:@"Current Plan"];
        if (currentPlan != nil) {
            [UserDefaultsUtil setObject:[currentPlan objectForKey:@"plan_id"] forKey:ADOPTED_PLAN_KEY];
        };
    }
}


-(IBAction)BackAction:(id)sende{    
    [self dismissPopupViewControllerWithanimationType:0];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
