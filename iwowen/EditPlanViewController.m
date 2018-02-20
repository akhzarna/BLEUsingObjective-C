//
//  CreatePlanViewController.m
//  iwowen
//
//  Created by Omer Waqas Khan on 23/11/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import "EditPlanViewController.h"
#import "AsyncImageView.h"
#import "Globals.h"

@interface EditPlanViewController ()

@end

@implementation EditPlanViewController

@synthesize planTitle;
@synthesize startDate;
@synthesize endDate;
@synthesize steps;
@synthesize weight;

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
    if (_plan != nil) {
        
        self.planTitle.text = _plan.title;
        self.startDate.text = _plan.start_date;
        self.endDate.text = _plan.end_date;
        self.steps.text = _plan.steps;
        self.weight.text = _plan.weight;
        uploadedImageURL = _plan.image;
        imageData = _plan.imageData;

        NSString *strForImage = [NSString stringWithFormat:@"%@%@",CLIENT_PLAN_IMAGE_PATH,_plan.image];
        [self.pic  setImageURL:[NSURL URLWithString:strForImage]];
        
    }
}

- (IBAction)startDateEditingDidBegin:(id)sender {
        
    [self.view endEditing:YES];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *dateFromString = [[NSDate alloc]init];
    if(startDate.text != nil && startDate.text.length > 0 ){
        [dateFormatter dateFromString:[startDate.text componentsSeparatedByString:@" "][0]];
    }
    _actionSheetPicker = [[ActionSheetDatePicker alloc] initWithTitle:@"Pick Date" datePickerMode:UIDatePickerModeDate selectedDate:dateFromString target:self action:@selector(startDateWasSelected:element:) origin:sender];
    [self.actionSheetPicker addCustomButtonWithTitle:@"Today" value:[NSDate date]];
    [self.actionSheetPicker addCustomButtonWithTitle:@"Yesterday" value:[[NSDate date] TC_dateByAddingCalendarUnits:NSDayCalendarUnit amount:-1]];
    self.actionSheetPicker.hideCancel = YES;
    [self.actionSheetPicker showActionSheetPicker];
}

- (IBAction)endDateEditingDidBegin:(id)sender {
    [self.view endEditing:YES];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *dateFromString = [[NSDate alloc]init];
    if(endDate.text != nil && endDate.text.length > 0 ){
        [dateFormatter dateFromString:[endDate.text componentsSeparatedByString:@" "][0]];
    }
    
    _actionSheetPicker = [[ActionSheetDatePicker alloc] initWithTitle:@"Pick Date" datePickerMode:UIDatePickerModeDate selectedDate:dateFromString target:self action:@selector(endDateWasSelected:element:) origin:sender];
    
    [self.actionSheetPicker addCustomButtonWithTitle:@"Today" value:[NSDate date]];
    [self.actionSheetPicker addCustomButtonWithTitle:@"Yesterday" value:[[NSDate date] TC_dateByAddingCalendarUnits:NSDayCalendarUnit amount:-1]];
    self.actionSheetPicker.hideCancel = YES;
    [self.actionSheetPicker showActionSheetPicker];
}

-(IBAction)selectPlanPic:(id)sender{
    
    UIImagePickerController* pickr = [[UIImagePickerController alloc] init];
    pickr.allowsEditing = NO;
    pickr.delegate   = self;
    pickr.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentModalViewController:pickr animated:YES];
    
}

#pragma mark - UIImagePickerController Delegate

- (void)imagePickerController:(UIImagePickerController *)picker1 didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    uploadData = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage], 30);
    _pic.image = [UIImage imageWithData:uploadData];
    uploadFile = [[BRRequestUpload alloc] initWithDelegate: self];
    uploadedImageURL = [NSString stringWithFormat:@"%@.png",[UserDefaultsUtil getObjectForKey:@"user_id"]];
    uploadFile.path = [NSString stringWithFormat:@"clientplan/%@_12345.png",[UserDefaultsUtil getObjectForKey:@"user_id"]];
    uploadFile.hostname = @"beusoft.com";
    uploadFile.username = @"iapp@beusoft.com";
    uploadFile.password = @"Ccjk@123a";
    
    [self setLoadingViewMessage:@"Uploading Image..."];
    [self startProgressView];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    //we start the request
    [uploadFile start];
    [picker1 dismissModalViewControllerAnimated:YES];
    
}

#pragma mark - Black Racoon Delegates

- (void) listDirectory
{
    listDir = [[BRRequestListDirectory alloc] initWithDelegate: self];
    listDir.hostname = @"beusoft.com";
    listDir.username = @"iapp@beusoft.com";
    listDir.password = @"Ccjk@123a";
    
    [listDir start];
}

-(void)requestFailed:(BRRequest *)request{
    
    if (request == listDir)
    {
        listDir = nil;
    }else if (request == uploadFile){
        uploadFile = nil;
        uploadedImageURL = @"";
    }
    
}

-(void)requestCompleted:(BRRequest *)request{
    
    //----- handle List Directory
    if (request == listDir)
    {
        for (NSDictionary *file in listDir.filesInfo)
        {
        }
        
        listDir = nil;
        [self stopProgressView];

    }
    if (request == uploadFile)
    {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        uploadFile = nil;
        [self stopProgressView];

    }
    
}

