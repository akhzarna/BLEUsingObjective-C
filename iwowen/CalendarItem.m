//
//  CalendarItem.m
//  iwowen
//
//  Created by Apple on 10/12/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import "CalendarItem.h"

@implementation CalendarItem

-(id)initWithDict:(NSDictionary*)dict{
    self = [super init];
    
    if (self) {
        
        self.plan_id = [dict objectForKey:@"plan_id"];
        self.plan_steps = [dict objectForKey:@"plan_steps"];
        self.plan_title = [dict objectForKey:@"plan_title"];
        self.plan_weight = [dict objectForKey:@"plan_weight"];
        self.steps_percentage = [dict objectForKey:@"steps_percentage"];
        self.weight_percentage = [dict objectForKey:@"weight_percentage"];
        self.workout_stpes = [dict objectForKey:@"workout_steps"];
        self.workout_weight = [dict objectForKey:@"workout_weight"];
        self.update_date = [dict objectForKey:@"update_date"];
      }
    
    return self;
    
}

@end
