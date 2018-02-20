//
//  DevicesSearchViewController.h
//  iwowen
//
//  Created by Ali Asghar on 10/10/13.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BT.h"
#import "RNGridMenu.h"
#import "BaseViewController.h"
#import "RNBlurModalView.h"

@interface DevicesSearchViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,LeDiscoveryDelegate,RNGridMenuDelegate>{
    
    RNBlurModalView *modal;
    NSMutableArray *items;
    CBPeripheral* m_p;
    BT *bt;
    NSTimer *scanTimer;

}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) NSString *fourDigitTrimmedString;
@property (weak, nonatomic) IBOutlet UIView *myProfileView;
@property (weak, nonatomic) IBOutlet UIView *myDeviceView;
@property (weak, nonatomic) IBOutlet UIView *mySettingView;
@property (weak, nonatomic) IBOutlet UIImageView *myProfileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *mySettingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *myDevicesImageView;

- (IBAction)scan:(id)sender;
- (IBAction)backBtnClicked:(id)sender;

-(void)FourDidgitCodeAuth;

-(IBAction)MyProfileAction:(id)sender;
-(IBAction)MySettingAction:(id)sender;
-(IBAction)MyDevicesAction:(id)sender;

@end
