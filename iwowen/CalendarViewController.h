//
//  CalendarViewController.h
//  iwowen
//
//  Created by Apple on 22/11/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITTCalendarView.h"
#import "ITTBaseDataSourceImp.h"
#import "BaseViewController.h"
#import "CalendarItem.h"
#import "CalendarItemViewController.h"

@interface CalendarViewController : BaseViewController<ITTCalendarViewDelegate>{
   
    ITTCalendarView *calendar;
    NSMutableDictionary *datesDict;
    NSMutableDictionary *calendarItemsDict;
    
    CalendarItem *selectedItem;
}

- (IBAction)settingsBtnClicked:(id)sender;
- (IBAction)planBtnClicked:(id)sender;
-(IBAction)BackAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *calendarView;
@property (weak, nonatomic) IBOutlet UITextView *remindersTV;

@end
