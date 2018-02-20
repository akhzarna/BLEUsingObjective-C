//
//  UIImage+RoundedImage.m
//  GreenPaw
//
//  Created by Nikolay Dyankov on 7/10/13.
//  Copyright (c) 2013 Nikolay Dyankov. All rights reserved.
//

#import "UIImage+RoundedImage.h"

@implementation UIImage (RoundedImage)

+ (UIImage *)roundedImageWithImage:(UIImage *)image {
    if (image) {
        CGContextRef cx = CGBitmapContextCreate(NULL, image.size.width, image.size.height, CGImageGetBitsPerComponent(image.CGImage), 0, CGImageGetColorSpace(image.CGImage), CGImageGetBitmapInfo(image.CGImage));
        
        CGContextBeginPath(cx);
        CGRect pathRect = CGRectMake(0, 0, image.size.width, image.size.height);
        CGContextAddEllipseInRect(cx, pathRect);
        CGContextClosePath(cx);
        CGContextClip(cx);
        
        CGContextDrawImage(cx, CGRectMake(0, 0, image.size.width, image.size.height), image.CGImage);
        
        CGImageRef clippedImage = CGBitmapContextCreateImage(cx);
        CGContextRelease(cx);
        
        UIImage *roundedImage = [UIImage imageWithCGImage:clippedImage];
        CGImageRelease(clippedImage);
        
        return roundedImage;
    }
    
    return nil;
}

@end
