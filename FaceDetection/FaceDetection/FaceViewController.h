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

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, strong) UIActivityIndicatorView *activity;

- (void)startFaceDetectionWithImage:(UIImage *)someImage;
- (void)markLeftEye:(CGFloat)faceWidth faceFeature:(CIFaceFeature *)faceFeature;
- (void)markRightEye:(CGFloat)faceWidth faceFeature:(CIFaceFeature *)faceFeature;
- (void)markMouth:(CGFloat)faceWidth faceFeature:(CIFaceFeature *)faceFeature;
@end
