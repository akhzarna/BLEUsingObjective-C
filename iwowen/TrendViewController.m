//
//  TrendViewController.m
//  iwowen
//
//  Created by Apple on 22/11/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import "TrendViewController.h"

@interface TrendViewController ()

@end

@implementation TrendViewController

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
}

-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [_byDayBtn setBackgroundImage:[UIImage imageNamed:@"trend_inactive_tab.png"] forState:UIControlStateNormal];
    [_byWeekBtn setBackgroundImage:[UIImage imageNamed:@"trend_active_tab.png"] forState:UIControlStateNormal];
    [_byMonthBtn setBackgroundImage:[UIImage imageNamed:@"trend_inactive_tab.png"] forState:UIControlStateNormal];
    [_stepsWeightTitlelabel setText:@"Trends By Steps"];
    SetStepsOrWeight = @"steps_by=";
    SelectedParameters = QUERY_PARAM_WEEK;
    [self getTrendsFor:SelectedParameters];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count -2] animated:YES];
}

-(IBAction)StepsWeightCategoryChangedAction:(id)sender{
    
    int tag = [sender tag];
    switch (tag) {
       
        case 1:{
            
            [_stepsWeightTitlelabel setText:@"Trends By Steps"];
            SetStepsOrWeight = @"steps_by=";
            [self getTrendsFor:SelectedParameters];
        }
        break;
        
        case 2:{
            [_stepsWeightTitlelabel setText:@"Trends By Weight"];
            SetStepsOrWeight = @"weight_by=";
            [self getTrendsFor:SelectedParameters];
        }
            break;
            
        default:
            break;
    }
}

