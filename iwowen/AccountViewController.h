//
//  AccountViewController.h
//  iwowen
//
//  Created by Apple on 22/11/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractActionSheetPicker.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <QuartzCore/QuartzCore.h>

#import "BaseViewController.h"
#import "BRRequest.h"
#import "BRRequestListDirectory.h"
#import "BRRequestUpload.h"
#import "UltrafitnessTextField.h"
#import "UIImage+RoundedImage.h"
#import "UIImage+Alpha.h"
#import "Login.h"

@interface AccountViewController : BaseViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate,BRRequestDelegate> {
    
    RNBlurModalView *modal;
    
    NSMutableArray *genderArray;
    NSMutableArray *heightArray;
    NSMutableArray *ageArray;
    NSMutableArray *weightArray;
    
    BRRequestListDirectory *listDir;
    BRRequestUpload *uploadFile;
    
    NSData *uploadData;
    
    NSString *uploadedImageURL;
    
    NSArray *currentSettings;
    NSDictionary *currentSettingsDict;
    
}

@property (strong,nonatomic)AbstractActionSheetPicker *genderActionSheetPicker;
@property (strong,nonatomic)AbstractActionSheetPicker *heightActionSheetPicker;
@property (strong,nonatomic)AbstractActionSheetPicker *ageActionSheetPicker;
@property (strong,nonatomic)AbstractActionSheetPicker *weightActionSheetPicker;
@property (weak, nonatomic) IBOutlet UIImageView *userProfileImage;

@property (weak, nonatomic) IBOutlet UILabel *genderLbl;
@property (weak, nonatomic) IBOutlet UILabel *heightLbl;
@property (weak, nonatomic) IBOutlet UILabel *ageLbl;
@property (weak, nonatomic) IBOutlet UILabel *weightLbl;

@property (weak, nonatomic) IBOutlet UILabel *weightUnitLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UltrafitnessTextField *emailTextField;
@property (strong, nonatomic) IBOutlet UltrafitnessTextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UltrafitnessTextField *nicknameTextField;
@property (weak, nonatomic) IBOutlet UIView *mySettingView;
@property (weak, nonatomic) IBOutlet UIView *myDeviceView;
@property (weak, nonatomic) IBOutlet UIImageView *nameImageView;
@property (weak, nonatomic) IBOutlet UIImageView *emailImageView;

@property (weak, nonatomic) IBOutlet UIButton *genderBtn;
@property (weak, nonatomic) IBOutlet UIButton *ageBtn;
@property (weak, nonatomic) IBOutlet UIButton *heightBtn;
@property (weak, nonatomic) IBOutlet UIButton *weightBtn;
@property (weak, nonatomic) IBOutlet UILabel *heightUnitLabel;
@property (weak, nonatomic) IBOutlet UIView *myProfileView;
@property (weak, nonatomic) IBOutlet UIImageView *myProfileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *mySettingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *myDevicesImageView;
@property (weak, nonatomic) IBOutlet UILabel *heightLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;


- (IBAction)genderBtnClicked:(id)sender;
- (IBAction)heightBtnClicked:(id)sender;
- (IBAction)ageBtnClicked:(id)sender;
- (IBAction)weightBtnClicked:(id)sender;

- (IBAction)backBtnClicked:(id)sender;
- (IBAction)selectProfilePic:(id)sender;

- (IBAction)updateProfile:(id)sender;
- (IBAction)logoutBtnClicked:(id)sender;

- (IBAction)unwindToRed:(UIStoryboardSegue *)unwindSegue;

-(IBAction)MyProfileAction:(id)sender;
-(IBAction)MySettingAction:(id)sender;
-(IBAction)MyDevicesAction:(id)sender;


@end
