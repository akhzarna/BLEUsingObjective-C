//
//  ViewController.m
//  iwowen
//
//  Created by Ali Asghar on 10/10/13.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import "SignUp.h"

@interface SignUp ()

@end

@implementation SignUp


- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)joinBtnClicked:(id)sender {
    
    @try{
        @autoreleasepool {
            
            if ([self validateFields]) {
                
                if ([self NSStringIsValidEmail:self.emailTxtField.text]) {
                    
                if ([self passwordMatch]) {
                    
                [self startProgressView];
                
                NSString *params = @"username=";
                params = [params stringByAppendingString:self.usernameTxtFld.text];
                params = [params stringByAppendingString:@"&gender="];
                params = [params stringByAppendingString:self.genderLbl.text];
                params = [params stringByAppendingString:@"&height="];
                params = [params stringByAppendingString:self.heightLbl.text];
                params = [params stringByAppendingString:@"&age="];
                params = [params stringByAppendingString:self.ageLbl.text];
                params = [params stringByAppendingString:@"&weight="];
                params = [params stringByAppendingString:self.weightLbl.text];
                params = [params stringByAppendingString:@"&email="];
                params = [params stringByAppendingString:self.emailTxtField.text];
                params = [params stringByAppendingString:@"&password="];
                params = [params stringByAppendingString:self.passwordTxtFld.text];
                params = [params stringByAppendingString:@"&confirm_password="];
                params = [params stringByAppendingString:self.passwordTxtFld.text];
                
                [self sendPostRequestTo:@"auth/register" withParams:params action:@selector(registerRequestComplete:)];

            }else{
                modal = [[RNBlurModalView alloc]initWithViewController:self title:@"Warning" message:@"Password mis-match."];
                
                [modal show];
                
                [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(HideAlertView) userInfo:nil repeats:NO];
            }
                }else{
                    
                    modal = [[RNBlurModalView alloc]initWithViewController:self title:@"Warning" message:@"Enter valid email address."];
                    
                    [modal show];
                    
                    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(HideAlertView) userInfo:nil repeats:NO];

                }
            } else{
                
                modal = [[RNBlurModalView alloc]initWithViewController:self title:@"Warning" message:@"All fields are required."];
                
                [modal show];
                
                [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(HideAlertView) userInfo:nil repeats:NO];

            }
}

    }@catch (NSException *exception) {
        NSLog(@"Exception :::: %@",[exception debugDescription]);
    }
}

-(BOOL)passwordMatch{

    if ([[_reEnterPwdTxtFiled text] isEqualToString:[_passwordTxtFld text]]) {
        
        return YES;
    }else{
        
        return NO;
    }
}


-(BOOL)validateFields{
    if(ageSelected && weightSelected && heightSelected && genderSelected && self.emailTxtField.text.length > 0 && self.passwordTxtFld.text.length > 0 && self.usernameTxtFld.text.length > 0){
        return YES;
     }
    return NO;
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

-(void)registerRequestComplete:(NSData *)data{
    
    NSString *response = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    [self stopProgressView];
    NSError *error;
    NSDictionary *responseDict = [NSJSONSerialization
                                  JSONObjectWithData:data
                                  options:kNilOptions
                                  error:&error];
    if( error )
    {
        NSLog(@"%@", [error localizedDescription]);
    }else {
        
        NSString *status = [responseDict objectForKey:@"status"];
        if([status isEqualToString:@"warning"]){
            modal = [[RNBlurModalView alloc]initWithViewController:self title:@"Warning" message:[[responseDict objectForKey:@"error_message"] objectAtIndex:0]];
            [modal show];
            [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(HideAlertView) userInfo:nil repeats:NO];
            
        }else if([status isEqualToString:@"failure"]){
            NSLog(@"failure");
            
            modal = [[RNBlurModalView alloc]initWithViewController:self title:@"Warning" message:[responseDict objectForKey:@"message"]];
            [modal show];
            [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(HideAlertView) userInfo:nil repeats:NO];
        }else if ([status isEqualToString:@"success"]){
            
            [UserDefaultsUtil setObject:[responseDict objectForKey:@"user_id"] forKey:@"user_id"];
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count -2] animated:YES];
        
        }
    }    
}

-(void) HideAlertView{
    
    [modal hide];
}

- (void)viewDidUnload {
    
    [self setGenderLbl:nil];
    [self setHeightLbl:nil];
    [self setAgeLbl:nil];
    [self setWeightLbl:nil];
    [self setEmailTxtField:nil];
    [self setPasswordTxtFld:nil];
    [self setUsernameTxtFld:nil];
    [self setGenderBtn:nil];
    [self setHeightBtn:nil];
    [self setAgeBtn:nil];
    [self setWeightBtn:nil];
    [super viewDidUnload];
    
}

