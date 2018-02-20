//
//  AccountViewController.m
//  iwowen
//
//  Created by Apple on 22/11/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import "AccountViewController.h"
#import "ActionSheetStringPicker.h"
#import "SettingViewController.h"
#import "DevicesSearchViewController.h"
#import "AsyncImageView.h"
#import "Globals.h"

@interface AccountViewController ()

@end

@implementation AccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)tappedLeftButton:(id)sender
{
    
    [self performSegueWithIdentifier:@"SToSetting" sender:self];
}

- (IBAction)tappedRightButton:(id)sender{
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedLeftButton:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedRightButton:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
    UIImage *image = [UIImage imageNamed:@"face place holder 45x45.png"];
    self.userProfileImage.image = [UIImage roundedImageWithImage:[image imageWithAlpha]];
    [self SetBorderColorForImageView:_nameImageView];
    [self SetBorderColorForImageView:_emailImageView];
    [self SetBorderColorForButton:_ageBtn];
    [self SetBorderColorForButton:_weightBtn];
    [self SetBorderColorForButton:_genderBtn];
    [self SetBorderColorForButton:_heightBtn];
    [self getProfile];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [_myProfileImageView setImage:[UIImage imageNamed:@"green_larg.png"]];
    [_mySettingImageView setImage:[UIImage imageNamed:@"gray_larg.png"]];
    [_myDevicesImageView setImage:[UIImage imageNamed:@"gray_larg.png"]];
    if ([Globals sharedInstance].isSettingsChanged) {
        [self getProfile];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    
    [self setGenderLbl:nil];
    [self setHeightLbl:nil];
    [self setAgeLbl:nil];
    [self setWeightLbl:nil];
    [self setUserProfileImage:nil];
    [self setGenderBtn:nil];
    [self setAgeBtn:nil];
    [self setHeightBtn:nil];
    [self setWeightBtn:nil];
    [super viewDidUnload];
    
}

- (void)getProfile {
    
    [self startProgressView];

    @try{
        
        @autoreleasepool {
            
            [self sendGETRequestTo:[NSString stringWithFormat:@"editprofile/getuserbyid/id/%@",[UserDefaultsUtil getObjectForKey:@"user_id"] ] withParams:nil action:@selector(getProfileRequestComplete:)];
            
            
        }
        
    }@catch (NSException *exception) {
        NSLog(@"Exception :::: %@",[exception debugDescription]);
    }
    
}


-(void)getProfileRequestComplete:(NSData *)data{
    
    NSString *response = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
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
        }else if ([status isEqualToString:@"success"]){
            NSDictionary *userData = [(NSArray*)[responseDict objectForKey:@"User data"] objectAtIndex:0];
            self.emailTextField.text = [userData objectForKey:@"email"];
            self.nicknameTextField.text = [userData objectForKey:@"username"];
            
            self.genderLbl.text = [userData objectForKey:@"gender"];
            self.heightLbl.text = [userData objectForKey:@"height"];
            self.ageLbl.text = [userData objectForKey:@"age"];
            self.weightLbl.text = [userData objectForKey:@"weight"];
           
            uploadedImageURL = [NSString stringWithFormat:@"%@%@",PROFILE_IMAGE_PATH,[userData objectForKey:@"user_portrait"]];
            
            dispatch_queue_t queue = dispatch_queue_create("read disc", NULL);
            
            dispatch_async(queue, ^{
                
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PROFILE_IMAGE_PATH,[userData objectForKey:@"user_portrait"]]]]];
                if (image != nil) {
                    
                    [self.userProfileImage setImageURL:[NSURL URLWithString:uploadedImageURL]];
                    
                    self.userProfileImage.image = [UIImage roundedImageWithImage:[image imageWithAlpha]];
                }else{
                    
                    image = [UIImage imageNamed:@"face place holder 45x45.png"];
                    self.userProfileImage.image = [UIImage roundedImageWithImage:[image imageWithAlpha]];
                }
            });
            
            dispatch_release(queue);
            [Globals sharedInstance].isSettingsChanged = FALSE;
            
        }
    }
    
    [self stopProgressView];
    [self getCurrentSettings];

}

