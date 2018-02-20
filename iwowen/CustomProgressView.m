//
//  CustomProgressView.m
//  iwown
//
//  Created by Apple on 10/01/2014.
//  Copyright (c) 2014 Ali Asghar. All rights reserved.
//

#import "CustomProgressView.h"

@implementation CustomProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    // lets prepare UIImage first, with stretching to fit our requirements
   
    UIImage *background = [[UIImage imageNamed:@"pb_bg.png"]
                           resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 4)];
    UIImage *fill = [[UIImage imageNamed:@"pb_indic.png"]
                     resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 4)];
    
    // Draw the background in the current rect with background UIImage
    
    [background drawInRect:rect];
    
    // Compute the max width in pixels for the fill.  Max width being how
    //    wide the fill should be at 100% progress. (maximun fill width)
    NSInteger maxWidth = rect.size.width; // here we are filling whole width of ProgressView
    // Compute the width for the current progress value, 0.0 - 1.0 corresponding
    //    to 0% and 100% respectively.
    NSInteger curWidth = floor([self progress] * maxWidth);
    //[self progress] gives the current progress rate of UIprogressView
    // floor returns absolute integer
    // Create the rectangle for our fill image accounting for the position offsets,
    //    resizing the filling image rect to cover the background
    //    (adjust as per your design, like from where you want to start fill,
    //     where you want to end, how many pixel you want to left in upper side etc)
    CGRect fillRect = CGRectMake(rect.origin.x,
                                 rect.origin.y+1,
                                 curWidth,
                                 rect.size.height-2);
    // Draw the fill
    [fill drawInRect:fillRect];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
