//
//  Globals.h
//  Backgrounds
//
//  Created by Rajeel Amjad on 1/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalendarItem.h"

@interface Globals : NSObject {
    /*    
    UIImage * currentImage;
    NSString * currentChin;
    CGRect frame;
    CGAffineTransform transform;
    */
    NSString *face;
    NSString *txtView;
    NSString *selectFont;
    UIColor *selectColor;
    int charLimit;
    int a;
    int b;
    
    // For FaceBook Buttons...
    //int face=0;
    //NSMutableDictionary *dictFont;
    
}

@property (strong,nonatomic) CalendarItem *calendarItem;
@property (strong,nonatomic) NSDictionary *CalendarDataForStepsWeights;
@property (nonatomic, retain) NSString *face;
@property (nonatomic, retain) NSString *txtView;
@property (nonatomic, retain) NSString *selectFont;
@property (nonatomic, retain) NSString *FourDigitCode;
@property (nonatomic, retain) NSString *SaveMacAddressOfBracelet;
@property (nonatomic, retain) UIColor *selectColor;
@property (nonatomic) int charLimit;
@property (nonatomic) int a;
@property (nonatomic) int b;
@property (assign)BOOL isfromCalendar;
@property (assign)BOOL isPlanChanged;
@property (assign)BOOL isPlanChangedDetailedView;
@property (assign)BOOL isPlanChangedForMyDay;
@property (assign)BOOL isNewReminderAdded;
@property (assign)BOOL isPlanEdited;
@property (assign)BOOL isSettingsChanged;
/*
@property (nonatomic, retain) UIImage * currentImage;
@property (nonatomic, retain)  NSString * currentChin;
@property (nonatomic) CGRect frame;
@property (nonatomic) CGAffineTransform transform;
*/

+(Globals *) sharedInstance;

@end
