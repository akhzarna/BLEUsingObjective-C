//
//  DeviceData.m
//  iwowen
//
//  Created by Apple on 28/11/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import "DeviceData.h"

@implementation DeviceData

-(NSString*)description{
  
    NSMutableString *desc = [[NSMutableString alloc]init];
    
    [desc appendFormat:@"hour = %@", _hour];
    [desc appendFormat:@"/nday = %@", _day];
    [desc appendFormat:@"/nmonth = %@", _month];
    [desc appendFormat:@"/nyear = %@", _year];
    [desc appendFormat:@"/nhourSteps = %@", _hourSteps];
    [desc appendFormat:@"/nhourDistance = %@", _hourDistance];
    [desc appendFormat:@"/nhourCalories = %@", _hourCalories];
    [desc appendFormat:@"/ndaySteps = %@", _daySteps];
    [desc appendFormat:@"/ndayDistance = %@", _dayDistance];
    [desc appendFormat:@"/ndayCalories = %@", _dayCalories];
    
    return desc;

}

@end
