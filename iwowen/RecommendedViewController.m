//
//  RecommendedViewController.m
//  iwowen
//
//  Created by Apple on 22/11/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import "RecommendedViewController.h"
#import "RecommendedPlanCell.h"
#import "EditPlanViewController.h"
#import "PlanDetailViewController.h"
#import "AsyncImageView.h"
#import "Globals.h"

@interface RecommendedViewController ()

@end

@implementation RecommendedViewController
@synthesize defaultPlan;

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
    
    [self getCurrentPlan];

}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
//    [self initializeView];
    
    if ([Globals sharedInstance].isPlanChangedDetailedView || [Globals sharedInstance].isPlanEdited) {
        
        [self getCurrentPlan];

    }

}

-(void)initializeView{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source and Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [items count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"planCell";
    
    RecommendedPlanCell *cell;
    if([tableView respondsToSelector:@selector(dequeueReusableCellWithIdentifier:forIndexPath:)]) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    
    if (cell == nil) {
        cell = [[RecommendedPlanCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    Plan *plan = [items objectAtIndex:indexPath.row];
    cell.titleLbl.text = plan.title;
    cell.weightLabel.text = plan.weight;
    cell.stepsLabel.text = plan.steps;
    NSString *strForImage = [NSString stringWithFormat:@"%@%@",CLIENT_PLAN_IMAGE_PATH,plan.image];
    [cell.pic  setImageURL:[NSURL URLWithString:strForImage]];
    [cell.titleLbl setBackgroundColor:[UIColor clearColor]];
    [cell.deleteBtn setHidden:YES];
    if ([UserDefaultsUtil getObjectForKey:ADOPTED_PLAN_KEY] != nil && [(NSString*)[UserDefaultsUtil getObjectForKey:ADOPTED_PLAN_KEY] isEqualToString:plan.plan_id]) {
        
        [cell.downloadBtn setHidden:YES];
        [cell.myCurrentPlanLabel setHidden:NO];
        
        }else{
        
        [cell.downloadBtn setHidden:NO];
        [cell.myCurrentPlanLabel setHidden:YES];
            
        [cell.downloadBtn addTarget:self action:@selector(adoptPlanBtnClicked:)  forControlEvents:UIControlEventTouchUpInside];
            
        cell.downloadBtn.tag = indexPath.row;
    
    }
    
    [cell.viewPlanButton addTarget:self action:@selector(viewPlanAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if (cell.downloadBtn.hidden == TRUE && indexPath.row == 0) {
        
        [cell.editPlanButton setHidden:FALSE];
        [cell.editPlanButton setTag:indexPath.row];
        [cell.editPlanButton addTarget:self action:@selector(editPlanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    } else{
        
        [cell.editPlanButton setHidden:TRUE];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndex = indexPath.row;
    [self ViewPlanbtnClick:nil];
}

- (void) ViewPlanbtnClick:(id)sender {
    
    [self performSegueWithIdentifier:@"SToViewDetailPlan" sender:self];
   
}

- (void) editPlanBtnClick:(id)sender{
    
    selectedIndex = ((UIButton*)sender).tag;
    [self performSegueWithIdentifier:@"SToEditPlan" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"SToViewDetailPlan"]) {
        PlanDetailViewController *vc = [segue destinationViewController];
        vc.plan = [items objectAtIndex:selectedIndex];
    }
    
    if ([[segue identifier] isEqualToString:@"SToEditPlan"]) {
        EditPlanViewController *vc = [segue destinationViewController];
        vc.plan = [items objectAtIndex:selectedIndex];
        
    }

}

- (IBAction)adoptPlanBtnClicked:(id)sender{
    
    Plan *plan = [items objectAtIndex:((UIButton*)sender).tag];
    [self adoptPlanRequest:plan.plan_id];
}


- (void)updateView {
    
    [table reloadData];
    
}

- (IBAction)backBtnClicked:(id)sender {
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count -2] animated:YES];
    
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
    NSError *error;
    NSDictionary *responseDict = [NSJSONSerialization
                                  JSONObjectWithData:data
                                  options:kNilOptions
                                  error:&error];
    
    if( error )
    {
        NSLog(@"%@", [error localizedDescription]);
    }else {
        currentPlan = [responseDict objectForKey:@"Current Plan"];
        if (currentPlan != nil) {
            [UserDefaultsUtil setObject:[currentPlan objectForKey:@"plan_id"] forKey:ADOPTED_PLAN_KEY];
        };
    }
    
    [self getDefaultPlan];

}

-(void) getDefaultPlan{
    
    @try{
        @autoreleasepool {
            
            [self sendGETRequestTo:[NSString stringWithFormat:@"clientplan/defaultPlan/id/%@",[UserDefaultsUtil getObjectForKey:@"user_id"]] withParams:nil action:@selector(getDefaultPlansRequestComplete:)];
            
        }
    }@catch (NSException *exception) {
        
        NSLog(@"Exception :::: %@",[exception debugDescription]);
        
    }
    
}

-(void)getDefaultPlansRequestComplete:(NSData *)data{
    
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
            NSArray *defaultPlanArray = [responseDict objectForKey:@"Plan Data"];
            defaultPlan = [defaultPlanArray objectAtIndex:0];
        }
    }
    [self getRecommendedPlans];
    
}


- (void)getRecommendedPlans {
    
    @try{
        @autoreleasepool {
            [self sendGETRequestTo:@"clientplan/getrecommendedPlan" withParams:nil action:@selector(getRecommendedPlansRequestComplete:)];
        }
    }@catch (NSException *exception) {
        NSLog(@"Exception :::: %@",[exception debugDescription]);
    }
    
}


-(void)getRecommendedPlansRequestComplete:(NSData *)data{
    
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
            NSArray *array = [responseDict objectForKey:@"Plan Data"];
            items = [[NSMutableArray alloc]init];
            Plan *plan = nil;
            plan = [[Plan alloc]initWithDict:defaultPlan];
            [items addObject:plan];
            for (NSDictionary *plans in array) {
                plan = [[Plan alloc]initWithDict:plans];
                [items addObject:plan];
            }
        }
    }
    
    [self stopProgressView];
    [Globals sharedInstance].isPlanChangedDetailedView = FALSE;
    [Globals sharedInstance].isPlanEdited = FALSE;
    [table reloadData];

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
            NSLog(@"Warning");
        }else if ([status isEqualToString:@"success"]){
        modal = [[RNBlurModalView alloc]initWithViewController:self title:@"Success" message:@"Plan Adopted Successfully"];
            [modal show];
        
        [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(HideAlertView) userInfo:nil repeats:NO];
            
            [Globals sharedInstance].isPlanChanged = TRUE;
            [Globals sharedInstance].isPlanChangedForMyDay = TRUE;

        }
    }
    
    [self stopProgressView];
    [self getCurrentPlan];
    
}

-(void) HideAlertView{
    
    [modal hide];
    
}


@end
