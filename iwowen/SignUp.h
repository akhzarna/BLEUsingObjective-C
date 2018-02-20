//
//  SignUp.h
//  iwowen
//
//  Created by Ali Asghar on 10/10/13.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseViewController.h"
#import "AbstractActionSheetPicker.h"
#import "ActionSheetStringPicker.h"
#import "SMWebRequest.h"
#import "Constants.h"
#import "RNBlurModalView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImage+Alpha.h"
#import "UIImage+RoundedImage.h"

@interface SignUp : BaseViewController <UITextFieldDelegate>{
    
    RNBlurModalView *modal;
    BOOL genderSelected;
    BOOL ageSelected;
    BOOL heightSelected;
    BOOL weightSelected;
    
    NSMutableArray *genderArray;
    NSMutableArray *heightArray;
    NSMutableArray *ageArray;
    NSMutableArray *weightArray;

}
@property (strong,nonatomic)AbstractActionSheetPicker *genderActionSheetPicker;
@property (strong,nonatomic)AbstractActionSheetPicker *heightActionSheetPicker;
@property (strong,nonatomic)AbstractActionSheetPicker *ageActionSheetPicker;
@property (strong,nonatomic)AbstractActionSheetPicker *weightActionSheetPicker;

@property (weak, nonatomic) IBOutlet UITextField *reEnterPwdTxtFiled;
@property (weak, nonatomic) IBOutlet UIImageView *weightImageView;
@property (weak, nonatomic) IBOutlet UIImageView *heightImageView;
@property (weak, nonatomic) IBOutlet UIImageView *ageImageView;
@property (weak, nonatomic) IBOutlet UIImageView *genderImageView;
@property (weak, nonatomic) IBOutlet UILabel *genderLbl;
@property (weak, nonatomic) IBOutlet UILabel *heightLbl;
@property (weak, nonatomic) IBOutlet UILabel *ageLbl;
@property (weak, nonatomic) IBOutlet UILabel *weightLbl;

@property (weak, nonatomic) IBOutlet UIButton *genderBtn;
@property (weak, nonatomic) IBOutlet UIButton *heightBtn;
@property (weak, nonatomic) IBOutlet UIButton *ageBtn;
@property (weak, nonatomic) IBOutlet UIButton *weightBtn;

@property (weak, nonatomic) IBOutlet UITextField *emailTxtField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *usernameTxtFld;

- (IBAction)genderBtnClicked:(id)sender;
- (IBAction)heightBtnClicked:(id)sender;
- (IBAction)ageBtnClicked:(id)sender;
- (IBAction)weightBtnClicked:(id)sender;
- (IBAction)SignInAction:(id)sender;

- (IBAction)signIn:(id)sender;
- (IBAction)joinBtnClicked:(id)sender;

@end
