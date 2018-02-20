//
//  UIUtils.m
//  meU
//
//  Created by Apple on 13/09/2012.
//  Copyright (c) 2012 MacrosoftInc. All rights reserved.
//

#import "UIUtils.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIUtils

+(UIButton *) getTopLeftBarItem: (NSString*) Title {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"topleft_btn.png"] forState:UIControlStateNormal];
    [leftButton setTitle:Title forState:UIControlStateNormal];
    
    [leftButton setTitleColor:[UIColor colorWithRed:82.0f/255.0f green:116.0f/255.0f blue:168.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
//    leftButton.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Bold" size:20.0];
    if([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        leftButton.frame = CGRectMake(0.0f, 0.0f, 90.0f, 35.0f);
    }else{
        leftButton.frame = CGRectMake(0.0f, 0.0f, 75.0f, 35.0f);
        leftButton.titleLabel.font =[UIFont boldSystemFontOfSize:12.0];
    }
    [leftButton titleEdgeInsets];
    
    return leftButton;
}

+(UIButton *) getTopRightBarItem: (NSString*) Title {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"top_right_btn.png"] forState:UIControlStateNormal];
    [rightButton setTitle:Title forState:UIControlStateNormal];
    
    [rightButton setTitleColor:[UIColor colorWithRed:82.0f/255.0f green:116.0f/255.0f blue:168.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    if([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        rightButton.frame = CGRectMake(0.0f, 0.0f, 90.0f, 35.0f);
    }else{
        rightButton.frame = CGRectMake(0.0f, 0.0f, 75.0f, 35.0f);
        rightButton.titleLabel.font =[UIFont boldSystemFontOfSize:12.0];
    }
    return rightButton;
}

+(UIButton *) getTopRightBarItem: (NSString*) Title withCustomWidth:(float)width {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"top_right_btn.png"] forState:UIControlStateNormal];
    [rightButton setTitle:Title forState:UIControlStateNormal];
    
    [rightButton setTitleColor:[UIColor colorWithRed:82.0f/255.0f green:116.0f/255.0f blue:168.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    if([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        rightButton.frame = CGRectMake(0.0f, 0.0f, width, 35.0f);
    }else{
        rightButton.frame = CGRectMake(0.0f, 0.0f, width, 35.0f);
        rightButton.titleLabel.font =[UIFont boldSystemFontOfSize:12.0];
    }
    return rightButton;
}

+(UIView*)getLoadingViewWithMessage:(NSString *)message{
    CGSize result = [[UIScreen mainScreen] bounds].size;
    
    UIView *loadingView = [[UIView alloc] initWithFrame:CGRectMake((result.width/2)-50, result.height/10, 170, 170)];
    loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    loadingView.clipsToBounds = YES;
    loadingView.layer.cornerRadius = 10.0;
        
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.frame = CGRectMake(65, 40, activityView.bounds.size.width, activityView.bounds.size.height);
    [loadingView addSubview:activityView];
    
    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 115, 130, 22)];
    loadingLabel.backgroundColor = [UIColor clearColor];
    loadingLabel.textColor = [UIColor whiteColor];
    loadingLabel.adjustsFontSizeToFitWidth = YES;
    loadingLabel.textAlignment = UITextAlignmentCenter;
    loadingLabel.text = message;
    [loadingView addSubview:loadingLabel];
    
    [activityView startAnimating];
    loadingView.hidden = YES;
    
    return loadingView;
}


@end
