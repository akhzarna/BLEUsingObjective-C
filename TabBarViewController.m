// Copyright (c) 2013 Tkxel. All rights reserved.

#import "TabBarViewController.h"
#import "MyDayViewController.h"
#import "TrendViewController.h"
#import "PlanViewController.h"
#import "SettingsViewController.h"

@implementation TabBarViewController

#pragma mark - View lifecycle

- (void)loadView {
    
    [super loadView];
    
//    MyDayViewController *viewController2 = [[MyDayViewController alloc] init];
//    MyDayViewController *viewController1 = [[MyDayViewController alloc] init];
//    PlanViewController *viewController3 = [[PlanViewController alloc] init];
//    SettingsViewController *viewController4 = [[SettingsViewController alloc] init];
//
//    UINavigationController * nc1 = [[UINavigationController alloc] initWithRootViewController:viewController1];
//    UINavigationController * nc2 = [[UINavigationController alloc] initWithRootViewController:viewController2];
//    UINavigationController * nc3 = [[UINavigationController alloc] initWithRootViewController:viewController3];
//    UINavigationController * nc4 = [[UINavigationController alloc] initWithRootViewController:viewController4];
//
//    self.viewControllers = [NSArray arrayWithObjects:nc1,
//                            nc2,
//                            nc3,nc4,nil];
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[[NSBundle mainBundle].infoDictionary objectForKey:@"MainStoryboard_iPhone"] bundle:[NSBundle mainBundle]];
//    
//    
//    MyDayViewController * tempVC;
//    
//    tempVC = [storyboard instantiateViewControllerWithIdentifier:@"MyDayViewControllerID"];
//    
//    [self.navigationController pushViewController:tempVC animated:NO];
//
//    
//    ContactsViewController *contactsViewController = [[[ContactsViewController alloc] initWithNibName:@"ContactsViewController" bundle:nil] autorelease];
//    [contactsViewController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"my_day_hover.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"my_day.png"]];
//    [contactsViewController.tabBarItem setTitle:NSLocalizedString(@"tabbar_contacts", @"")];
//    contactsViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
//    MyCustomNavigationController *contactsViewNavigationController = [[[MyCustomNavigationController alloc] initWithRootViewController:contactsViewController] autorelease];
    
    
//    DialPadViewController *keyPadViewController = [[[DialPadViewController alloc] initWithNibName:@"DialPadViewController" bundle:nil] autorelease];
    
//    DialPadViewController *keyPadViewController;
//    
//    if( IS_IPHONE_5){
//        keyPadViewController = [[DialPadViewController alloc]initWithNibName:@"DialPadViewController" bundle:nil];
//    }
//    else {
//        keyPadViewController = [[DialPadViewController alloc]initWithNibName:@"DialPadViewController_Iphone4" bundle:nil];
//
//    }
//
//    [keyPadViewController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"keypad_selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"keypad.png"]];
//    [keyPadViewController.tabBarItem setTitle:NSLocalizedString(@"tabbar_keypad", @"")];
//    keyPadViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
//    MyCustomNavigationController *keypadViewNavigationController = [[[MyCustomNavigationController alloc] initWithRootViewController:keyPadViewController] autorelease];
//    [keypadViewNavigationController.navigationBar setHidden:YES];
//    
//    
//    
//    
//    CallHistoryViewController *recordsViewController = [[[CallHistoryViewController alloc] initWithNibName:@"CallHistoryViewController" bundle:nil] autorelease];
//    [recordsViewController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"callHistory_selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"callHistory.png"]];
//    [recordsViewController.tabBarItem setTitle:NSLocalizedString(@"tabbar_records", @"")];
//    recordsViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
//    MyCustomNavigationController *recordsViewNavigationController = [[[MyCustomNavigationController alloc] initWithRootViewController:recordsViewController] autorelease];
//    
//    
//    
//    MessagesHistoryViewController *messagesViewController = [[[MessagesHistoryViewController alloc] initWithNibName:@"MessagesHistoryViewController" bundle:nil] autorelease];
//    [messagesViewController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"messages_selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"messages.png"]];
//    [messagesViewController.tabBarItem setTitle:NSLocalizedString(@"tabbar_messages", @"")];
//    messagesViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
//    MyCustomNavigationController *messagesViewNavigationController = [[[MyCustomNavigationController alloc] initWithRootViewController:messagesViewController] autorelease];
//    
//    
//    SettingsViewController *settingsViewController = [[[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil] autorelease];
//    [settingsViewController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"more_selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"more.png"]];
//    [settingsViewController.tabBarItem setTitle:NSLocalizedString(@"tabbar_more", @"")];
//    settingsViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
//    MyCustomNavigationController *settingsViewNavigationController = [[[MyCustomNavigationController alloc] initWithRootViewController:settingsViewController] autorelease];
//
//    
//   [self setViewControllers:[NSArray arrayWithObjects:contactsViewNavigationController,keypadViewNavigationController,recordsViewNavigationController,messagesViewNavigationController,settingsViewNavigationController,nil]];
    

