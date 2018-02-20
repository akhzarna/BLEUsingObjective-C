//
//  FourDidgitViewController.m
//  iwown
//
//  Created by Akhzar Nazir on 25/02/2014.
//  Copyright (c) 2014 Ali Asghar. All rights reserved.
//

#import "FourDidgitViewController.h"
#import "Globals.h"

@interface FourDidgitViewController ()

@end

@implementation FourDidgitViewController
@synthesize FourDigitString;

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)EnterCodeForVerification:(id)sender{
    if ([[_fourDigitTextField text ] isEqualToString:[Globals sharedInstance].FourDigitCode]) {
        [[NSUserDefaults standardUserDefaults] setObject:[Globals sharedInstance].FourDigitCode forKey:@"BraceletMacAddress"];
        [self dismissModalViewControllerAnimated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Attention" message:@"You have entered an invalid code" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

@end
