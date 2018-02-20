//
//  CustomCellDevicesCell.h
//  iwown
//
//  Created by Akhzar Nazir on 13/02/2014.
//  Copyright (c) 2014 Ali Asghar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCellDevicesCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgDevices;
@property (weak, nonatomic) IBOutlet UIButton *btnBound;
@property (weak, nonatomic) IBOutlet UIButton *btnUnbound;
@property (weak, nonatomic) IBOutlet UIButton *btnConfig;
@property (weak, nonatomic) IBOutlet UIImageView *imgCheckUnCheck;

@end
