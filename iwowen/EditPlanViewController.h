//
//  CreatePlanViewController.h
//  iwowen
//
//  Created by Omer Waqas Khan on 23/11/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ActionSheetDatePicker.h"
#import "NSDate+TCUtils.h"
#import "BRRequest.h"
#import "BRRequestListDirectory.h"
#import "BRRequestUpload.h"
#import "Plan.h"
#import "RNBlurModalView.h"

@interface EditPlanViewController : BaseViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate,BRRequestDelegate>{
    
    RNBlurModalView *modal;
    BRRequestListDirectory *listDir;
    BRRequestUpload *uploadFile;
    NSData *uploadData;
    NSString *uploadedImageURL;
    
    IBOutlet UITextField *planTitle;
    IBOutlet UITextField *startDate;
    IBOutlet UITextField *endDate;
    IBOutlet UITextField *steps;
    IBOutlet UITextField *weight;
    NSData *imageData;
}

@property (nonatomic,strong)Plan *plan;

@property (nonatomic, strong) IBOutlet UITextField *planTitle;
@property (nonatomic, strong) IBOutlet UITextField *startDate;
@property (nonatomic, strong) IBOutlet UITextField *endDate;
@property (nonatomic, strong) IBOutlet UITextField *steps;
@property (nonatomic, strong) IBOutlet UITextField *weight;
@property (weak, nonatomic) IBOutlet UIImageView *pic;

@property (strong,nonatomic)AbstractActionSheetPicker *actionSheetPicker;

- (IBAction)startDateEditingDidBegin:(id)sender;
- (IBAction)endDateEditingDidBegin:(id)sender;
- (IBAction)addReminderBtnClicked:(id)sender;

-(IBAction)EditPlanAction:(id)sender;

-(IBAction)selectPlanPic:(id)sender;
@end
