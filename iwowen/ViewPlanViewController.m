//
//  ViewPlanViewController.m
//  iwowen
//
//  Created by Apple on 27/11/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import "ViewPlanViewController.h"
#import "MyPlanCell.h"
#import "AsyncImageView.h"
#import "Globals.h"

@interface ViewPlanViewController ()

@end

@implementation ViewPlanViewController

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
    
    self.pTitle.text = _plan.title;
    self.image.image = [UIImage imageWithData:_plan.imageData];
    self.startDate.text = _plan.start_date;
    self.endDate.text = _plan.end_date;
    self.steps.text = _plan.steps;
    self.weight.text = _plan.weight;

    [self getCurrentPlan];
}

-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if ([Globals sharedInstance].isPlanChanged) {
        
        [self getCurrentPlan];
        
    }
    
}

- (void)getCurrentPlan{
    
    
    @try{
        @autoreleasepool {
            
            [self startProgressView];
            
            NSString *strForRequest = [NSString stringWithFormat:@"clientplan/userCurrentPlanbyId/user_id/%@",[UserDefaultsUtil getObjectForKey:@"user_id"]];
            
            NSLog(@"Current Plan Request %@",strForRequest);
            
            [self sendGETRequestTo:strForRequest withParams:nil action:@selector(getCurrentPlanRequestComplete:)];
        }
        
    }@catch (NSException *exception) {
        
        NSLog(@"Exception :::: %@",[exception debugDescription]);
        
    }
    
}

-(void)getCurrentPlanRequestComplete:(NSData *)data{
    
    NSString *response = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Response = %@",response);
    
    NSError *error;
    NSDictionary *responseDict = [NSJSONSerialization
                                  JSONObjectWithData:data
                                  options:kNilOptions
                                  error:&error];
    
    NSLog(@"Current plan Response Dict = %@",responseDict);

    
    if( error )
    {
        NSLog(@"%@", [error localizedDescription]);
    }else {
        //
        currentPlan = [responseDict objectForKey:@"Current Plan"];
        
        NSLog(@"Current Plan is = %@",currentPlan);
        NSLog(@"Current Plan ID is = %@",[currentPlan objectForKey:@"plan_id"]);
        
        if (currentPlan != nil) {
            [UserDefaultsUtil setObject:[currentPlan objectForKey:@"plan_id"] forKey:ADOPTED_PLAN_KEY];
        };
    }
    
    NSLog(@"UserDefaultValue is = %@",[UserDefaultsUtil getObjectForKey:@"plan_id"]);
    
    [self stopProgressView];

    [self getUserPlanDetail];
    
//    [self setViewStrings];
    
}


/// user Current Plan and Plan Detail Service Showing Same Data..

-(void) getUserPlanDetail{
    
//    clientplan/getsingleplans/id/203/user_id/45
    @try{
        @autoreleasepool {
            
            [self startProgressView];
            
            NSString *strForRequest = [NSString stringWithFormat:@"clientplan/getsingleplans/id/%@/user_id/%@",[currentPlan objectForKey:@"plan_id"],[UserDefaultsUtil getObjectForKey:@"user_id"]];
            
            NSLog(@"Current Plan Request %@",strForRequest);
            
            [self sendGETRequestTo:strForRequest withParams:nil action:@selector(getCurrentPlanDetailRequestComplete:)];
        }
        
    }@catch (NSException *exception) {
        
        NSLog(@"Exception :::: %@",[exception debugDescription]);
        
    }

    
}

