//
//  BaseViewController.m
//  iwowen
//
//  Created by Apple on 23/11/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
#import "AccountViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

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
    
//    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
//    [delegate showSolidStatusBar:YES];
    


    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    
	// Do any additional setup after loading the view.
    
    progressIndicatorView = [UIUtils getLoadingViewWithMessage:@"Processing, Please wait"];
    progressIndicatorView.center = self.view.center;
    
    [self.view addSubview:progressIndicatorView];
    [progressIndicatorView setHidden:YES];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        CGRect frame=self.view.frame;
        if (frame.size.height==[[NSUserDefaults standardUserDefaults] floatForKey:@"windowHeight"])
        {
            frame.size.height-=20;
        }
        self.view.frame=frame;
    }

}

-(BOOL)prefersStatusBarHidden{
    
    return YES;

}

- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

-(void)sendPostRequestTo:(NSString *)page withParams:(NSString*)params action:(SEL)action{
   
    @try{
        
        @autoreleasepool {
            
            NSData *postData = [params dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
            
            NSString *url = SERVER_URL;
            url = [url stringByAppendingString:page];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc ]init];
            [request setURL:[NSURL URLWithString:url]];
            
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postData];
            
            SMWebRequest *loginRequest = [SMWebRequest requestWithURLRequest:request delegate:self context:NULL];
            [loginRequest addTarget:self action:action forRequestEvents:SMWebRequestEventComplete];
            [loginRequest start];
        }
        
    }@catch (NSException *exception) {
        
        NSLog(@"Exception :::: %@",[exception debugDescription]);
    
    }
}

-(void)sendGETRequestTo:(NSString *)page withParams:(NSString*)params action:(SEL)action{
    
    @try{
    
        @autoreleasepool {
        
            NSData *postData = [params dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
            
            NSString *url = SERVER_URL;
            url = [url stringByAppendingString:page];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc ]init];
            [request setURL:[NSURL URLWithString:url]];
            
            [request setHTTPMethod:@"GET"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postData];
            
            SMWebRequest *loginRequest = [SMWebRequest requestWithURLRequest:request delegate:self context:NULL];
            [loginRequest addTarget:self action:action forRequestEvents:SMWebRequestEventComplete];
            [loginRequest start];
            
        }
        
    }@catch (NSException *exception) {
        
        NSLog(@"Exception :::: %@",[exception debugDescription]);
    
    }
}

#pragma mark - progress view methods

-(void)startProgressView{

    UIInterfaceOrientation orient = [[UIApplication sharedApplication] statusBarOrientation];
    CGRect screen = [[UIScreen mainScreen] bounds];
    float pos_y, pos_x;
    pos_y = UIDeviceOrientationIsLandscape(orient) ? screen.size.width/2  : screen.size.height/2;
    pos_x = UIDeviceOrientationIsLandscape(orient) ? screen.size.height/2 : screen.size.width/2;
    
    progressIndicatorView.center = CGPointMake(pos_x, pos_y);
    
    [self.view bringSubviewToFront:progressIndicatorView];
    [progressIndicatorView setHidden:NO];

}

-(void)stopProgressView{
    
    [progressIndicatorView setHidden:YES];
    [self.view sendSubviewToBack:progressIndicatorView];

}

-(void)setLoadingViewMessage:(NSString*)message{
    
    for(UIView* view in [progressIndicatorView subviews]){
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel*)view;
            [label setText:message];
        }
    }
}

#pragma mark - SMWebRequest Delegates

-(void)connectionNotFound{
    
    [self stopProgressView];

}

-(void)runOperationQueueWithSelector:(SEL)selector{
    
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]
                                        initWithTarget:self
                                        selector:selector
                                        object:nil];
    [queue addOperation:operation];
    
}

-(void)setBorderColorForTextField:(UITextField*)textField{
    
////    UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
//    
////    leftView.backgroundColor = [UIColor clearColor];
//    
////    textField.leftView = leftView;
    
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    textField.layer.masksToBounds=YES;
    
    textField.layer.borderColor=[RGBCOLOR(143, 187, 54)CGColor];
    
    textField.layer.borderWidth= 1.0f;
    
}

-(void)SetBorderColorForButton:(UIButton*)button{
    
    [[button layer] setBorderWidth:1.0f];
    [[button layer] setBorderColor:[RGBCOLOR(143, 187, 54)CGColor]];

}

-(void)SetBorderColorForImageView:(UIImageView*)imageView{
    
    [[imageView layer] setBorderWidth:1.0f];
    [[imageView layer] setBorderColor:[RGBCOLOR(143, 187, 54)CGColor]];
    
}

@end
