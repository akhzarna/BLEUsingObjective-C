//
//  SettingViewController.h
//  iwowen
//
//  Created by Apple on 22/11/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "RNBlurModalView.h"

@interface SettingViewController : BaseViewController{
    
    RNBlurModalView *modal;
    NSArray *currentSettings;
    NSDictionary *currentSettingsDict;

}

@property (nonatomic, strong) IBOutlet UIImageView *kilogramImage;
@property (nonatomic, strong) IBOutlet UIImageView *poundImage;

@property (nonatomic, strong) IBOutlet UIImageView *inchesImage;
@property (nonatomic, strong) IBOutlet UIImageView *meterImage;

@property (nonatomic, strong) IBOutlet UIImageView *englishImage;
@property (nonatomic, strong) IBOutlet UIImageView *chinaImage;
@property (weak, nonatomic) IBOutlet UIImageView *myProfileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *mySettingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *myDevicesImageView;

@property (weak, nonatomic) IBOutlet UITextField *weightLbl;
@property (weak, nonatomic) IBOutlet UITextField *heightLbl;
@property (weak, nonatomic) IBOutlet UIView *myProfileView;
@property (weak, nonatomic) IBOutlet UIView *mySettingView;
@property (weak, nonatomic) IBOutlet UIView *myDeviceView;

- (IBAction)backBtnClicked:(id)sender;
- (IBAction)weightUnitBtnClicked:(id)sender;
- (IBAction)heightUnitBtnClicked:(id)sender;

- (IBAction)languageBtnClicked:(id)sender;

- (IBAction)saveSetting:(id)sender;

-(IBAction)MyProfileAction:(id)sender;
-(IBAction)MySettingAction:(id)sender;
-(IBAction)MyDevicesAction:(id)sender;
- (void)getCurrentSettings;

@end
