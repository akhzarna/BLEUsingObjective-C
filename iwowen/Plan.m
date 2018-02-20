//
//  Plan.m
//  iwowen
//
//  Created by Apple on 27/11/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import "Plan.h"

@implementation Plan

-(id)initWithDict:(NSDictionary*)dict{
    
    self = [super init];
    
    if (self) {
    
        self.plan_id = [dict objectForKey:@"plan_id"];
        self.title = [dict objectForKey:@"title"];
        self.desc = [dict objectForKey:@"description"];
        self.image = [dict objectForKey:@"image"];
        self.start_date = [dict objectForKey:@"start_date"];
        self.end_date = [dict objectForKey:@"end_date"];
        self.steps = [dict objectForKey:@"steps"];
        self.weight = [dict objectForKey:@"weight"];
        self.alarm_time = [dict objectForKey:@"alarm_time"];
        self.type = [dict objectForKey:@"type"];
        self.status = [dict objectForKey:@"status"];
        self.user_id = [dict objectForKey:@"user_id"];
        self.insert_date = [dict objectForKey:@"insert_date"];
        self.update_date = [dict objectForKey:@"update_date"];
        
    }
    return self;
}

@end
