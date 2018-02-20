//
//  NSDate+ADNExtensions.m
//  iwowen
//
//  Created by Apple on 16/12/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import "NSDate+ADNExtensions.h"

@implementation NSDate (ADNExtensions)

- (NSInteger)numberOfDaysUntil:(NSDate *)aDate {
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit fromDate:self toDate:aDate options:0];
    
    return [components day];
    
}

@end
