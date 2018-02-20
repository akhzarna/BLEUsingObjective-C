//
//  SettingViewController.m
//  iwowen
//
//  Created by Apple on 22/11/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import "SettingViewController.h"
#import "AccountViewController.h"
#import "SettingViewController.h"
#import "DevicesSearchViewController.h"
#import "Constants.h"
#import "Globals.h"

@interface SettingViewController ()

@end

@implementation SettingViewController


@synthesize kilogramImage;
@synthesize poundImage;

@synthesize inchesImage;
@synthesize meterImage;

@synthesize englishImage;
@synthesize chinaImage;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)tappedLeftButton:(id)sender
{
    
    [self performSegueWithIdentifier:@"SToDevices" sender:self];
}

- (IBAction)tappedRightButton:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
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
    NSUserDefaults *dataStore = [NSUserDefaults standardUserDefaults];
    self.weightLbl.text = [dataStore stringForKey:WEIGHT_KEY];
    self.heightLbl .text = [dataStore stringForKey:HEIGHT_KEY];
}

-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [_myProfileImageView setImage:[UIImage imageNamed:@"gray_larg.png"]];
    [_mySettingImageView setImage:[UIImage imageNamed:@"green_larg.png"]];
    [_myDevicesImageView setImage:[UIImage imageNamed:@"gray_larg.png"]];
    [self getCurrentSettings];

}

- (void)getCurrentSettings{
    
    @try{
        @autoreleasepool {
            
            [self startProgressView];
                        
            NSString *strForRequest = [NSString stringWithFormat:@"usersettings/usersettingbyid/id/%@",[UserDefaultsUtil getObjectForKey:@"user_id"]];
            [self sendGETRequestTo:strForRequest withParams:nil action:@selector(getCurrentSettingRequestComplete:)];
        }
        
    }@catch (NSException *exception) {
        
        NSLog(@"Exception :::: %@",[exception debugDescription]);
        
    }

    
}

-(void)getCurrentSettingRequestComplete:(NSData *)data{
    
    NSString *response = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *responseDict = [NSJSONSerialization
                                  JSONObjectWithData:data
                                  options:kNilOptions
                                  error:&error];
    
    if( error )
    {
    }else {
        currentSettings = [responseDict objectForKey:@"User Setting"];
        currentSettingsDict = [currentSettings objectAtIndex:0];
        if ([currentSettings objectAtIndex:0] != nil) {
        [UserDefaultsUtil setObject:[currentSettingsDict objectForKey:@"setting_id"] forKey:@"adopted_setting"];
        }
    }
    
    [self stopProgressView];
    [self setViewStrings];
}

-(void) setViewStrings{
    
    NSUserDefaults *dataStore = [NSUserDefaults standardUserDefaults];

    if ([[currentSettingsDict objectForKey:@"unit_of_height"] isEqualToString:@"inches"]) {
        [dataStore setValue:@"inches" forKey:HEIGHT_UNIT_KEY];
        [inchesImage setImage:[UIImage imageNamed:@"dark-brown-bg.png"]];
        [meterImage setImage:[UIImage imageNamed:@"brown-bg.png"]];
        
    }else if ([[currentSettingsDict objectForKey:@"unit_of_height"] isEqualToString:@"meter"]) {
        [dataStore setValue:@"meter" forKey:HEIGHT_UNIT_KEY];
        [meterImage setImage:[UIImage imageNamed:@"dark-brown-bg.png"]];
        [inchesImage setImage:[UIImage imageNamed:@"yellow-bg.png"]];
    }
    if ([[currentSettingsDict objectForKey:@"unit_of_weight"] isEqualToString:@"kg"]) {
        [dataStore setValue:@"kg" forKey:WEIGHT_UNIT_KEY];
        [kilogramImage setImage:[UIImage imageNamed:@"dark-brown-bg.png"]];
        [poundImage setImage:[UIImage imageNamed:@"brown-bg.png"]];
    }else if ([[currentSettingsDict objectForKey:@"unit_of_weight"] isEqualToString:@"lb"]) {
        [dataStore setValue:@"lb" forKey:WEIGHT_UNIT_KEY];
        [kilogramImage setImage:[UIImage imageNamed:@"yellow-bg.png"]];
        [poundImage setImage:[UIImage imageNamed:@"dark-brown-bg.png"]];
    }
    if ([[currentSettingsDict objectForKey:@"language"] isEqualToString:@"en"]) {
        [dataStore setValue:@"en" forKey:LANGUAGE_KEY];
        [englishImage setImage:[UIImage imageNamed:@"dark-brown-bg.png"]];
        [chinaImage setImage:[UIImage imageNamed:@"brown-bg.png"]];
        
    }else if ([[currentSettingsDict objectForKey:@"language"] isEqualToString:@"zh"]) {
        [dataStore setValue:@"zh" forKey:WEIGHT_UNIT_KEY];
        [englishImage setImage:[UIImage imageNamed:@"yellow-bg.png"]];
        [chinaImage setImage:[UIImage imageNamed:@"dark-brown-bg.png"]];
    }
    [dataStore synchronize];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtnClicked:(id)sender {
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count -2] animated:YES];
}

