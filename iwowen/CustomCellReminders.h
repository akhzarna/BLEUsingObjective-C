//
//  CustomCellReminders.h
//  iwown
//
//  Created by Akhzar Nazir on 28/02/2014.
//  Copyright (c) 2014 Ali Asghar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCellReminders : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeAlarm;
@property (weak, nonatomic) IBOutlet UILabel *descriptionAlarm;
@property (weak, nonatomic) IBOutlet UIButton *deleteAlarmButton;

@end
