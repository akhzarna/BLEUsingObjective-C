//
//  AppDelegate.m
//  iwowen
//
//  Created by Ali Asghar on 10/10/13.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        UIView *addStatusBar = [[UIView alloc] init];
        addStatusBar.frame = CGRectMake(0, 0, 320, 20);
        addStatusBar.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1]; //You can give your own color pattern
        [self.window.rootViewController.view addSubview:addStatusBar];
    }

    // Override point for customization after application launch.
    
//    if(kDeviceiPad){
//        
//        //adding status bar for IOS7 ipad
//        if (IS_IOS7) {
//            UIView *addStatusBar = [[UIView alloc] init];
//            addStatusBar.frame = CGRectMake(0, 0, 1024, 20);
//            addStatusBar.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1]; //change this to match your navigation bar
//            [self.window.rootViewController.view addSubview:addStatusBar];
//        }
//    }
//    else{
    
        //adding status bar for IOS7 iphone
    
    // Commented By Akhzar Nazir Old Code

    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
//        
//        [application setStatusBarStyle:UIStatusBarStyleLightContent];
//        
//        self.window.clipsToBounds = YES;
//        self.window.frame =  CGRectMake(0,20,self.window.frame.size.width,self.window.frame.size.height);
//        
//        //Added on 19th Sep 2013
//        
//        NSLog(@"%f",self.window.frame.size.height);
//        
//        self.window.bounds = CGRectMake(0,0, self.window.frame.size.width, self.window.frame.size.height);
//    }
//    
////    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    
//    [[NSUserDefaults standardUserDefaults] setFloat:self.window.frame.size.height forKey:@"windowHeight"];
    
//    UITabBarItem *tabBarItem0 = [self.tabBarController.tabBar.items objectAtIndex:0];
//    [tabBarItem0 setFinishedSelectedImage:[UIImage imageNamed:@"my_day_icon_selcted.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"my_day_icon_hover.png"]];
//    
//    UITabBarItem *tabBarItem1 = [self.tabBarController.tabBar.items objectAtIndex:1];
//    [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"plan_icon_selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"plan_icon_hover.png"]];
//    
//    UITabBarItem *tabBarItem2 = [self.tabBarController.tabBar.items objectAtIndex:2];
//    [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"trends_icon_hover.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"trends_icon_selected.png"]];
//    
//    UITabBarItem *tabBarItem3 = [self.tabBarController.tabBar.items objectAtIndex:3];
//    [tabBarItem3 setFinishedSelectedImage:[UIImage imageNamed:@"setting_icon_selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"setting_icon_hover.png"]];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
