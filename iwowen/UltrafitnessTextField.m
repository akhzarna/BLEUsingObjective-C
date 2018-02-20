//
//  UltrafitnessTextField.m
//  iwown
//
//  Created by Apple on 31/12/2013.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import "UltrafitnessTextField.h"

@implementation UltrafitnessTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectInset( bounds , 0 , 0 );
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