- (void)getCurrentSettings{
    
    @try{
        @autoreleasepool {
            [self startProgressView];
            NSString *strForRequest = [NSString stringWithFormat:@"usersettings/usersettingbyid/id/%@",[UserDefaultsUtil getObjectForKey:@"user_id"]];
            [self sendGETRequestTo:strForRequest withParams:nil action:@selector(getCurrentSettingRequestComplete:)];
        }
        
    }@catch (NSException *exception) {
        NSLog(@"Exception :::: %@",[exception debugDescription]);
    }
}

-(void)getCurrentSettingRequestComplete:(NSData *)data{
    
    NSString *response = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *responseDict = [NSJSONSerialization
                                  JSONObjectWithData:data
                                  options:kNilOptions
                                  error:&error];
    
    if( error )
    {
        NSLog(@"%@", [error localizedDescription]);
    }else {
        //
        
        currentSettings = [responseDict objectForKey:@"User Setting"];
        currentSettingsDict = [currentSettings objectAtIndex:0];
        if ([currentSettings objectAtIndex:0] != nil) {
            [UserDefaultsUtil setObject:[currentSettingsDict objectForKey:@"setting_id"] forKey:@"adopted_setting"];
        };
    }
    
    [self stopProgressView];
    [self setViewStrings];
    
}

-(void) setViewStrings{
    
    [_heightLabel setText:[currentSettingsDict objectForKey:@"unit_of_height"]];
    [_weightLabel setText:[currentSettingsDict objectForKey:@"unit_of_weight"]];

}

- (IBAction)updateProfile:(id)sender {
    
    [self startProgressView];
    
    @try{
        @autoreleasepool {
            [self startProgressView];
            
            NSString *params = @"image=";
            params = [params stringByAppendingString:uploadedImageURL];
            params = [params stringByAppendingString:@"&username="];
            params = [params stringByAppendingString:self.nicknameTextField.text];
            params = [params stringByAppendingString:@"&gender="];
            params = [params stringByAppendingString:self.genderLbl.text];
            params = [params stringByAppendingString:@"&height="];
            params = [params stringByAppendingString:self.heightLbl.text];
            params = [params stringByAppendingString:@"&age="];
            params = [params stringByAppendingString:self.ageLbl.text];
            params = [params stringByAppendingString:@"&weight="];
            params = [params stringByAppendingString:self.weightLbl.text];
            params = [params stringByAppendingString:@"&email="];
            params = [params stringByAppendingString:self.emailTextField.text];
            params = [params stringByAppendingString:@"&password="];
            
            if(self.passwordTextField.text.length > 0){
                params = [params stringByAppendingString:self.passwordTextField.text];
            }else{
                params = [params stringByAppendingString:@""];
            }
            
            params = [params stringByAppendingString:@"&user_id="];
            params = [params stringByAppendingString:[NSString stringWithFormat:@"%@",[UserDefaultsUtil getObjectForKey:@"user_id"]]];
            [self sendPostRequestTo:@"editprofile/updateprofile" withParams:params action:@selector(updateProfileRequestComplete:)];
            
        }
    }@catch (NSException *exception) {
        NSLog(@"Exception :::: %@",[exception debugDescription]);
    }
    
}

-(void)updateProfileRequestComplete:(NSData *)data{
    
    NSString *response = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
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
        }else if ([status isEqualToString:@"success"]){
            modal = [[RNBlurModalView alloc]initWithViewController:self title:@"Info" message:@"Profile updated successfully"];
            [modal show];
            [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(HideAlertView) userInfo:nil repeats:NO];
        }
    }
    [self stopProgressView];
}

-(void) HideAlertView{
    [modal hide];
}

- (IBAction)unwindToRed:(UIStoryboardSegue *)unwindSegue{
    
}

- (IBAction)logoutBtnClicked:(id)sender {
    [self performSegueWithIdentifier:@"unWindLoginSeque" sender:self];

}

