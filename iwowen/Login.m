//
//  Login.m
//  iwowen
//
//  Created by Omer Waqas Khan on 23/11/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import "Login.h"
#import "AccountViewController.h"
#import "SignUp.h"

@interface Login ()

@end

@implementation Login

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([[UIScreen mainScreen]bounds].size.height == 480) {
        [_viewBottom setFrame:CGRectMake(0, 442, _viewBottom.bounds.size.width, _viewBottom.bounds.size.height)];
    }
    
    [self.view addSubview:_viewBottom];
    NSString *rememberMe = (NSString*)[UserDefaultsUtil getObjectForKey:@"Remember_Me"];
    if(rememberMe == nil){
        [UserDefaultsUtil setObject:@"true" forKey:@"Remember_Me"];
    }else if([rememberMe isEqualToString:@"true"]){
        [_remeberMeImageView setImage:[UIImage imageNamed:@"checked.png"]];
        if ([UserDefaultsUtil getObjectForKey:@"username"] != nil && [UserDefaultsUtil getObjectForKey:@"password"] != nil) {
            [self autologin];
        }
    }else{
        [_remeberMeImageView setImage:[UIImage imageNamed:@"unchecked.png"]];
    }
    [self registerForKeyboardNotifications];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

- (void)registerForKeyboardNotifications
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    CGPoint origin = activeField.frame.origin;
    origin.y -= _scrollView.contentOffset.y-30;
    if (!CGRectContainsPoint(aRect, origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-(aRect.size.height-30));
        [_scrollView setContentOffset:scrollPoint animated:YES];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)autologin{
    @try{
        @autoreleasepool {
            [self startProgressView];
            NSString *params = @"login=";
            params = [params stringByAppendingString:(NSString*)[UserDefaultsUtil getObjectForKey:@"username"]];
            params = [params stringByAppendingString:@"&password="];
            params = [params stringByAppendingString:(NSString*)[UserDefaultsUtil getObjectForKey:@"password"]];
            
            [self sendPostRequestTo:@"auth/login" withParams:params action:@selector(loginRequestComplete:)];
        }
    }@catch (NSException *exception) {
        NSLog(@"Exception :::: %@",[exception debugDescription]);
    }
}

-(BOOL)isValidateFields{
    
    if ([[_userName text] isEqualToString:@""] || [[_password text] isEqualToString:@""]) {
        return FALSE;
    }else{
        return TRUE;
    }
    
}


- (IBAction)signIn:(id)sender {
    
    if ([self isValidateFields]) {
        
        NSString *rememberMe = (NSString*)[UserDefaultsUtil getObjectForKey:@"Remember_Me"];
        
        if([rememberMe isEqualToString:@"true"]){
            
            [UserDefaultsUtil setObject:self.userName.text forKey:@"username"];
            [UserDefaultsUtil setObject:self.password.text forKey:@"password"];
            
        }
        
        @try{
            
            @autoreleasepool {
                
                [self startProgressView];
                
                NSString *params = @"login=";
                params = [params stringByAppendingString:self.userName.text];
                params = [params stringByAppendingString:@"&password="];
                params = [params stringByAppendingString:self.password.text];
                
                [self sendPostRequestTo:@"auth/login" withParams:params action:@selector(loginRequestComplete:)];
            }
            
        }@catch (NSException *exception) {
        }

    }else{
        
        modal = [[RNBlurModalView alloc]initWithViewController:self title:@"Warning" message:@"All fields are required."];
        [modal show];
        [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(HideAlertView) userInfo:nil repeats:NO];
    }
    
}


- (IBAction)signUp:(id)sender {
    
    [self performSegueWithIdentifier:@"SToSignUp" sender:self];
}


- (IBAction)unwindToLogin:(UIStoryboardSegue *)unwindSegue
{
    
    UIViewController* sourceViewController = unwindSegue.sourceViewController;
    
    if ([sourceViewController isKindOfClass:[AccountViewController class]])
    {
    }
    else if ([sourceViewController isKindOfClass:[SignUp class]])
    {
    }
}

- (IBAction)rememberMeBtnClicked:(id)sender {
    
    NSString *rememberMe = (NSString*)[UserDefaultsUtil getObjectForKey:@"Remember_Me"] ;
    if([rememberMe isEqualToString:@"false"]){
        [_remeberMeImageView setImage:[UIImage imageNamed:@"checked.png"]];
        [UserDefaultsUtil setObject:@"true" forKey:@"Remember_Me"];
    }else{
        [_remeberMeImageView setImage:[UIImage imageNamed:@"unchecked.png"]];
        [UserDefaultsUtil setObject:@"false" forKey:@"Remember_Me"];
    }
}

-(void)loginRequestComplete:(NSData *)data{
    
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
        }else if ([status isEqualToString:@"failure"]){
            modal = [[RNBlurModalView alloc]initWithViewController:self title:@"Warning" message:@"Username or password incorrect"];
            [modal show];
            [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(HideAlertView) userInfo:nil repeats:NO];
        }else if ([status isEqualToString:@"success"]){
            [UserDefaultsUtil setObject:[responseDict objectForKey:@"user_id"] forKey:@"user_id"];
            [self performSegueWithIdentifier:@"SToMain" sender:self];
        }
    }
}


-(void) HideAlertView{
    
    [modal hide];
}

#pragma mark - UITextField Delegates

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == _password) {
        
        if ([string isEqualToString:@""]) {
            return YES;
        }else if ([_password.text length] >=4) {
            return NO;
        }
        
    }
    
    return YES;
    
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    if([[UIScreen mainScreen] bounds].size.height == 568) {
    }
    else if([[UIScreen mainScreen] bounds].size.height == 480){
        if (textField == _userName) {
            self.view.center = CGPointMake(self.view.center.x, 240);
        }
        if (textField == _password) {
            self.view.center = CGPointMake(self.view.center.x, 200);
        }
    }
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
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


- (void)viewDidUnload {
    
    [self setRememberMeBtn:nil];
    [super viewDidUnload];
    
}

@end
