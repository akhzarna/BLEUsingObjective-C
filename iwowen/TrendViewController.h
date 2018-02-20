//
//  TrendViewController.h
//  iwowen
//
//  Created by Apple on 22/11/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BarChartView.h"
#import "BaseViewController.h"

#define QUERY_PARAM_DAY @"days"
#define QUERY_PARAM_WEEK @"week"
#define QUERY_PARAM_MONTH @"month"

@interface TrendViewController : BaseViewController{
    NSMutableArray *daysArray;
    NSMutableArray *stepsArray;
    
    NSString *SetStepsOrWeight;
    NSString *SelectedParameters;

    
}

@property (weak, nonatomic) IBOutlet UILabel *stepsWeightTitlelabel;
@property (weak, nonatomic) IBOutlet UIButton *stepsBtn;
@property (weak, nonatomic) IBOutlet UIButton *weightBtn;

@property (weak, nonatomic) IBOutlet BarChartView *barChart;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)backBtnClicked:(id)sender;
- (IBAction)graphDataChangeBtnClicked:(id)sender;
- (IBAction)StepsWeightCategoryChangedAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *byDayBtn;
@property (weak, nonatomic) IBOutlet UIButton *byWeekBtn;
@property (weak, nonatomic) IBOutlet UIButton *byMonthBtn;
@end
