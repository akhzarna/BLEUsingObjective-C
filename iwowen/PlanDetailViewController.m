//
//  PlanDetailViewController.m
//  iwown
//
//  Created by Akhzar Nazir on 27/02/2014.
//  Copyright (c) 2014 Ali Asghar. All rights reserved.
//

#import "PlanDetailViewController.h"
#import "BaseViewController.h"
#import "RNBlurModalView.h"
#import "AsyncImageView.h"
#import "Globals.h"

@interface PlanDetailViewController ()

@end

@implementation PlanDetailViewController
@synthesize plan;

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

-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self setViewStrings];
}

-(void) setViewStrings{
    
    NSString *strForImage = [NSString stringWithFormat:@"%@%@",CLIENT_PLAN_IMAGE_PATH,plan.image];
    [self.profileImage  setImageURL:[NSURL URLWithString:strForImage]];
    [_titleLabel setText:plan.title];
    [_detailLable setText:plan.description];
    [_fromDateLabel setText:plan.start_date];
    [_toDateLabel setText:plan.end_date];
    [_stepsLabel setText:plan.steps];
    [_weightLabel setText:plan.weight];
    
    if ([UserDefaultsUtil getObjectForKey:ADOPTED_PLAN_KEY] != nil && [(NSString*)[UserDefaultsUtil getObjectForKey:ADOPTED_PLAN_KEY] isEqualToString:plan.plan_id]) {
        [_adoptPlanBtn setEnabled:FALSE];
    }
    
}

-(IBAction)AdoptPlanAction:(id)sender{
    [self adoptPlanRequest:plan.plan_id];
}

- (void)adoptPlanRequest:(NSString*)planId {
   
    [self startProgressView];
    
    @try{
        @autoreleasepool {
            
            NSString *params = @"plan_id=";
            params = [params stringByAppendingString:planId];
            params = [params stringByAppendingString:@"&user_id="];
            params = [params stringByAppendingString:[NSString stringWithFormat:@"%@",[UserDefaultsUtil getObjectForKey:@"user_id"]]];
            
            [self sendPostRequestTo:@"clientplan/adoptPlan" withParams:params action:@selector(adoptPlanRequestComplete:)];
            //            [self performSegueWithIdentifier:@"SToMain" sender:self];
        }
    }@catch (NSException *exception) {
        
        NSLog(@"Exception :::: %@",[exception debugDescription]);
    
    }
    
}

-(void)adoptPlanRequestComplete:(NSData *)data{
    
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
        NSString *status = [responseDict objectForKey:@"status"];
        if([status isEqualToString:@"warning"]){
        }else if ([status isEqualToString:@"success"]){
            modal = [[RNBlurModalView alloc]initWithViewController:self title:@"Success" message:@"Plan Adopted Successfully"];
            [modal show];
            [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(HideAlertView) userInfo:nil repeats:NO];
            [Globals sharedInstance].isPlanEdited = TRUE;
            [Globals sharedInstance].isPlanChangedForMyDay = TRUE;
            [Globals sharedInstance].isPlanChanged = TRUE;
            [UserDefaultsUtil setObject:plan.plan_id forKey:ADOPTED_PLAN_KEY];

        }
    }
    
    [self stopProgressView];
    [self setViewStrings];
    
}

-(void) HideAlertView{
    
    [modal hide];
}


-(IBAction)BackButtonAction:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