- (IBAction)genderBtnClicked:(id)sender {
    genderArray = [[NSMutableArray alloc]initWithObjects:@"Male",@"Female", nil];
    _genderActionSheetPicker = [ActionSheetStringPicker showPickerWithTitle:@"Select Gender" rows:genderArray initialSelection:0 target:self sucessAction:@selector(genderWasSelected:element:) cancelAction:nil origin:sender];
}

- (IBAction)heightBtnClicked:(id)sender {
    heightArray = [[NSMutableArray alloc]init];
    for (int i = 30; i < 86 ; i++) {
        [heightArray addObject:[NSString stringWithFormat:@"%i",i]];
    }
    _heightActionSheetPicker = [ActionSheetStringPicker showPickerWithTitle:@"Select Height" rows:heightArray initialSelection:0 target:self sucessAction:@selector(heightWasSelected:element:) cancelAction:nil origin:sender];
}

- (IBAction)ageBtnClicked:(id)sender {
    ageArray = [[NSMutableArray alloc]init];
    for (int i = 10; i < 80 ; i++) {
        [ageArray addObject:[NSString stringWithFormat:@"%i",i]];
    }
    _ageActionSheetPicker = [ActionSheetStringPicker showPickerWithTitle:@"Select Age" rows:ageArray initialSelection:0 target:self sucessAction:@selector(ageWasSelected:element:) cancelAction:nil origin:sender];
}

- (IBAction)weightBtnClicked:(id)sender {
    
    weightArray = [[NSMutableArray alloc]init];
    for (int i = 30; i < 300 ; i++) {
        [weightArray addObject:[NSString stringWithFormat:@"%i",i]];
    }
    _weightActionSheetPicker = [ActionSheetStringPicker showPickerWithTitle:@"Select Weight" rows:weightArray initialSelection:0 target:self sucessAction:@selector(weightWasSelected:element:) cancelAction:nil origin:sender];
    
}

#pragma mark - Combo Return Methods

- (void)genderWasSelected:(NSNumber *)selectedIndex element:(id)element {
    genderSelected = YES;
    self.genderLbl.text = [genderArray objectAtIndex:selectedIndex.intValue];
}

- (void)heightWasSelected:(NSNumber *)selectedIndex element:(id)element {
    heightSelected = YES;
    self.heightLbl.text = [heightArray objectAtIndex:selectedIndex.intValue];
}

- (void)ageWasSelected:(NSNumber *)selectedIndex element:(id)element {
    ageSelected = YES;
    self.ageLbl.text = [ageArray objectAtIndex:selectedIndex.intValue];
}

- (void)weightWasSelected:(NSNumber *)selectedIndex element:(id)element {
    weightSelected = YES;
    self.weightLbl.text = [weightArray objectAtIndex:selectedIndex.intValue];
}

#pragma mark - UITextField Delegates

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    if([[UIScreen mainScreen] bounds].size.height == 568) {
    }
    else if([[UIScreen mainScreen] bounds].size.height == 480){
        if (textField == _usernameTxtFld) {
            self.view.center = CGPointMake(self.view.center.x, 240);
        }
        if (textField == _emailTxtField) {
            self.view.center = CGPointMake(self.view.center.x, 240);
        }
        if (textField == _passwordTxtFld) {
            self.view.center = CGPointMake(self.view.center.x, 200);
        }
        if (textField == _reEnterPwdTxtFiled) {
            self.view.center = CGPointMake(self.view.center.x, 190);
        }
    }
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    if([[UIScreen mainScreen] bounds].size.height == 568) {
        self.view.center = CGPointMake(self.view.center.x,284);
    }
    else if([[UIScreen mainScreen] bounds].size.height == 480){
        self.view.center = CGPointMake(self.view.center.x, 240);
    }
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == _passwordTxtFld) {
        if ([string isEqualToString:@""]) {
            return YES;
        }else if ([_passwordTxtFld.text length] >=4) {
            return NO;
        }
    }
    if (textField == _reEnterPwdTxtFiled) {
        if ([string isEqualToString:@""]) {
            return YES;
        }else if ([_reEnterPwdTxtFiled.text length] >=4) {
            return NO;
        }
    }
    return YES;
}


- (IBAction)signIn:(id)sender {
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count -2] animated:YES];
}

-(IBAction)SignInAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
