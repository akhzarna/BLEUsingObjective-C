//
//  FourDidgitViewController.h
//  iwown
//
//  Created by Akhzar Nazir on 25/02/2014.
//  Copyright (c) 2014 Ali Asghar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FourDidgitViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *fourDigitTextField;

@property (weak, nonatomic) IBOutlet NSString *FourDigitString;

-(IBAction)EnterCodeForVerification:(id)sender;

@end
