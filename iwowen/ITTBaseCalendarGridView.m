//
//  BaseCalendarGridView.m
//  ZHJCalendar
//
//  Created by huajian zhou on 12-4-12.
//  Copyright (c) 2012年 itotemstudio. All rights reserved.
//

#import "ITTBaseCalendarGridView.h"
#import "Globals.h"

@interface ITTBaseCalendarGridView()

@property (retain, nonatomic) IBOutlet UIButton *gridButton;
@property (retain, nonatomic) IBOutlet UIImageView *stepsImage;
@property (retain, nonatomic) IBOutlet UIImageView *weightImage;
@property (retain, nonatomic) IBOutlet UIImageView *currentDayImage;

@end

@implementation ITTBaseCalendarGridView

@synthesize gridButton;
@synthesize stepsImage;
@synthesize weightImage;
@synthesize currentDayImage;

- (IBAction)onGridButtonTouched:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(calendarGridViewDidSelectGrid:)]) {
        [_delegate ittCalendarGridViewDidSelectGrid:self];
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)select
{
    self.selected = TRUE;
    self.gridButton.selected = TRUE; 
    self.gridButton.userInteractionEnabled = FALSE;
}

- (void)deselect
{
    self.selected = FALSE;
    self.gridButton.selected = FALSE;
    self.gridButton.userInteractionEnabled = TRUE;    
}

