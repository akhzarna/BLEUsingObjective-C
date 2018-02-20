//
//  HealthPlanViewController.m
//  iwowen
//
//  Created by Omer Waqas Khan on 23/11/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import "HealthPlanViewController.h"
#import "RecommendedPlanCell.h"

@interface HealthPlanViewController ()

@end

@implementation HealthPlanViewController

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
    [self initializeView];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self startProgressView];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
}

-(void)initializeView{
    
    [self getCurrentPlan];
    
}

#pragma mark - Table view data source

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
    if(plan.imageData != nil){
        UIImage *image = [UIImage imageWithData:plan.imageData];
        cell.pic.image = [UIImage roundedImageWithImage:[image imageWithAlpha]];
    }
    
    [cell.titleLbl setBackgroundColor:[UIColor clearColor]];
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClicked:)  forControlEvents:UIControlEventTouchUpInside];
    cell.deleteBtn.tag = indexPath.row;
    
    [cell.adoptBtn addTarget:self action:@selector(downloadBtnClicked:)  forControlEvents:UIControlEventTouchUpInside];
    cell.adoptBtn.tag = indexPath.row;
   
    [cell.editBtn addTarget:self action:@selector(editBtnClicked:)  forControlEvents:UIControlEventTouchUpInside];
    cell.editBtn.tag = indexPath.row;
    if (indexPath.row == 0) {
        [cell.deleteBtn setHidden:YES];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndex = indexPath.row;
    [self performSegueWithIdentifier:@"SToViewPlan" sender:self];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    if (indexPath.row == 0) {
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtnClicked:(id)sender {
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count -2] animated:YES];
}

- (IBAction)editBtnClicked:(id)sender {
    
    selectedIndex = ((UIButton*)sender).tag;
    [self performSegueWithIdentifier:@"SToEditPlan" sender:self];
    
}

- (IBAction)createPlanActionButton:(id)sender {
    
    [self performSegueWithIdentifier:@"SToCreatePlan" sender:self];
    
}

- (IBAction)deleteBtnClicked:(id)sender{
    
    Plan *plan = [items objectAtIndex:((UIButton*)sender).tag];
    [self deletePlanRequest:plan.plan_id];
    
}

- (IBAction)downloadBtnClicked:(id)sender{
    
    Plan *plan = [items objectAtIndex:((UIButton*)sender).tag];
    [self adoptPlanRequest:plan.plan_id];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"SToViewPlan"]) {
        ViewPlanViewController *vc = [segue destinationViewController];
        vc.plan = [items objectAtIndex:selectedIndex];
    }else if ([[segue identifier] isEqualToString:@"SToEditPlan"]) {
        EditPlanViewController *vc = [segue destinationViewController];
        vc.plan = [items objectAtIndex:selectedIndex];
    }
    
}


- (void)getCurrentPlan{
    
    
    @try{
        @autoreleasepool {
            
            [self startProgressView];
            
            NSString *strForRequest = [NSString stringWithFormat:@"clientplan/userCurrentPlanbyId/user_id/%@",[UserDefaultsUtil getObjectForKey:@"user_id"]];
            [self sendGETRequestTo:strForRequest withParams:nil action:@selector(getCurrentPlanRequestComplete:)];
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
        NSLog(@"%@", [error localizedDescription]);
    }else {
        //
        NSDictionary *currentPlan = [responseDict objectForKey:@"Current Plan"];
        if (currentPlan != nil) {
            [UserDefaultsUtil setObject:[currentPlan objectForKey:@"plan_id"] forKey:ADOPTED_PLAN_KEY];
        };
    }
    
    [self getHealthPlans];
}

- (void)getHealthPlans {
    
    @try{
        @autoreleasepool {
            
            NSString *strForRequest = [NSString stringWithFormat:@"clientplan/userPlansByID/id/%@",[UserDefaultsUtil getObjectForKey:@"user_id"]];
            [self sendGETRequestTo:strForRequest withParams:nil action:@selector(getRecommendedPlansRequestComplete:)];
            
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
            NSArray *array = [responseDict objectForKey:@"User Plan Data"];
            NSArray *defaultPlan = [responseDict objectForKey:@"Default Plan Data"];
            items = [[NSMutableArray alloc]init];
            Plan *plan = nil;
            plan = [[Plan alloc]initWithDict:[defaultPlan objectAtIndex:0]];
            [items addObject:plan];
            
            int index = 0;
            for (NSDictionary *plans in array) {
                plan = [[Plan alloc]initWithDict:[plans objectForKey:[NSString stringWithFormat:@"%i",index]]];
                [items addObject:plan];
                index++;
            }
        }
    }
    
    [table reloadData];
    
    [self stopProgressView];
    
    [self runOperationQueueWithSelector:@selector(loadImage)];
    
}

- (void)loadImage {
    
    for(int i = 0;i < [items count];i++){
       
        Plan *plan = (Plan *)[items objectAtIndex:i];
        NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CLIENT_PLAN_IMAGE_PATH,plan.image]]];
        plan.imageData = imageData;
        [self performSelectorOnMainThread:@selector(updateView) withObject:nil waitUntilDone:YES];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    });
}

- (void)updateView {
    [table reloadData];
}

- (void)adoptPlanRequest:(NSString*)planId {
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
            
            
        }
    }
    [self initializeView];
}

-(void) HideAlertView{
    
    [modal hide];
}


- (void)deletePlanRequest:(NSString*)planId {
    @try{
        @autoreleasepool {
            
            NSString *params = @"plan_id=";
            params = [params stringByAppendingString:planId];
            params = [params stringByAppendingString:@"&user_id="];
            params = [params stringByAppendingString:[NSString stringWithFormat:@"%@",[UserDefaultsUtil getObjectForKey:@"user_id"]]];
            
            [self sendPostRequestTo:@"clientplan/deletePlan " withParams:params action:@selector(deletePlanRequestComplete:)];
            //            [self performSegueWithIdentifier:@"SToMain" sender:self];
        }
    }@catch (NSException *exception) {
        NSLog(@"Exception :::: %@",[exception debugDescription]);
    }
    
}

-(void)deletePlanRequestComplete:(NSData *)data{
    
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
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Plan Removed Successfully" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
            [alert show];
            [self getHealthPlans];
        }
    }
}




@end
