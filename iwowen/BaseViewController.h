//
//  BaseViewController.h
//  iwowen
//
//  Created by Apple on 23/11/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "SMWebRequest.h"
#import "Constants.h"
#import "UIUtils.h"
#import "UserDefaultsUtil.h"

@interface BaseViewController : UIViewController <SMWebRequestDelegate>{

@protected
    
    UIView *progressIndicatorView;
    
}

-(void)sendPostRequestTo:(NSString *)page withParams:(NSString*)params action:(SEL)action;
-(void)sendGETRequestTo:(NSString *)page withParams:(NSString*)params action:(SEL)action;
-(void)runOperationQueueWithSelector:(SEL)selector;
-(void)setLoadingViewMessage:(NSString*)message;
-(void)startProgressView;
-(void)stopProgressView;

-(void)setBorderColorForTextField:(UITextField*)textField;
-(void)SetBorderColorForButton:(UIButton*)button;
-(void)SetBorderColorForImageView:(UIImageView*)imageView;

@end