- (NSData *) requestDataToSend: (BRRequestUpload *) request
{
    NSData *temp = uploadData;   // this is a shallow copy of the pointer
    uploadData = nil;            // next time around, return nil...
    return temp;
}

- (long) requestDataSendSize: (BRRequestUpload *) request
{
    //----- user returns the total size of data to send. Used ONLY for percentComplete
    return [uploadData length];
}

-(BOOL) shouldOverwriteFileWithRequest: (BRRequest *) request
{
    //----- set this as appropriate if you want the file to be overwritten
    if (request == uploadFile)
    {
        //----- if uploading a file, we set it to YES
        return YES;
    }
    
    //----- anything else (directories, etc) we set to NO
    return NO;
}

-(BOOL)isValidateFields{
    
    if ([[planTitle text] isEqualToString:@""] || [[steps text] isEqualToString:@""] || [[weight text] isEqualToString:@""]) {
        
        return FALSE;
        
    }else{
        
        return TRUE;
    }
    
}


-(IBAction)EditPlanAction:(id)sender {
    
    if ([self isValidateFields]) {
        
        [self startProgressView];
        
        @try{
            @autoreleasepool {
                if([self validateFields]){
                    NSString *params = @"plan_title=";
                    params = [params stringByAppendingString:self.planTitle.text];
                    params = [params stringByAppendingString:@"&steps="];
                    params = [params stringByAppendingString:self.steps.text];
                    params = [params stringByAppendingString:@"&weight="];
                    params = [params stringByAppendingString:self.weight.text];
                    params = [params stringByAppendingString:@"&plan_id="];
                    params = [params stringByAppendingString:_plan.plan_id];
                    params = [params stringByAppendingString:@"&user_id="];
                    params = [params stringByAppendingString:[NSString stringWithFormat:@"%@",[UserDefaultsUtil getObjectForKey:@"user_id"]]];
                    params = [params stringByAppendingString:@"&image="];
                    params = [params stringByAppendingString:uploadedImageURL];
                    if (_plan == nil) {
                        
                        [self sendPostRequestTo:@"clientplan/createPlan" withParams:params action:@selector(editPlanRequestComplete:)];
                    }else{
                        
                        params = [params stringByAppendingString:@"&plan_id="];
                        params = [params stringByAppendingString:_plan.plan_id];
                        
                        [self sendPostRequestTo:@"clientplan/editPlan" withParams:params action:@selector(editPlanRequestComplete:)];
                    }
                    
                }else{
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"All fields are required" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
                    [alert show];
                    
                }
                
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

-(void) HideAlertView{
    
    [modal hide];
}

-(void)editPlanRequestComplete:(NSData *)data{
    
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
        }else if ([status isEqualToString:@"failure"]){
        }else if ([status isEqualToString:@"success"]){
            [self.navigationController popViewControllerAnimated:YES];
            [Globals sharedInstance].isPlanEdited = TRUE;
            [Globals sharedInstance].isPlanChangedForMyDay = TRUE;
            [Globals sharedInstance].isPlanChanged = TRUE;
        }
    }
    
    [self stopProgressView];
}

-(BOOL)validateFields{
    
    if(self.planTitle.text.length > 0 && self.startDate.text.length > 0 && self.endDate.text.length > 0&& self.steps.text.length > 0 && self.weight.text.length > 0 && uploadedImageURL != nil ){
        return YES;
    }
    return NO;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - UITextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    if([[UIScreen mainScreen] bounds].size.height == 568) {
        if (textField == steps) {
            self.view.center = CGPointMake(self.view.center.x, 220);
        }
        if (textField == weight) {
            self.view.center = CGPointMake(self.view.center.x, 200);
        }
    }
    else if([[UIScreen mainScreen] bounds].size.height == 480){
        if (textField == steps) {
            self.view.center = CGPointMake(self.view.center.x, 140);
        }
        if (textField == weight) {
            self.view.center = CGPointMake(self.view.center.x, 100);
        }
        
    }

    [UIView commitAnimations];
    
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // Any additional checks to ensure you have the correct textField here.
    
    [UIView beginAnimations:nil context:NULL];
    
    [UIView setAnimationDuration:0.2];

    if([[UIScreen mainScreen] bounds].size.height == 568) {
        
    self.view.center = CGPointMake(self.view.center.x, 259.5);
        
    }
    else if([[UIScreen mainScreen] bounds].size.height == 480){
        
    self.view.center = CGPointMake(self.view.center.x, 215.5);
        
    }
    
    [UIView commitAnimations];

    [textField resignFirstResponder];
    return YES;
}

- (IBAction)backBtnClicked:(id)sender {
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count -2] animated:YES];
}

#pragma mark - ActionSheet Delgates

-(void)startDateWasSelected:(NSDate *)selectedDate element:(id)element {
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    startDate.text = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:selectedDate]];
}

-(void)endDateWasSelected:(NSDate *)selectedDate element:(id)element {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    endDate.text = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:selectedDate]];
}

- (void)viewDidUnload {
    
    [self setPic:nil];
    [super viewDidUnload];

}

@end
