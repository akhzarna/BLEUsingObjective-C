//
//  HealthPlanViewController.h
//  iwowen
//
//  Created by Omer Waqas Khan on 23/11/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+Alpha.h"
#import "UIImage+RoundedImage.h"
#import "BaseViewController.h"
#import "Plan.h"
#import "ViewPlanViewController.h"
#import "EditPlanViewController.h"
#import "RNBlurModalView.h"

@interface HealthPlanViewController : BaseViewController  <UITableViewDataSource,UITableViewDelegate> {
    
    RNBlurModalView *modal;
    
    NSMutableArray *items;
    
    IBOutlet UITableView *table;
    int selectedIndex;
}
- (IBAction)backBtnClicked:(id)sender;


- (IBAction)createPlanActionButton:(id)sender;


@end
