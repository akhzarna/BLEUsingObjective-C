//
//  PlanDetailViewController.h
//  iwown
//
//  Created by Akhzar Nazir on 27/02/2014.
//  Copyright (c) 2014 Ali Asghar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Plan.h"
#import "RNBlurModalView.h"

@interface PlanDetailViewController : BaseViewController {
    
    RNBlurModalView *modal;
    
}

@property (weak, nonatomic) IBOutlet UIButton *adoptPlanBtn;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepsLabel;

@property (weak, nonatomic) IBOutlet UILabel *toDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLable;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong,nonatomic)Plan *plan;

-(IBAction)BackButtonAction:(id)sender;
-(IBAction)AdoptPlanAction:(id)sender;

@end
