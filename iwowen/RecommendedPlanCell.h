//
//  RecommendedPlanCell.h
//  iwowen
//
//  Created by Omer Waqas Khan on 22/11/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendedPlanCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *stepsLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;

@property (weak, nonatomic) IBOutlet UILabel *myCurrentPlanLabel;
@property (nonatomic, strong) IBOutlet UIImageView *cellBg;
@property (nonatomic, strong) IBOutlet UIImageView *pic;
@property (nonatomic, strong) IBOutlet UIImageView *viewImg;
@property (nonatomic, strong) IBOutlet UIImageView *downloadImg;

@property (nonatomic, strong) IBOutlet UILabel *downloadLbl;
@property (nonatomic, strong) IBOutlet UILabel *viewLbl;
@property (nonatomic, strong) IBOutlet UILabel *titleLbl;

@property (nonatomic, strong) IBOutlet UILabel *adoptLbl;

@property (nonatomic, strong) IBOutlet UIButton *viewBtn;
@property (nonatomic, strong) IBOutlet UIButton *downloadBtn;

@property (nonatomic, strong) IBOutlet UIButton *adoptBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property (nonatomic, strong) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *viewPlanButton;
@property (weak, nonatomic) IBOutlet UIButton *editPlanButton;



@end
