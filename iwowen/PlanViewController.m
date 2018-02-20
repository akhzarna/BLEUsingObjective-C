//
//  PlanViewController.m
//  iwowen
//
//  Created by Apple on 22/11/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import "PlanViewController.h"

@interface PlanViewController ()

@end

@implementation PlanViewController

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

- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count -2] animated:YES];
}

- (IBAction)recommendedPlanBtnClicked:(id)sender {
    [self performSegueWithIdentifier:@"SToRecommendedPlan" sender:self];
}


- (IBAction)healthPlanBtnClicked:(id)sender {
    [self performSegueWithIdentifier:@"SToHealthPlan" sender:self];
}

@end
