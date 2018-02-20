//
//  AddFamilyMemberViewController.m
//  iwowen
//
//  Created by Ali Asghar on 10/20/13.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import "AddFamilyMemberViewController.h"
#import "ActionSheetStringPicker.h"

@interface AddFamilyMemberViewController ()

@end

@implementation AddFamilyMemberViewController

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
    genderArray = [NSArray arrayWithObjects:@"Male", @"Female", nil];
    heightArray = [NSArray arrayWithObjects:@"8", @"12", @"14", @"16", @"18" , @"20", @"22", @"24", nil];
    ageArray = [NSArray arrayWithObjects:@"8", @"12", @"14", @"16", @"18" , @"20", @"22", @"24",@"26",@"28", nil];
    weightArray = [NSArray arrayWithObjects:@"8", @"12", @"14", @"16", @"18" , @"20", @"22", @"24", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)genderBtnClicked:(id)sender {
    [ActionSheetStringPicker showPickerWithTitle:@"Select Gender" rows:genderArray initialSelection:0 target:self sucessAction:@selector(genderWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
}

- (void)genderWasSelected:(NSNumber *)selectedIndex1 element:(id)element {
}

- (IBAction)heightBtnClicked:(id)sender {
    [ActionSheetStringPicker showPickerWithTitle:@"Select Height" rows:heightArray initialSelection:0 target:self sucessAction:@selector(heightWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
}

- (void)heightWasSelected:(NSNumber *)selectedIndex1 element:(id)element {
}

- (IBAction)ageBtnClicked:(id)sender {
    [ActionSheetStringPicker showPickerWithTitle:@"Select Age" rows:ageArray initialSelection:0 target:self sucessAction:@selector(ageWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
}

- (void)ageWasSelected:(NSNumber *)selectedIndex1 element:(id)element {
}

- (IBAction)weightBtnClicked:(id)sender {
    [ActionSheetStringPicker showPickerWithTitle:@"Select Weight" rows:weightArray initialSelection:0 target:self sucessAction:@selector(ageWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
}

- (void)weightWasSelected:(NSNumber *)selectedIndex1 element:(id)element {
}

@end
