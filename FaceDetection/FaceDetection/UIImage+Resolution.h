//
//  UIImage+Resolution.h
//  FaceDetection
//
//  Created by Praveen Jha on 07/02/13.
//  Copyright (c) 2013 JID Marketing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Resolution)
- (UIImage *) scaleToSize: (CGSize)size;
- (UIImage *) scaleProportionalToSize: (CGSize)size;
- (UIImage *)convertToGrayscale;
-(UIImage*)rotateDegrees:(double)r;
@end
