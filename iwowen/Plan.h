//
//  Plan.h
//  iwowen
//
//  Created by Apple on 27/11/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Plan : NSObject

-(id)initWithDict:(NSDictionary*)dict;

@property (strong,nonatomic) NSString *plan_id;
@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *desc;
@property (strong,nonatomic )NSString *image;
@property (strong,nonatomic) NSData *imageData;
@property (strong,nonatomic) NSString *start_date;
@property (strong,nonatomic) NSString *end_date;
@property (strong,nonatomic) NSString *steps;
@property (strong,nonatomic) NSString *weight;
@property (strong,nonatomic) NSString *alarm_time;
@property (strong,nonatomic) NSString *type;
@property (strong,nonatomic) NSString *status;
@property (strong,nonatomic) NSString *user_id;
@property (strong,nonatomic) NSString *insert_date;
@property (strong,nonatomic) NSString *update_date;

@end
