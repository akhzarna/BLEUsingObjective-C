//
//  CalendarItem.h
//  iwowen
//
//  Created by Apple on 10/12/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarItem : NSObject

-(id)initWithDict:(NSDictionary*)dict;

@property (strong,nonatomic)NSString *plan_id;
@property (strong,nonatomic)NSString *plan_steps;
@property (strong,nonatomic)NSString *plan_title;
@property (strong,nonatomic)NSString *plan_weight;
@property (strong,nonatomic)NSString *steps_percentage;
@property (strong,nonatomic)NSString *weight_percentage;
@property (strong,nonatomic)NSString *workout_stpes;
@property (strong,nonatomic)NSString *workout_weight;
@property (strong,nonatomic)NSString *update_date;
@property (strong,nonatomic)NSString *date;


@end