- (IBAction)graphDataChangeBtnClicked:(id)sender {
    int tag = [sender tag];
    switch (tag) {
        case 0:{
            SelectedParameters = QUERY_PARAM_DAY;
            [self getTrendsFor:SelectedParameters];
            [_byDayBtn setBackgroundImage:[UIImage imageNamed:@"trend_active_tab.png"] forState:UIControlStateNormal];
            [_byWeekBtn setBackgroundImage:[UIImage imageNamed:@"trend_inactive_tab.png"] forState:UIControlStateNormal];
            [_byMonthBtn setBackgroundImage:[UIImage imageNamed:@"trend_inactive_tab.png"] forState:UIControlStateNormal];
        }
            break;
        case 1:{
            SelectedParameters = QUERY_PARAM_WEEK;
            [self getTrendsFor:SelectedParameters];
            [_byDayBtn setBackgroundImage:[UIImage imageNamed:@"trend_inactive_tab.png"] forState:UIControlStateNormal];
            [_byWeekBtn setBackgroundImage:[UIImage imageNamed:@"trend_active_tab.png"] forState:UIControlStateNormal];
            [_byMonthBtn setBackgroundImage:[UIImage imageNamed:@"trend_inactive_tab.png"] forState:UIControlStateNormal];
        }
            break;
        case 2:{
            SelectedParameters = QUERY_PARAM_MONTH;
            [self getTrendsFor:SelectedParameters];
            [_byDayBtn setBackgroundImage:[UIImage imageNamed:@"trend_inactive_tab.png"] forState:UIControlStateNormal];
            [_byWeekBtn setBackgroundImage:[UIImage imageNamed:@"trend_inactive_tab.png"] forState:UIControlStateNormal];
            [_byMonthBtn setBackgroundImage:[UIImage imageNamed:@"trend_active_tab.png"] forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
}

- (void)getTrendsFor:(NSString*)queryParam {
    
    @try{
        
        @autoreleasepool {
            
            [self startProgressView];
            
            NSString *params = SetStepsOrWeight;
            
            params = [params stringByAppendingString:queryParam];
            params = [params stringByAppendingString:@"&user_id="];
            params = [params stringByAppendingString:[NSString stringWithFormat:@"%@",[UserDefaultsUtil getObjectForKey:@"user_id"]]];
            if ([SetStepsOrWeight isEqualToString:@"steps_by="]) {
            [self sendPostRequestTo:@"trends/index" withParams:params action:@selector(getTrendsRequestComplete:)];
            } else if ([SetStepsOrWeight isEqualToString:@"weight_by="]){
                
            [self sendPostRequestTo:@"trends/byweight" withParams:params action:@selector(getTrendsRequestComplete:)];
                
            }
        }
        
    }@catch (NSException *exception) {
        
    }
    
}

-(void)getTrendsRequestComplete:(NSData *)data{
    
    daysArray = [[NSMutableArray alloc]init];
    stepsArray = [[NSMutableArray alloc]init];
    NSString *response = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    [self stopProgressView];
    NSError *error;
    NSDictionary *responseDict = [NSJSONSerialization
                                  JSONObjectWithData:data
                                  options:kNilOptions
                                  error:&error];
    
    if( error )
    {
        NSLog(@"%@", [error localizedDescription]);
    }else {
        NSString *status = [responseDict objectForKey:@"status"];
        if([status isEqualToString:@"warning"]){
            NSLog(@"Warning");
        }else if ([status isEqualToString:@"failure"]){
            NSLog(@"failure");
        }else if ([status isEqualToString:@"success"]){
            NSLog(@"success");
            NSDictionary *dataDict = [responseDict objectForKey:@"by_day"];
            NSArray *weekArray;
            if(dataDict == nil){
                weekArray = [responseDict objectForKey:@"by_week"];
                if (weekArray == nil) {
                    dataDict = [responseDict objectForKey:@"by_month"];
                }
            }
            if (dataDict != nil) {
                for (int i = 1 ; i <= [dataDict count]; i++) {
                    if ([responseDict objectForKey:@"by_month"] != nil) {
                        if(i < 10){
                            [daysArray addObject:[NSString stringWithFormat:@"0%i",i]];
                            [stepsArray addObject:(NSString*)[dataDict objectForKey:[NSString stringWithFormat:@"0%i",i]]];
                        }else{
                            [daysArray addObject:[NSString stringWithFormat:@"%i",i]];
                            [stepsArray addObject:(NSString*)[dataDict objectForKey:[NSString stringWithFormat:@"%i",i]]];
                        }
                    }else{
                        [daysArray addObject:[NSString stringWithFormat:@"%i",i]];
                        [stepsArray addObject:(NSString*)[dataDict objectForKey:[NSString stringWithFormat:@"%i",i]]];
                    }
                }
            }else{
                if (weekArray != nil && [weekArray count] > 0) {
                    for (int i = 0; i < weekArray.count; i++) {
                        [daysArray addObject:[NSString stringWithFormat:@"0%i",(i+1)]];
                        [stepsArray addObject:weekArray[i]];
                    }
                }
            }
        }
    }
    
    [self loadBarChartUsingArray];
    
}

- (void)viewDidUnload {
    
    [self setBarChart:nil];
    [self setScrollView:nil];
    [self setByDayBtn:nil];
    [self setByWeekBtn:nil];
    [self setByMonthBtn:nil];
    [super viewDidUnload];
}

//------------------------------------------------------//
//--- Bar Chart Setup ----------------------------------//
//------------------------------------------------------//

#pragma mark - Bar Chart Setup

- (void)loadBarChartUsingArray {
    
    UIColor *white = [UIColor whiteColor];
    UIColor *greenColor = [UIColor colorWithRed:135.0/255.0 green:227.0/255.0 blue:23.0/255.0 alpha:1.0];
    if ([stepsArray count] > 20 ) {
        [_barChart setFrame:CGRectMake(0, 30, 600, _barChart.frame.size.height)];
    }else{
        [_barChart setFrame:CGRectMake(0, 30, 261, _barChart.frame.size.height)];
    }
    
    [_barChart setClearsContextBeforeDrawing:YES];
    _scrollView.contentSize = CGSizeMake(_barChart.width, 177);
    NSMutableArray *barColorArray = [[NSMutableArray alloc]init];
    NSMutableArray *labelColorArray = [[NSMutableArray alloc]init];
    for (NSString *str in stepsArray) {
        [barColorArray addObject:greenColor];
        [labelColorArray addObject:white];
    }
    
    NSArray *array = [_barChart createChartDataWithTitles:[NSArray arrayWithArray:daysArray]
                                                   values:[NSArray arrayWithArray:stepsArray]
                                                   colors:[NSArray arrayWithArray:barColorArray]
                                              labelColors:[NSArray arrayWithArray:labelColorArray]];
    
    
    // Set the Shape of the Bars (Rounded or Squared) - Rounded is default
    [_barChart setupBarViewShape:BarShapeRounded];
    
    // Set the Style of the Bars (Glossy, Matte, Fair, or Flat) - Glossy is default
    [_barChart setupBarViewStyle:BarStyleFair];
    
    // Set the Drop Shadow of the Bars (Light, Heavy, or None) - Light is default
    [_barChart setupBarViewShadow:BarShadowLight];
    
    // Set the Initial Animation of the Bars (Rise, Float, Fade, or None) - Rise is default
    [_barChart setupBarViewAnimation:BarAnimationRise];
    
    [_barChart setBackgroundColor:[UIColor clearColor]];
    // Generate the bar chart using the formatted data
    [_barChart setDataWithArray:array
                      showAxis:DisplayBothAxes
                     withColor:white
                      withFont:[UIFont systemFontOfSize:11]
       shouldPlotVerticalLines:YES];
    
    
}

@end
