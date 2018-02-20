//
//  SettingsViewController.h
//  iwowen
//
//  Created by Apple on 22/11/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeView.h"

@interface SettingsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SwipeViewDelegate, SwipeViewDataSource>{
    
    NSArray *items;
}

@property (nonatomic, strong) IBOutlet SwipeView *swipeView;

@property (weak, nonatomic) IBOutlet UITableView *settingsTableView;
@property (weak, nonatomic) IBOutlet UIScrollView *settingScrollView;
@property (weak, nonatomic) IBOutlet UIView *FirstView;
@property (weak, nonatomic) IBOutlet UIView *SecondView;
@property (weak, nonatomic) IBOutlet UIView *ThirdView;
@property (weak, nonatomic) IBOutlet UIView *FourthView;

- (IBAction)settingBtnClicked:(id)sender;
- (IBAction)devicesBtnClicked:(id)sender;
- (IBAction)accountBtnClicked:(id)sender;
- (IBAction)trendsBtnClicked:(id)sender;
- (IBAction)backBtnClicked:(id)sender;

- (IBAction)ButtonOnePressed:(id)sender;
- (IBAction)ButtonTwoPressed:(id)sender;
- (IBAction)ButtonThreePressed:(id)sender;
- (IBAction)ButtonFourPressed:(id)sender;


@end
