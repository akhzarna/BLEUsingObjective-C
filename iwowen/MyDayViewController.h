//
//  MyDayViewController.h
//  iwown
//
//  Created by Akhzar Nazir on 25/02/2014.
//  Copyright (c) 2014 Ali Asghar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CalendarItem.h"
#import "PlanItem.h"
#import "SwipeView.h"

@interface MyDayViewController : BaseViewController <SwipeViewDataSource,SwipeViewDelegate>{
    
    NSString *currentDateis;
    CalendarItem *calenderObj;
    NSDate *dateFromString;
    NSDateFormatter *dateFormatter;
    PlanItem *item;
    NSMutableArray *items;
    NSString *currentDateWithYear;
}

@property (weak, nonatomic) IBOutlet UILabel *syncTimeLabel;

@property (nonatomic, strong) IBOutlet SwipeView *swipeView;
@property (weak, nonatomic) IBOutlet UILabel *timeAlarmLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionAlarm;

@property (weak, nonatomic) IBOutlet UITableView *reminderTableView;

@property (weak, nonatomic) IBOutlet UILabel *currentDateLabel;

@property (weak, nonatomic) IBOutlet UIImageView *weightGoalAchievImage;
@property (weak, nonatomic) IBOutlet UILabel *weightGoalAchieveLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightAchieveLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightTargetLabel;

@property (weak, nonatomic) IBOutlet UIImageView *stepGoalAchievImage;
@property (weak, nonatomic) IBOutlet UILabel *stepGoalAchieveLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepAchieveLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepTargetLabel;


@property (weak, nonatomic) IBOutlet UIImageView *weightImageView;
@property (weak, nonatomic) IBOutlet UIImageView *stepsImageView;
@property (weak, nonatomic) IBOutlet UIImageView *reminderImageView;

@property (weak, nonatomic) IBOutlet UIView *viewWeight;
@property (weak, nonatomic) IBOutlet UIView *viewSteps;
@property (weak, nonatomic) IBOutlet UIView *viewReminder;
@property (weak, nonatomic) IBOutlet UIView *viewStepsDetai;
@property (weak, nonatomic) IBOutlet UIView *viewWeightDetail;
@property (weak, nonatomic) IBOutlet UIView *ViewReminderDetail;
@property (weak, nonatomic) IBOutlet UILabel *weightGoalLabel;

-(IBAction)WeightAction:(id)sender;
-(IBAction)StepsAction:(id)sender;
-(IBAction)ReminderAction:(id)sender;
-(IBAction)AddReminderAction:(id)sender;
-(IBAction)CalendarViewAction:(id)sender;

@end
