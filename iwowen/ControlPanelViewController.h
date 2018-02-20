//
//  ControlPanelViewController.h
//  iwowen
//
//  Created by Ali Asghar on 10/19/13.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ControlPanelViewController : UIViewController<UITableViewDataSource,UITableViewDataSource>{
    
    NSMutableArray *sections;
    NSMutableArray *items;
    
}


@end
