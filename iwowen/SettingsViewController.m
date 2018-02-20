//
//  SettingsViewController.m
//  iwowen
//
//  Created by Apple on 22/11/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import "SettingsViewController.h"
#import "AccountViewController.h"
#import "SettingViewController.h"
#import "DevicesSearchViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

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
    _swipeView.alignment = SwipeViewAlignmentCenter;
    _swipeView.pagingEnabled = YES;
    _swipeView.itemsPerPage = 1;
    _swipeView.truncateFinalPage = YES;
    items = [[NSArray alloc]initWithObjects:@"Account",@"Trend",@"Settings",@"Devices",@"Help", nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    return YES;

}


# pragma mark - Swipe View Data Source and Delegates

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return 3;

}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    
    if (index == 0) {
        
        [self performSegueWithIdentifier:@"SToProfileView" sender:self];
    }else if (index == 1) {
        [self performSegueWithIdentifier:@"SToSettingView" sender:self];
    } else if (index == 2) {
        [self performSegueWithIdentifier:@"SToDevicesView" sender:self];
    }
    if (!view)
    {
        
    }
    return view;
    
}

#pragma mark -
#pragma mark Control events

- (IBAction)ButtonOnePressed:(id)sender{
    
    [self performSegueWithIdentifier:@"SToProfileView" sender:self];
    
}

- (IBAction)ButtonTwoPressed:(id)sender{
    [self performSegueWithIdentifier:@"SToSettingView" sender:self];
}

- (IBAction)ButtonThreePressed:(id)sender{
    [self performSegueWithIdentifier:@"SToDevicesView" sender:self];

}

- (IBAction)pressedButton:(id)sender
{
}

- (IBAction)toggledSwitch:(id)sender
{
    
}

- (IBAction)changedSlider:(id)sender
{
    
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_settingsTableView deselectRowAtIndexPath:_settingsTableView.indexPathForSelectedRow animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)settingBtnClicked:(id)sender {
    [self performSegueWithIdentifier:@"SToSetting" sender:self];
}

- (IBAction)devicesBtnClicked:(id)sender {
    [self performSegueWithIdentifier:@"SToDevices" sender:self];
}

- (IBAction)accountBtnClicked:(id)sender {
    [self performSegueWithIdentifier:@"SToAccount" sender:self];
}

- (IBAction)trendsBtnClicked:(id)sender {
    [self performSegueWithIdentifier:@"SToTrends" sender:self];
}

- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count -2] animated:YES];
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
    
    UITableViewCell *cell;
    if([tableView respondsToSelector:@selector(dequeueReusableCellWithIdentifier:forIndexPath:)]) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    }else{
    
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    }
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [items objectAtIndex:indexPath.row];
    [cell.textLabel setBackgroundColor:[UIColor whiteColor]];
    [cell.textLabel setTextColor:[UIColor grayColor]];
    
    switch (indexPath.row) {
        case 0:
            cell.imageView.image = [UIImage imageNamed:@"001.png"];
            break;
        case 1:
            cell.imageView.image = [UIImage imageNamed:@"002.png"];
            break;
        case 2:
            cell.imageView.image = [UIImage imageNamed:@"003.png"];
            break;
        case 3:
            cell.imageView.image = [UIImage imageNamed:@"004.png"];
            break;
        case 4:
            cell.imageView.image = [UIImage imageNamed:@"005.png"];
            break;
            
        default:
            break;
    }
   
        cell.accessoryView = [[ UIImageView alloc ]
                              initWithImage:[UIImage imageNamed:@"006.png" ]];
        
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self performSegueWithIdentifier:@"SToAccount" sender:self];
            break;
        case 1:
            [self performSegueWithIdentifier:@"SToTrends" sender:self];
            break;
        case 2:
            [self performSegueWithIdentifier:@"SToSetting" sender:self];
            break;
        case 3:
            [self performSegueWithIdentifier:@"SToDevices" sender:self];
            break;
        case 4:
            break;
            
        default:
            break;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}


@end