- (void)layoutSubviews
{
    NSString *title = [NSString stringWithFormat:@"%d", [_calDay getDay]];
    
    NSLog(@"Get Day from Layout is = %d",[_calDay getDay]);
    
    if (_selectedEanable) {
    
        self.gridButton.selected = self.selected;
        [self.gridButton setBackgroundColor:[UIColor clearColor]];
        [self.gridButton setBackgroundImage:nil forState:UIControlStateNormal];
//        [self.gridButton setTitleColor:RGBCOLOR(122, 119, 122)forState:UIControlStateNormal];
        
        [self.gridButton setTitleColor:RGBCOLOR(233, 232, 231)forState:UIControlStateNormal];
    
//        [self.gridButton setTitleColor:RGBCOLOR(0, 0, 0)forState:UIControlStateNormal];
        
//        [self.gridButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
//        [self.gridButton setTitleColor:[UIColor colorWithRed:(0/255.0) green:(255/255.0) blue:(0/255.0) alpha:1] forState:UIControlStateNormal];

    }
    
    else {
        
        self.gridButton.selected = FALSE;
        [self.gridButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [self.gridButton setTitleColor:RGBCOLOR(233, 232, 231)forState:UIControlStateNormal];
        [self.gridButton setBackgroundImage:[UIImage imageNamed:@"cal_previous_month_day_bg.png"] forState:UIControlStateNormal];
        
    }
    
    [self.gridButton setTitle:title forState:UIControlStateNormal];
    
    
    /// For Custom Dates images on Calendar ////
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateFromString = [[NSDate alloc]init];
    
    NSLog(@"Date is = %@",[dateFormatter stringFromDate:dateFromString]);
    
    NSString *currentDateis = [[dateFormatter stringFromDate:dateFromString] substringFromIndex: [[dateFormatter stringFromDate:dateFromString] length] - 2];
        
    NSLog(@"Current Date is = %@",[dateFormatter stringFromDate:dateFromString]);
    NSLog(@"Current Day is = %@",currentDateis);
    
    NSLog(@"Global Calendar Data is = %@",[Globals sharedInstance].CalendarDataForStepsWeights);
    
    if ([_calDay getDay] == [currentDateis integerValue]) {
        
//    [self.gridButton setBackgroundImage:[UIImage imageNamed:@"Cal_selected_date_bg.png"] forState:UIControlStateNormal];

        [currentDayImage setImage:[UIImage imageNamed:@"Cal_selected_date_bg.png"]];
        
//        [currentDayImage seti];
    
    }else{
        
    if ([_calDay getDay] == 1) {
        
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"1"] isKindOfClass:[NSDictionary class]]) {
            
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"1"] objectForKey:@"workout_steps"] != nil) {
        
        if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"1"] objectForKey:@"workout_steps"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"1"] objectForKey:@"plan_steps"] integerValue])
        {
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsAchieved.png"]];
            
        }else{
            
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsNotAchieved.png"]];

        }
        }
        
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"1"] objectForKey:@"workout_weight"] != nil) {

        if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"1"] objectForKey:@"workout_weight"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"1"] objectForKey:@"plan_weight"] integerValue])
        {
            [weightImage setImage:[UIImage imageNamed:@"Cal_WeightAchieved.png"]];
            
        } else {
            
            [weightImage setImage:[UIImage imageNamed:@"Cal_WeightNotAchieved.png"]];

        }
    
    }
        

    }
        
    }
        
    if ([_calDay getDay] == 2) {
        
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"2"] isKindOfClass:[NSDictionary class]]) {

        
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"2"] objectForKey:@"workout_steps"] != nil) {
            
        if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"2"] objectForKey:@"workout_steps"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"1"] objectForKey:@"plan_steps"] integerValue])
        {
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsAchieved.png"]];
            
        }else{
            
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsNotAchieved.png"]];
            
        }
        }
        
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"2"] objectForKey:@"workout_weight"] != nil) {
            
            if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"2"] objectForKey:@"workout_weight"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"2"] objectForKey:@"plan_weight"] integerValue])
            {
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightAchieved.png"]];
                
            } else {
                
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightNotAchieved.png"]];
            }
            
        }
    
    }
    }
    if ([_calDay getDay] == 3) {
        
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"3"] isKindOfClass:[NSDictionary class]]) {

        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"3"] objectForKey:@"workout_steps"] != nil) {
            
        if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"3"] objectForKey:@"workout_steps"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"3"] objectForKey:@"plan_steps"] integerValue])
        {
            
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsAchieved.png"]];
            
        }else{
            
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsNotAchieved.png"]];
            
        }
        }
        
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"3"] objectForKey:@"workout_weight"] != nil) {
            
            if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"3"] objectForKey:@"workout_weight"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"3"] objectForKey:@"plan_weight"] integerValue])
            {
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightAchieved.png"]];
                
            } else {
                
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightNotAchieved.png"]];
            }
            
        }
    }
    
    }
    if ([_calDay getDay] == 4) {
        
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"4"] isKindOfClass:[NSDictionary class]]) {

        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"4"] objectForKey:@"workout_steps"] != nil) {
            
        if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"4"] objectForKey:@"workout_steps"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"4"] objectForKey:@"plan_steps"] integerValue])
        {
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsAchieved.png"]];
            
        }else{
            
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsNotAchieved.png"]];
            
        }
        }
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"4"] objectForKey:@"workout_weight"] != nil) {
            
            if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"4"] objectForKey:@"workout_weight"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"4"] objectForKey:@"plan_weight"] integerValue])
            {
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightAchieved.png"]];
                
            } else {
                
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightNotAchieved.png"]];
            }
            
        }
    
    }
    }
    if ([_calDay getDay] == 5) {
        
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"5"] isKindOfClass:[NSDictionary class]]) {

        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"5"] objectForKey:@"workout_steps"] != nil) {
            
        if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"5"] objectForKey:@"workout_steps"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"5"] objectForKey:@"plan_steps"] integerValue])
        {
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsAchieved.png"]];
            
        }else{
            
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsNotAchieved.png"]];
            
        }
        }
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"5"] objectForKey:@"workout_weight"] != nil) {
            
            if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"5"] objectForKey:@"workout_weight"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"5"] objectForKey:@"plan_weight"] integerValue])
            {
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightAchieved.png"]];
                
            } else {
                
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightNotAchieved.png"]];
            }
            
        }
    
    }
    }
    if ([_calDay getDay] == 6) {
        
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"6"] isKindOfClass:[NSDictionary class]]) {

        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"6"] objectForKey:@"workout_steps"] != nil) {
            
        if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"6"] objectForKey:@"workout_steps"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"6"] objectForKey:@"plan_steps"] integerValue])
        {
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsAchieved.png"]];
            
        }else{
            
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsNotAchieved.png"]];
            
        }
        }
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"6"] objectForKey:@"workout_weight"] != nil) {
            
            if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"6"] objectForKey:@"workout_weight"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"6"] objectForKey:@"plan_weight"] integerValue])
            {
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightAchieved.png"]];
                
            } else {
                
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightNotAchieved.png"]];
            }
            
        }
    
    }
    }
    if ([_calDay getDay] == 7) {
        
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"7"] isKindOfClass:[NSDictionary class]]) {

        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"7"] objectForKey:@"workout_steps"] != nil) {
            
        if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"7"] objectForKey:@"workout_steps"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"7"] objectForKey:@"plan_steps"] integerValue])
        {
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsAchieved.png"]];
            
        }else{
            
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsNotAchieved.png"]];
            
        }
        }
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"7"] objectForKey:@"workout_weight"] != nil) {
            
            if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"7"] objectForKey:@"workout_weight"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"7"] objectForKey:@"plan_weight"] integerValue])
            {
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightAchieved.png"]];
                
            } else {
                
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightNotAchieved.png"]];
            }
            
        }
    
    }
    }
    if ([_calDay getDay] == 8) {
        
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"8"] isKindOfClass:[NSDictionary class]]) {

        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"8"] objectForKey:@"workout_steps"] != nil) {
            
        if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"8"] objectForKey:@"workout_steps"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"8"] objectForKey:@"plan_steps"] integerValue])
        {
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsAchieved.png"]];
            
        }else{
            
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsNotAchieved.png"]];
            
        }
        }
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"8"] objectForKey:@"workout_weight"] != nil) {
            
            if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"8"] objectForKey:@"workout_weight"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"8"] objectForKey:@"plan_weight"] integerValue])
            {
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightAchieved.png"]];
                
            } else {
                
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightNotAchieved.png"]];
            }
            
        }
    }
    }
    if ([_calDay getDay] == 9) {
        
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"9"] isKindOfClass:[NSDictionary class]]) {

        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"9"] objectForKey:@"workout_steps"] != nil) {
            
        if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"9"] objectForKey:@"workout_steps"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"9"] objectForKey:@"plan_steps"] integerValue])
        {
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsAchieved.png"]];
            
        }else{
            
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsNotAchieved.png"]];
            
        }
        }
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"9"] objectForKey:@"workout_weight"] != nil) {
            
            if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"9"] objectForKey:@"workout_weight"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"9"] objectForKey:@"plan_weight"] integerValue])
            {
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightAchieved.png"]];
                
            } else {
                
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightNotAchieved.png"]];
            }
            
        }
    }
    }
    if ([_calDay getDay] == 10) {
        
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"10"] isKindOfClass:[NSDictionary class]]) {

        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"10"] objectForKey:@"workout_steps"] != nil) {
            
        if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"10"] objectForKey:@"workout_steps"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"10"] objectForKey:@"plan_steps"] integerValue])
        {
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsAchieved.png"]];
            
        }else{
            
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsNotAchieved.png"]];
            
        }
        }
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"10"] objectForKey:@"workout_weight"] != nil) {
            
            if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"10"] objectForKey:@"workout_weight"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"10"] objectForKey:@"plan_weight"] integerValue])
            {
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightAchieved.png"]];
                
            } else {
                
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightNotAchieved.png"]];
            }
            
        }
    }
    }
    if ([_calDay getDay] == 11) {
        
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"11"] isKindOfClass:[NSDictionary class]]) {

        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"11"] objectForKey:@"workout_steps"] != nil) {
            
        if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"11"] objectForKey:@"workout_steps"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"11"] objectForKey:@"plan_steps"] integerValue])
        {
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsAchieved.png"]];
            
        }else{
            
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsNotAchieved.png"]];
            
        }
        }
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"11"] objectForKey:@"workout_weight"] != nil) {
            
            if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"11"] objectForKey:@"workout_weight"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"11"] objectForKey:@"plan_weight"] integerValue])
            {
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightAchieved.png"]];
                
            } else {
                
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightNotAchieved.png"]];
            }
            
        }
    }
    }
        if ([_calDay getDay] == 12) {
            
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"12"] isKindOfClass:[NSDictionary class]]) {

        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"12"] objectForKey:@"workout_steps"] != nil) {
            
        if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"12"] objectForKey:@"workout_steps"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"12"] objectForKey:@"plan_steps"] integerValue])
        {
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsAchieved.png"]];
            
        }else{
            
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsNotAchieved.png"]];
            
        }
        }
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"12"] objectForKey:@"workout_weight"] != nil) {
            
            if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"12"] objectForKey:@"workout_weight"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"12"] objectForKey:@"plan_weight"] integerValue])
            {
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightAchieved.png"]];
                
            } else {
                
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightNotAchieved.png"]];
            }
            
        }
    }
    }
    
    if ([_calDay getDay] == 13) {
        
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"13"] isKindOfClass:[NSDictionary class]]) {

        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"13"] objectForKey:@"workout_steps"] != nil) {
            
        if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"13"] objectForKey:@"workout_steps"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"13"] objectForKey:@"plan_steps"] integerValue])
        {
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsAchieved.png"]];
            
        }else{
            
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsNotAchieved.png"]];
            
        }
        }
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"13"] objectForKey:@"workout_weight"] != nil) {
            
            if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"13"] objectForKey:@"workout_weight"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"13"] objectForKey:@"plan_weight"] integerValue])
            {
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightAchieved.png"]];
                
            } else {
                
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightNotAchieved.png"]];
            }
            
        }
    }
    }
    if ([_calDay getDay] == 14) {
        
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"14"] isKindOfClass:[NSDictionary class]]) {

        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"14"] objectForKey:@"workout_steps"] != nil) {
            
        if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"14"] objectForKey:@"workout_steps"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"14"] objectForKey:@"plan_steps"] integerValue])
        {
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsAchieved.png"]];
            
        }else{
            
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsNotAchieved.png"]];
            
        }
        }
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"14"] objectForKey:@"workout_weight"] != nil) {
            
            if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"14"] objectForKey:@"workout_weight"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"14"] objectForKey:@"plan_weight"] integerValue])
            {
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightAchieved.png"]];
                
            } else {
                
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightNotAchieved.png"]];
            }
            
        }
    }
    }
    
    if ([_calDay getDay] == 15) {
        
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"15"] isKindOfClass:[NSDictionary class]]) {

        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"15"] objectForKey:@"workout_steps"] != nil) {
            
        if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"15"] objectForKey:@"workout_steps"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"15"] objectForKey:@"plan_steps"] integerValue])
        {
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsAchieved.png"]];
            
        }else{
            
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsNotAchieved.png"]];
            
        }
        }
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"15"] objectForKey:@"workout_weight"] != nil) {
            
            if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"15"] objectForKey:@"workout_weight"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"15"] objectForKey:@"plan_weight"] integerValue])
            {
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightAchieved.png"]];
                
            } else {
                
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightNotAchieved.png"]];
            }
            
        }
    }
    }
    if ([_calDay getDay] == 16) {
     
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"16"] isKindOfClass:[NSDictionary class]]) {

        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"16"] objectForKey:@"workout_steps"] != nil) {
            
        if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"16"] objectForKey:@"workout_steps"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"16"] objectForKey:@"plan_steps"] integerValue])
        {
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsAchieved.png"]];
            
        }else{
            
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsNotAchieved.png"]];
            
        }
        }
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"16"] objectForKey:@"workout_weight"] != nil) {
            
            if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"16"] objectForKey:@"workout_weight"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"16"] objectForKey:@"plan_weight"] integerValue])
            {
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightAchieved.png"]];
                
            } else {
                
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightNotAchieved.png"]];
            }
            
        }
    }
    }
    if ([_calDay getDay] == 17) {

        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"17"] isKindOfClass:[NSDictionary class]]) {

        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"17"] objectForKey:@"workout_steps"] != nil) {
            
        if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"17"] objectForKey:@"workout_steps"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"17"] objectForKey:@"plan_steps"] integerValue])
        {
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsAchieved.png"]];
            
        }else{
            
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsNotAchieved.png"]];
            
        }
        }
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"17"] objectForKey:@"workout_weight"] != nil) {
            
            if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"17"] objectForKey:@"workout_weight"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"17"] objectForKey:@"plan_weight"] integerValue])
            {
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightAchieved.png"]];
                
            } else {
                
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightNotAchieved.png"]];
            }
            
        }
    }
    }
    if ([_calDay getDay] == 18) {
        
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"18"] isKindOfClass:[NSDictionary class]]) {

        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"18"] objectForKey:@"workout_steps"] != nil) {
            
        if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"18"] objectForKey:@"workout_steps"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"18"] objectForKey:@"plan_steps"] integerValue])
        {
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsAchieved.png"]];
            
        }else{
            
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsNotAchieved.png"]];

            
        }
        }
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"18"] objectForKey:@"workout_weight"] != nil) {
            
            if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"18"] objectForKey:@"workout_weight"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"18"] objectForKey:@"plan_weight"] integerValue])
            {
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightAchieved.png"]];
                
            } else {
                
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightNotAchieved.png"]];
            }
            
        }
    }
    }
    if ([_calDay getDay] == 19) {
        
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"19"] isKindOfClass:[NSDictionary class]]) {

        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"19"] objectForKey:@"workout_steps"] != nil) {
            
        if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"19"] objectForKey:@"workout_steps"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"19"] objectForKey:@"plan_steps"] integerValue])
        {
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsAchieved.png"]];
            
        }else{
            
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsNotAchieved.png"]];
            
        }
        }
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"19"] objectForKey:@"workout_weight"] != nil) {
            
            if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"19"] objectForKey:@"workout_weight"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"19"] objectForKey:@"plan_weight"] integerValue])
            {
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightAchieved.png"]];
                
            } else {
                
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightNotAchieved.png"]];
            }
            
        }
    }
    }
    if ([_calDay getDay] == 20) {

        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"20"] isKindOfClass:[NSDictionary class]]) {
    
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"20"] objectForKey:@"workout_steps"] != nil) {
            
        if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"20"] objectForKey:@"workout_steps"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"20"] objectForKey:@"plan_steps"] integerValue])
        {
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsAchieved.png"]];
            
        }else{
            
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsNotAchieved.png"]];
            
        }
        }
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"20"] objectForKey:@"workout_weight"] != nil) {
            
            if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"20"] objectForKey:@"workout_weight"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"20"] objectForKey:@"plan_weight"] integerValue])
            {
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightAchieved.png"]];
                
            } else {
                
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightNotAchieved.png"]];
            }
            
        }
    }
    }
     
    if ([_calDay getDay] == 21) {
        
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"21"] isKindOfClass:[NSDictionary class]]) {

        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"21"] objectForKey:@"workout_steps"] != nil) {
                
        if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"21"] objectForKey:@"workout_steps"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"21"] objectForKey:@"plan_steps"] integerValue])
        {
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsAchieved.png"]];
                
        }else{
                
            [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsNotAchieved.png"]];

                
        }
        }
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"21"] objectForKey:@"workout_weight"] != nil) {
                
        if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"21"] objectForKey:@"workout_weight"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"21"] objectForKey:@"plan_weight"] integerValue])
            {
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightAchieved.png"]];
                    
            } else {
                    
                [weightImage setImage:[UIImage imageNamed:@"Cal_WeightNotAchieved.png"]];
            }
                
        }
    }
    }
    if ([_calDay getDay] == 22) {
        
        if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"22"] isKindOfClass:[NSDictionary class]]) {

            if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"22"] objectForKey:@"workout_steps"] != nil) {
                
            if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"22"] objectForKey:@"workout_steps"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"22"] objectForKey:@"plan_steps"] integerValue])
            {
                [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsAchieved.png"]];
                
            }else{
                
                [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsNotAchieved.png"]];
                
            }
            }
            if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"22"] objectForKey:@"workout_weight"] != nil) {
                
                if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"22"] objectForKey:@"workout_weight"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"22"] objectForKey:@"plan_weight"] integerValue])
                {
                    [weightImage setImage:[UIImage imageNamed:@"Cal_WeightAchieved.png"]];
                    
                } else {
                    
                    [weightImage setImage:[UIImage imageNamed:@"Cal_WeightNotAchieved.png"]];
                }
                
            }
        }
    }
        if ([_calDay getDay] == 23) {
            
            if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"23"] isKindOfClass:[NSDictionary class]]) {

            if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"23"] objectForKey:@"workout_steps"] != nil) {
                
            if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"23"] objectForKey:@"workout_steps"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"23"] objectForKey:@"plan_steps"] integerValue])
            {
                [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsAchieved.png"]];
                
            }else{
                
                [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsNotAchieved.png"]];
                
            }
            }
            if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"23"] objectForKey:@"workout_weight"] != nil) {
                
                if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"23"] objectForKey:@"workout_weight"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"23"] objectForKey:@"plan_weight"] integerValue])
                {
                    [weightImage setImage:[UIImage imageNamed:@"Cal_WeightAchieved.png"]];
                    
                } else {
                    
                    [weightImage setImage:[UIImage imageNamed:@"Cal_WeightNotAchieved.png"]];
                    
                }
                
            }
        }
        }
        if ([_calDay getDay] == 24) {
            
            if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"24"] isKindOfClass:[NSDictionary class]]) {

            if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"24"] objectForKey:@"workout_steps"] != nil) {
                
            if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"24"] objectForKey:@"workout_steps"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"24"] objectForKey:@"plan_steps"] integerValue])
            {
                [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsAchieved.png"]];
                
            }else{
                
                [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsNotAchieved.png"]];
                
            }
            }
            if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"24"] objectForKey:@"workout_weight"] != nil) {
                
                if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"24"] objectForKey:@"workout_weight"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"24"] objectForKey:@"plan_weight"] integerValue])
                {
                    [weightImage setImage:[UIImage imageNamed:@"Cal_WeightAchieved.png"]];
                    
                } else {
                    
                    [weightImage setImage:[UIImage imageNamed:@"Cal_WeightNotAchieved.png"]];
                }
                
            }
        }
        }
        if ([_calDay getDay] == 25) {
            
            if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"25"] isKindOfClass:[NSDictionary class]]) {

            if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"25"] objectForKey:@"workout_steps"] != nil) {
                
            if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"25"] objectForKey:@"workout_steps"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"25"] objectForKey:@"plan_steps"] integerValue])
            {
                [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsAchieved.png"]];
                
            }else{
                
                [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsNotAchieved.png"]];
                
            }
            }
            if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"25"] objectForKey:@"workout_weight"] != nil) {
                
                if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"25"] objectForKey:@"workout_weight"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"25"] objectForKey:@"plan_weight"] integerValue])
                {
                    [weightImage setImage:[UIImage imageNamed:@"Cal_WeightAchieved.png"]];
                    
                } else {
                    
                    [weightImage setImage:[UIImage imageNamed:@"Cal_WeightNotAchieved.png"]];
                }
                
            }
        }
        }
        if ([_calDay getDay] == 26) {
            
            if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"26"] isKindOfClass:[NSDictionary class]]) {

            if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"26"] objectForKey:@"workout_steps"] != nil) {
                
            if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"26"] objectForKey:@"workout_steps"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"26"] objectForKey:@"plan_steps"] integerValue])
            {
                [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsAchieved.png"]];
                
            }else{
                
                [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsNotAchieved.png"]];
                
            }
            }
            if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"26"] objectForKey:@"workout_weight"] != nil) {
                
                if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"26"] objectForKey:@"workout_weight"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"26"] objectForKey:@"plan_weight"] integerValue])
                {
                    [weightImage setImage:[UIImage imageNamed:@"Cal_WeightAchieved.png"]];
                    
                } else {
                    
                    [weightImage setImage:[UIImage imageNamed:@"Cal_WeightNotAchieved.png"]];
                }
                
            }
        }
        }
        if ([_calDay getDay] == 27) {
            
            if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"27"] isKindOfClass:[NSDictionary class]]) {

            if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"27"] objectForKey:@"workout_steps"] != nil) {
                
            if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"27"] objectForKey:@"workout_steps"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"27"] objectForKey:@"plan_steps"] integerValue])
            {
                [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsAchieved.png"]];
                
            }else{
                
                [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsNotAchieved.png"]];
                
            }
            }
            if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"27"] objectForKey:@"workout_weight"] != nil) {
                
                if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"27"] objectForKey:@"workout_weight"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"27"] objectForKey:@"plan_weight"] integerValue])
                {
                    [weightImage setImage:[UIImage imageNamed:@"Cal_WeightAchieved.png"]];
                    
                } else {
                    
                    [weightImage setImage:[UIImage imageNamed:@"Cal_WeightNotAchieved.png"]];
                }
                
            }
        }
        }
        if ([_calDay getDay] == 28) {
            
            if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"28"] isKindOfClass:[NSDictionary class]]) {

            if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"28"] objectForKey:@"workout_steps"] != nil) {
                
            if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"27"] objectForKey:@"workout_steps"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"27"] objectForKey:@"plan_steps"] integerValue])
            {
                [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsAchieved.png"]];
                
            }else{
                
                [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsNotAchieved.png"]];
                
            }
            }
            if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"28"] objectForKey:@"workout_weight"] != nil) {
                
                if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"28"] objectForKey:@"workout_weight"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"28"] objectForKey:@"plan_weight"] integerValue])
                {
                    [weightImage setImage:[UIImage imageNamed:@"Cal_WeightAchieved.png"]];
                    
                } else {
                    
                    [weightImage setImage:[UIImage imageNamed:@"Cal_WeightNotAchieved.png"]];
                }
                
            }
        }
        }
        if ([_calDay getDay] == 29) {
            
            if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"29"] isKindOfClass:[NSDictionary class]]) {

            if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"29"] objectForKey:@"workout_steps"] != nil) {
                
            if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"29"] objectForKey:@"workout_steps"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"29"] objectForKey:@"plan_steps"] integerValue])
            {
                [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsAchieved.png"]];
                
            }else{
                
                [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsNotAchieved.png"]];
                
            }
            }
            if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"29"] objectForKey:@"workout_weight"] != nil) {
                
                if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"29"] objectForKey:@"workout_weight"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"29"] objectForKey:@"plan_weight"] integerValue])
                {
                    [weightImage setImage:[UIImage imageNamed:@"Cal_WeightAchieved.png"]];
                    
                } else {
                    
                    [weightImage setImage:[UIImage imageNamed:@"Cal_WeightNotAchieved.png"]];
                }
                
            }
        }
        }
        if ([_calDay getDay] == 30) {
            
            if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"30"] isKindOfClass:[NSDictionary class]]) {
            
            if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"30"] objectForKey:@"workout_steps"] != nil) {
                
            if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"30"] objectForKey:@"workout_steps"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"30"] objectForKey:@"plan_steps"] integerValue])
            {
                [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsAchieved.png"]];
                
            }else{
                
                [stepsImage setImage:[UIImage imageNamed:@"Cal_StepsNotAchieved.png"]];
                
            }
            }
            if ([[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"30"] objectForKey:@"workout_weight"] != nil) {
                
                if ([[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"30"] objectForKey:@"workout_weight"] integerValue]>=[[[[Globals sharedInstance].CalendarDataForStepsWeights objectForKey:@"30"] objectForKey:@"plan_weight"] integerValue])
                {
                    [weightImage setImage:[UIImage imageNamed:@"Cal_WeightAchieved.png"]];
                    
                } else {
                    
                    [weightImage setImage:[UIImage imageNamed:@"Cal_WeightNotAchieved.png"]];
                }
                
            }
        }

   
    }
    
}
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    [self setNeedsLayout];
}


- (void)dealloc 
{
    [gridButton release];
    [super dealloc];
}
@end
