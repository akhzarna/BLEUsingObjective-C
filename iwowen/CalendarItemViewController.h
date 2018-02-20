//
//  CalendarItemViewController.h
//  iwowen
//
//  Created by Apple on 10/12/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarItem.h"
#import "CustomProgressView.h"
#import "BaseViewController.h"
#import "PlanItem.h"
#import "PlanItemCell.h"

@interface CalendarItemViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate>{
    
    NSMutableArray *items;
    
}

@property (strong,nonatomic) CalendarItem *item;

@property (weak, nonatomic) IBOutlet UILabel *headerTitle;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *actualSteps;
@property (weak, nonatomic) IBOutlet UILabel *workoutSteps;
@property (weak, nonatomic) IBOutlet UILabel *workoutWeight;
@property (weak, nonatomic) IBOutlet UILabel *actualWeight;
@property (weak, nonatomic) IBOutlet CustomProgressView *stepsProgressView;
@property (weak, nonatomic) IBOutlet CustomProgressView *weightProgressView;

- (IBAction)addReminderBtnClicked:(id)sender;
- (IBAction)backBtnClicked:(id)sender;
//@property (weak, nonatomic) IBOutlet UITextView *reminderTV;

@end
