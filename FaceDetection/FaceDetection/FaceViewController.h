//
//  FaceViewController.h
//  FaceDetection
//
//  Created by Praveen Jha on 06/02/13.
//  Copyright (c) 2013 JID Marketing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>
#import <CoreImage/CoreImage.h>
#import <QuartzCore/QuartzCore.h>

@interface FaceViewController : UIViewController

- (void)markLeftEye:(CGFloat)faceWidth faceFeature:(CIFaceFeature *)faceFeature;
- (void)markRightEye:(CGFloat)faceWidth faceFeature:(CIFaceFeature *)faceFeature;
- (void)markMouth:(CGFloat)faceWidth faceFeature:(CIFaceFeature *)faceFeature;
@end
