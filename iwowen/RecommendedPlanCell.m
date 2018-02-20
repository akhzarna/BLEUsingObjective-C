//
//  RecommendedPlanCell.m
//  iwowen
//
//  Created by Omer Waqas Khan on 22/11/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import "RecommendedPlanCell.h"

@implementation RecommendedPlanCell

@synthesize cellBg;
@synthesize pic;
@synthesize viewImg;
@synthesize downloadImg;

@synthesize downloadLbl;
@synthesize viewLbl;
@synthesize titleLbl;
@synthesize adoptLbl;

@synthesize viewBtn;
@synthesize downloadBtn;
@synthesize adoptBtn;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