- (void)returnToRoot {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(IBAction)selectProfilePic:(id)sender{
    
    UIImagePickerController* pickr = [[UIImagePickerController alloc] init];
    pickr.allowsEditing = NO;
    pickr.delegate   = self;
    pickr.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentModalViewController:pickr animated:YES];
    
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
    
    self.genderLbl.text = [genderArray objectAtIndex:selectedIndex.intValue];

}

- (void)heightWasSelected:(NSNumber *)selectedIndex element:(id)element {
    
    self.heightLbl.text = [heightArray objectAtIndex:selectedIndex.intValue];

}

- (void)ageWasSelected:(NSNumber *)selectedIndex element:(id)element {
    
    self.ageLbl.text = [ageArray objectAtIndex:selectedIndex.intValue];

}

- (void)weightWasSelected:(NSNumber *)selectedIndex element:(id)element {
    
    self.weightLbl.text = [weightArray objectAtIndex:selectedIndex.intValue];

}

- (IBAction)backBtnClicked:(id)sender {
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count -2] animated:YES];

}

#pragma mark - UIImagePickerController Delegate

- (void)imagePickerController:(UIImagePickerController *)picker1 didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    uploadData = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage], 30);
    self.userProfileImage.image = [UIImage imageWithData:uploadData];
    self.userProfileImage.image = [UIImage roundedImageWithImage:[self.userProfileImage.image imageWithAlpha]];
    uploadFile = [[BRRequestUpload alloc] initWithDelegate: self];
    uploadedImageURL = [NSString stringWithFormat:@"%@.png",[UserDefaultsUtil getObjectForKey:@"user_id"]];
    uploadFile.path = [NSString stringWithFormat:@"%@.png",[UserDefaultsUtil getObjectForKey:@"user_id"]];
    uploadFile.hostname = @"beusoft.com";
    uploadFile.username = @"iapp@beusoft.com";
    uploadFile.password = @"Ccjk@123a";
    [uploadFile start];
    [picker1 dismissModalViewControllerAnimated:YES];

}

#pragma mark - Textfield Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // Any additional checks to ensure you have the correct textField here.
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Black Racoon Delegates

- (void) listDirectory
{
    listDir = [[BRRequestListDirectory alloc] initWithDelegate: self];
    listDir.hostname = @"beusoft.com";
    listDir.username = @"iapp@beusoft.com";
    listDir.password = @"Ccjk@123a";
    [listDir start];
}

-(void)requestFailed:(BRRequest *)request{
    if (request == listDir)
    {
        listDir = nil;
    }else if (request == uploadFile){
        uploadFile = nil;
        uploadedImageURL = @"";
    }
}

-(void)requestCompleted:(BRRequest *)request{
    //----- handle List Directory
    if (request == listDir){
        //----- we print each of the file names
        for (NSDictionary *file in listDir.filesInfo)
        {
            NSLog(@"%@", [file objectForKey: (id) kCFFTPResourceName]);
        }
        listDir = nil;
    }
    if (request == uploadFile)
    {
        uploadFile = nil;
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PROFILE_IMAGE_PATH,uploadedImageURL]]]];
        self.userProfileImage.image = [UIImage roundedImageWithImage:[image imageWithAlpha]];
        
    }
}

- (NSData *) requestDataToSend: (BRRequestUpload *) request
{
    NSData *temp = uploadData;   // this is a shallow copy of the pointer
    uploadData = nil;            // next time around, return nil...
    return temp;
}

- (long) requestDataSendSize: (BRRequestUpload *) request
{
    //----- user returns the total size of data to send. Used ONLY for percentComplete
    return [uploadData length];
}

-(BOOL) shouldOverwriteFileWithRequest: (BRRequest *) request
{
    //----- set this as appropriate if you want the file to be overwritten
    if (request == uploadFile)
    {
        //----- if uploading a file, we set it to YES
        return YES;
    }
    
    //----- anything else (directories, etc) we set to NO
    return NO;
}

-(IBAction)MyProfileAction:(id)sender{
    
}

-(IBAction)MySettingAction:(id)sender{
    
    [self performSegueWithIdentifier:@"SToSetting" sender:self];
}

-(IBAction)MyDevicesAction:(id)sender{
    [self performSegueWithIdentifier:@"SToDevices" sender:self];
}


@end
