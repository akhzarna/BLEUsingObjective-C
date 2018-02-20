//
//  ViewPlanViewController.h
//  iwowen
//
//  Created by Apple on 27/11/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Plan.h"
#import "CustomProgressView.h"

@interface ViewPlanViewController : BaseViewController{
    
    NSDictionary *currentPlan;
    NSDictionary *currentPlanDetail;
    
}

@property (weak, nonatomic) IBOutlet CustomProgressView *weightProgressView;
@property (weak, nonatomic) IBOutlet CustomProgressView *stepsProgressView;
@property (weak, nonatomic) IBOutlet UILabel *weightAchievedLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepsAchievedLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepsLabel;
@property (weak, nonatomic) IBOutlet UILabel *planTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *fromDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *toDatelabel;
@property (strong,nonatomic)Plan *plan;

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *pTitle;
@property (weak, nonatomic) IBOutlet UILabel *startDate;
@property (weak, nonatomic) IBOutlet UILabel *endDate;
@property (weak, nonatomic) IBOutlet UILabel *steps;
@property (weak, nonatomic) IBOutlet UILabel *weight;

- (IBAction)backBtnClicked:(id)sender;
- (IBAction)ChangePlanAction:(id)sender;

@end
