//
//  PlanItem.h
//  iwown
//
//  Created by Apple on 14/01/2014.
//  Copyright (c) 2014 Ali Asghar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlanItem : NSObject

@property (strong,nonatomic) NSString *time;
@property (strong,nonatomic) NSString *desc;
@property (strong,nonatomic) NSString *reminder_id;

@end
