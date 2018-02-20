//
//  DeviceData.h
//  iwowen
//
//  Created by Apple on 28/11/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceData : NSObject

@property (strong,nonatomic)NSString *hour;
@property (strong,nonatomic)NSString *day;
@property (strong,nonatomic)NSString *month;
@property (strong,nonatomic)NSString *year;
@property (strong,nonatomic)NSString *hourSteps;
@property (strong,nonatomic)NSString *hourDistance;
@property (strong,nonatomic)NSString *hourCalories;
@property (strong,nonatomic)NSString *daySteps;
@property (strong,nonatomic)NSString *dayDistance;
@property (strong,nonatomic)NSString *dayCalories;

@end