-(void) getCurrentPlanDetailRequestComplete:(NSData *)data{
    
    NSString *response = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Risponse = %@",response);
    
    [self stopProgressView];
    
    NSError *error;
    NSDictionary *responseDict = [NSJSONSerialization
                                  JSONObjectWithData:data
                                  options:kNilOptions
                                  error:&error];
   
    NSLog(@"Current Plan Detail response Dict is = %@",responseDict);

    
    if( error )
    {
        NSLog(@"%@", [error localizedDescription]);
    }else {
        //
        
        currentPlanDetail = [responseDict objectForKey:@"Plan Data"];
        NSLog(@"Current Plan Detail is = %@",currentPlanDetail);
        NSLog(@"Current Plan Detail Actula Steps = %@",[currentPlanDetail objectForKey:@"actual_steps"]);
        NSLog(@"Current Plan Detail Actual Weight = %@",[currentPlanDetail objectForKey:@"actual_weight"]);

        if (currentPlan != nil) {
            [UserDefaultsUtil setObject:[currentPlan objectForKey:@"plan_id"] forKey:ADOPTED_PLAN_KEY];
        };
    }
    
    [Globals sharedInstance].isPlanChanged = FALSE;

    [self performSelectorOnMainThread:@selector(setViewStrings) withObject:nil waitUntilDone:YES];
//    [self setViewStrings];
    
}

-(void) setViewStrings{
    
   
    NSString *strForImage = [NSString stringWithFormat:@"%@%@",CLIENT_PLAN_IMAGE_PATH,[currentPlan objectForKey:@"image"]];    
    [self.profileImage  setImageURL:[NSURL URLWithString:strForImage]];
    
    [_planTitleLabel setText:[currentPlan objectForKey:@"title"]];
    [_fromDateLabel setText:[currentPlan objectForKey:@"start_date"]];
    [_toDatelabel setText:[currentPlan objectForKey:@"end_date"]];
    [_weightLabel setText:[currentPlan objectForKey:@"weight"]];
    [_stepsLabel setText:[currentPlan objectForKey:@"steps"]];
    
    UIColor *customColor= [UIColor colorWithRed:(0/255.0) green:(153/255.0) blue:(0/255.0) alpha:1];
    
    [_stepsProgressView setTintColor:customColor];
    [_weightProgressView setTintColor:customColor];

    
    [_stepsProgressView setFrame:CGRectMake(93, 24, 160, 10)];
    [_weightProgressView setFrame:CGRectMake(93, 80, 160, 10)];
    
    if ([[currentPlanDetail objectForKey:@"actual_steps"] isKindOfClass:[NSNull class]]) {
        [_stepsAchievedLabel setText:@"0"];

    }else{
        
        [_stepsAchievedLabel setText:[NSString stringWithFormat:@"%d",[[currentPlanDetail objectForKey:@"actual_steps"] integerValue]]];

        dispatch_async(dispatch_get_main_queue(), ^{
            
            [_stepsProgressView setProgress:((float)[[currentPlanDetail objectForKey:@"actual_steps"] integerValue] / (float)[[currentPlan objectForKey:@"steps"] integerValue]) animated:YES];

        });
        [_stepsProgressView reloadInputViews];
        
    }
    if ([[currentPlanDetail objectForKey:@"actual_weight"] isKindOfClass:[NSNull class]]) {
        
        [_weightAchievedLabel setText:@"0"];

        
    }else{
        [_weightAchievedLabel setText:[NSString stringWithFormat:@"%d",[[currentPlanDetail objectForKey:@"actual_weight"] integerValue]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_weightProgressView setProgress:((float) [[currentPlanDetail objectForKey:@"actual_weight"] integerValue] / (float)[[currentPlan objectForKey:@"weight"] integerValue]) animated:YES];
        });
        [_weightProgressView reloadInputViews];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return 8;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MyPanCellID";
    
    MyPlanCell *cell;
    
    cell = [[MyPlanCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];

    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setImage:nil];
    [self setTitle:nil];
    [self setStartDate:nil];
    [self setEndDate:nil];
    [self setSteps:nil];
    [self setWeight:nil];
    [super viewDidUnload];
}

- (IBAction)backBtnClicked:(id)sender {
      [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count -2] animated:YES];
}

- (IBAction)ChangePlanAction:(id)sender{
    
    [self performSegueWithIdentifier:@"SToPlanList" sender:self];

}

@end
