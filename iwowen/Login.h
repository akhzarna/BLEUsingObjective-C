//
//  Login.h
//  iwowen
//
//  Created by Omer Waqas Khan on 23/11/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "RNBlurModalView.h"

@interface Login : BaseViewController {
    
    UITextField *activeField;
    
    RNBlurModalView *modal;
    
}

@property (weak, nonatomic) IBOutlet UIImageView *loginImageView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordImageView;

@property (weak, nonatomic) IBOutlet UIImageView *remeberMeImageView;
@property (weak, nonatomic) IBOutlet UIButton *rememberMeImageView;
@property (nonatomic, strong) IBOutlet UITextField *userName;
@property (nonatomic, strong) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *rememberMeBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *viewBottom;


- (IBAction)signIn:(id)sender;

- (IBAction)signUp:(id)sender;
- (IBAction)rememberMeBtnClicked:(id)sender;
- (IBAction)unwindToLogin:(UIStoryboardSegue *)unwindSegue;

-(void)setBorderColorForTextField:(UITextField*)textField;

@end
