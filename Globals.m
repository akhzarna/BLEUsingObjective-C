//
//  Globals.m
//  Backgrounds
//
//  Created by Rajeel Amjad on 1/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Globals.h"
#import "CalendarItem.h"

@implementation Globals

//@synthesize currentImage,currentChin,frame,transform;

@synthesize txtView,selectFont,face,selectColor,charLimit,a,b,FourDigitCode,SaveMacAddressOfBracelet,calendarItem,isfromCalendar,CalendarDataForStepsWeights,isPlanChanged,isNewReminderAdded,isPlanChangedForMyDay,isPlanChangedDetailedView,isPlanEdited,isSettingsChanged;

static Globals *singletonObject = nil;
- (id) init
{
//	self = [super init];
	if (self = [super init]) {
//        currentImage = [[UIImage alloc]init];
//        currentChin = @"";
        
            txtView = @"";
            selectFont = @"";
            face = @"";
            selectColor = nil;
            charLimit = 0;
            a=135;
            b=0;
            SaveMacAddressOfBracelet = @"";
            FourDigitCode = @"";
        
        calendarItem = [[CalendarItem alloc]init];
        
        CalendarDataForStepsWeights = [[NSDictionary alloc]init];
        
        //dictFont = @"";
              
}
	return self;
}

+(Globals *) sharedInstance{
	@synchronized(self){
		if(singletonObject == nil){
			singletonObject = [[self alloc] init];
		}
	}
	return singletonObject;
}


@end
