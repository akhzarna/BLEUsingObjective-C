//
//  CalendarItemViewController.m
//  iwowen
//
//  Created by Apple on 10/12/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import "CalendarItemViewController.h"

@interface CalendarItemViewController ()

@end

@implementation CalendarItemViewController
@synthesize stepsProgressView;
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
    [stepsProgressView setFrame:CGRectMake(96, 80, 124, 15)];
    [_weightProgressView setFrame:CGRectMake(96, 152, 124, 15)];
    _headerTitle.text = _item.date;
    
    if(_item.workout_stpes != nil){
        self.actualSteps.text = _item.plan_steps;
    }
    if(_item.plan_steps != nil && [[_item.plan_steps class] isSubclassOfClass:[NSString class]]){
        self.workoutSteps.text = [NSString stringWithFormat:@"%@ Steps",_item.workout_stpes];

    }
    if(_item.workout_weight != nil && [[_item.workout_weight class] isSubclassOfClass:[NSString class]]){
        self.actualWeight.text = [NSString stringWithFormat:@"%@ KG",_item.workout_weight];
    }
    if(_item.plan_weight != nil && [[_item.plan_weight class] isSubclassOfClass:[NSString class]]){
           self.workoutWeight.text = [NSString stringWithFormat:@"%@ KG",_item.plan_weight];
    }

    stepsProgressView.progress = [_item.steps_percentage floatValue]/100;
    _weightProgressView.progress = [_item.weight_percentage floatValue]/100;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self getReminders];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addReminderBtnClicked:(id)sender {
    [self performSegueWithIdentifier:@"SToAddReminder" sender:self];
}

- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count -2] animated:YES];
}

- (void)viewDidUnload {
    
    [self setActualSteps:nil];
    [self setWorkoutSteps:nil];
    [self setWorkoutWeight:nil];
    [self setActualWeight:nil];
    [self setStepsProgressView:nil];
    [self setWeightProgressView:nil];
    [self setHeaderTitle:nil];
    [self setTableView:nil];
    [super viewDidUnload];
    
}

- (void)getReminders{
    
    @try{
        
        @autoreleasepool {
            [self startProgressView];
            //            http://iapp.beusoft.com/api/calendar/getreminder/date/2014-01-07/user_id/45
            [self sendGETRequestTo:[NSString stringWithFormat:@"calendar/getreminder/date/%@/user_id/%@",_item.date,[UserDefaultsUtil getObjectForKey:@"user_id"]] withParams:nil action:@selector(getRemindersRequestComplete:)];
        }
    }@catch (NSException *exception) {
        NSLog(@"Exception :::: %@",[exception debugDescription]);
    }
    
}

-(void)getRemindersRequestComplete:(NSData *)data{
    items = [[NSMutableArray alloc]init];
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
        //
        NSDictionary *reminders = [responseDict objectForKey:@"Plan Data"];
        PlanItem *item = nil;
        for (NSDictionary *reminder in reminders) {
            item = [[PlanItem alloc]init];
            [item setTime:[reminder objectForKey:@"time"]];
            [item setDesc:[reminder objectForKey:@"type"]];
            [items addObject:item];
        }
        [self.tableView reloadData];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    PlanItemCell *cell;
    if([tableView respondsToSelector:@selector(dequeueReusableCellWithIdentifier:forIndexPath:)]) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    
    if (cell == nil) {
        cell = [[PlanItemCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    PlanItem* obj = (PlanItem*)[items objectAtIndex:indexPath.row];
    
    cell.time.text = obj.time;
    cell.desc.text = obj.desc;
    
    tableView.backgroundColor=[UIColor clearColor];
    return cell;
}


@end