//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 400, 320, 49)];
//    
//    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_tabbar.png"]];
//    
//    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 4.9) {
//        //iOS 5
//        [self.tabBar insertSubview:imageView atIndex:1];
//    }
//    else {
//        //iOS 4.whatever and below
//        [self.tabBar insertSubview:imageView atIndex:0];
//    }
//    
//    [imageView release];
//    
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                       [UIFont fontWithName:@"Oxygen-Bold" size:10.0f], UITextAttributeFont,
//                                                       [UIColor whiteColor], UITextAttributeTextColor,
//                                                       [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 1.0f)], UITextAttributeTextShadowOffset,
//                                                       nil] forState:UIControlStateNormal];

    
    [self setSelectedIndex:0];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    [self.navigationController setNavigationBarHidden:YES];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIFont fontWithName:@"AmericanTypewriter" size:10.0f], UITextAttributeFont,
                                                       [UIColor whiteColor], UITextAttributeTextColor,
                                                       [UIColor greenColor], UITextAttributeTextColor,
                                                       [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 0.0f)], UITextAttributeTextShadowOffset,
                                                       nil] forState:UIControlStateNormal];

    UITabBarItem *tabBarItem0 = [self.tabBar.items objectAtIndex:0];
    tabBarItem0.imageInsets = UIEdgeInsetsMake(4,0, -8, 0);
    tabBarItem0.titlePositionAdjustment = UIOffsetMake(0.0, 1.0);
    [tabBarItem0 setTitle:@"MY DAY"];
    [tabBarItem0 setFinishedSelectedImage:[UIImage imageNamed:@"my_day_hover.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"my_day.png"]];
    
    UITabBarItem *tabBarItem1 = [self.tabBar.items objectAtIndex:1];
    tabBarItem1.imageInsets = UIEdgeInsetsMake(4, 0, -8, 0);
    tabBarItem1.titlePositionAdjustment = UIOffsetMake(0.0, 1.0);
    [tabBarItem1 setTitle:@"PLAN"];
    [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"plan_hover.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"plan.png"]];
    
    UITabBarItem *tabBarItem2 = [self.tabBar.items objectAtIndex:2];
    tabBarItem2.imageInsets = UIEdgeInsetsMake(4, 0, -8, 0);
    tabBarItem2.titlePositionAdjustment = UIOffsetMake(0.0, 1.0);
    [tabBarItem2 setTitle:@"TRENDS"];
    [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"trends_hover.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"trends.png"]];

    UITabBarItem *tabBarItem3 = [self.tabBar.items objectAtIndex:3];
    tabBarItem3.imageInsets = UIEdgeInsetsMake(4, 0, -8, 0);
    tabBarItem3.titlePositionAdjustment = UIOffsetMake(0.0, 2.0);
    [tabBarItem3 setTitle:@"SETTINGS"];
    [tabBarItem3 setFinishedSelectedImage:[UIImage imageNamed:@"settings_hover.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"settings.png"]];
    
//    if ([[self tabBar ] respondsToSelector:@selector(setBackgroundImage:)]) {
//        // ios 5 code here
//        [self tabBar ].backgroundColor = [UIColor clearColor];
//        [[self tabBar ] setBackgroundImage:[UIImage imageNamed:@"tabbar_bg.png"]];
//    } 
//    else {
//        [self tabBar ].backgroundColor = [UIColor clearColor];
//        // ios 4 code here
//        CGRect frame = CGRectMake(0, 0, 320, 49);
//        UIView *tabbg_view = [[[UIView alloc] initWithFrame:frame]autorelease];
//        UIImage *tabbag_image = [UIImage imageNamed:@"tabbar_bg.png"];
//        UIColor *tabbg_color = [[[UIColor alloc] initWithPatternImage:tabbag_image]autorelease];
//        tabbg_view.backgroundColor = tabbg_color;
//        [[self tabBar ] insertSubview:tabbg_view atIndex:0];
//    }

}



#pragma mark UITabBarDelegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item { // called when a new view is selected by the user (but not programatically)
  
    
}

@end