- (IBAction)weightUnitBtnClicked:(id)sender {
    
    NSUserDefaults *dataStore = [NSUserDefaults standardUserDefaults];
    int tag = [sender tag];
    switch (tag) {
        case 1:
            [dataStore setValue:@"kg" forKey:WEIGHT_UNIT_KEY];
            [kilogramImage setImage:[UIImage imageNamed:@"dark-brown-bg.png"]];
            [poundImage setImage:[UIImage imageNamed:@"brown-bg.png"]];
            break;
        case 2:
            [dataStore setValue:@"lb" forKey:WEIGHT_UNIT_KEY];
            [kilogramImage setImage:[UIImage imageNamed:@"yellow-bg.png"]];
            [poundImage setImage:[UIImage imageNamed:@"dark-brown-bg.png"]];
            break;
        default:
            break;
    }
    
    [dataStore synchronize];
    
}

- (IBAction)heightUnitBtnClicked:(id)sender {
    NSUserDefaults *dataStore = [NSUserDefaults standardUserDefaults];
    int tag = [sender tag];
    switch (tag) {
        case 1:
            
            [dataStore setValue:@"inches" forKey:HEIGHT_UNIT_KEY];
            [inchesImage setImage:[UIImage imageNamed:@"dark-brown-bg.png"]];
            [meterImage setImage:[UIImage imageNamed:@"brown-bg.png"]];
            
            break;
        case 2:
            
            [dataStore setValue:@"meter" forKey:HEIGHT_UNIT_KEY];
            [inchesImage setImage:[UIImage imageNamed:@"yellow-bg.png"]];
            [meterImage setImage:[UIImage imageNamed:@"dark-brown-bg.png"]];
            
            break;
        default:
            break;
    }
    
    [dataStore synchronize];
}

- (IBAction)languageBtnClicked:(id)sender {
    NSUserDefaults *dataStore = [NSUserDefaults standardUserDefaults];
    
    int tag = [sender tag];
    switch (tag) {
        case 1:
            
            [dataStore setValue:@"en" forKey:LANGUAGE_KEY];
            
            [englishImage setImage:[UIImage imageNamed:@"dark-brown-bg.png"]];
            [chinaImage setImage:[UIImage imageNamed:@"brown-bg.png"]];
            
            break;
        case 2:
            
            [dataStore setValue:@"zh" forKey:LANGUAGE_KEY];
            
            [englishImage setImage:[UIImage imageNamed:@"yellow-bg.png"]];
            [chinaImage setImage:[UIImage imageNamed:@"dark-brown-bg.png"]];
            
            break;
        default:
            break;
    }
    
    [dataStore synchronize];
}

- (IBAction)saveSetting:(id)sender {
    
    [self startProgressView];
    
    NSUserDefaults *dataStore = [NSUserDefaults standardUserDefaults];
    
    @try{
        @autoreleasepool {
            
            NSString *params = @"unit_of_height=";
            params = [params stringByAppendingString:[dataStore valueForKey:HEIGHT_UNIT_KEY]];
            
            params = [params stringByAppendingString:@"&unit_of_weight="];
            params = [params stringByAppendingString:[dataStore valueForKey:WEIGHT_UNIT_KEY]];
            
            params = [params stringByAppendingString:@"&language="];
            params = [params stringByAppendingString:[dataStore valueForKey:LANGUAGE_KEY]];
            
            params = [params stringByAppendingString:@"&user_id="];
            params = [params stringByAppendingString:[NSString stringWithFormat:@"%@",[UserDefaultsUtil getObjectForKey:@"user_id"]]];
            
            NSLog(@"Parameters are %@",params);
            
            [self sendPostRequestTo:@"usersettings/updateusersetting" withParams:params action:@selector(updateSettingRequestComplete:)];
        }
    }@catch (NSException *exception) {
        NSLog(@"Exception :::: %@",[exception debugDescription]);
        
        [self stopProgressView];
    }
    
    [dataStore synchronize];

}

-(void)updateSettingRequestComplete:(NSData *)data{
    
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
        }else if ([status isEqualToString:@"failure"]){
            NSLog(@"failure");
        }else if ([status isEqualToString:@"success"]){
            NSLog(@"success");
            
            modal = [[RNBlurModalView alloc]initWithViewController:self title:@"Success" message:@"Settings Changed Successfully"];
            
            [modal show];
            
            [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(HideAlertView) userInfo:nil repeats:NO];
            
            [Globals sharedInstance].isSettingsChanged = TRUE;


        }
    }
    
    [self stopProgressView];
}

-(void) HideAlertView{
    
    [modal hide];
}

-(IBAction)MyProfileAction:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)MySettingAction:(id)sender{
    
}

-(IBAction)MyDevicesAction:(id)sender{
    
    [self performSegueWithIdentifier:@"SToDevices" sender:self];
    
}

- (void)viewDidUnload {
    [self setWeightLbl:nil];
    [self setHeightLbl:nil];
    [super viewDidUnload];
}
@end
