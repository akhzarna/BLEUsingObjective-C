//
//  RecommendedViewController.h
//  iwowen
//
//  Created by Apple on 22/11/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Plan.h"
#import "ViewPlanViewController.h"
#import "UIImage+RoundedImage.h"
#import "UIImage+Alpha.h"
#import "RNBlurModalView.h"

@interface RecommendedViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate> {
    NSTimer *timer;
    NSMutableArray *items;
    
    IBOutlet UITableView *table;
    
    int selectedIndex;
    
    RNBlurModalView *modal;
    NSDictionary *currentPlan;
    NSDictionary *defaultPlan;
}

@property (strong,nonatomic) NSDictionary *defaultPlan;

- (IBAction)backBtnClicked:(id)sender;

@end
