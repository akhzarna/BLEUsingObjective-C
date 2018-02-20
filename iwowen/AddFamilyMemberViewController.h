//
//  AddFamilyMemberViewController.h
//  iwowen
//
//  Created by Ali Asghar on 10/20/13.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddFamilyMemberViewController : UIViewController{
    NSMutableArray *genderArray;
    NSMutableArray *heightArray;
    NSMutableArray *ageArray;
    NSMutableArray *weightArray;
}

@property (strong, nonatomic) IBOutlet UITextField *nicknameTF;
@property (strong, nonatomic) IBOutlet UILabel *genderLbl;
@property (strong, nonatomic) IBOutlet UILabel *heightLbl;
@property (strong, nonatomic) IBOutlet UILabel *ageLbl;
@property (strong, nonatomic) IBOutlet UILabel *weightLbl;

- (IBAction)genderBtnClicked:(id)sender;
- (IBAction)heightBtnClicked:(id)sender;
- (IBAction)ageBtnClicked:(id)sender;
- (IBAction)weightBtnClicked:(id)sender;
@end
