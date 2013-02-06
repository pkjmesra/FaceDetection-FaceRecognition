//
//  FaceViewController.m
//  FaceDetection
//
//  Created by Praveen Jha on 06/02/13.
//  Copyright (c) 2013 JID Marketing. All rights reserved.
//

#import "FaceViewController.h"

@interface FaceViewController ()

@end

@implementation FaceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)markLeftEye:(CGFloat)faceWidth faceFeature:(CIFaceFeature *)faceFeature
{
    if(faceFeature.hasLeftEyePosition)
    {
        // create a UIView with a size based on the width of the face
        UIView* leftEyeView = [[UIView alloc] initWithFrame:CGRectMake(faceFeature.leftEyePosition.x-faceWidth*0.15, faceFeature.leftEyePosition.y-faceWidth*0.15, faceWidth*0.3, faceWidth*0.3)];
        // change the background color of the eye view
        [leftEyeView setBackgroundColor:[[UIColor greenColor] colorWithAlphaComponent:0.3]];
        // set the position of the leftEyeView based on the face
        [leftEyeView setCenter:faceFeature.leftEyePosition];
        // round the corners
        leftEyeView.layer.cornerRadius = faceWidth*0.15;
        // add the view to the view
        [self.view addSubview:leftEyeView];
    }
}

- (void)markRightEye:(CGFloat)faceWidth faceFeature:(CIFaceFeature *)faceFeature
{
    if(faceFeature.hasRightEyePosition)
    {
        // create a UIView with a size based on the width of the face
        UIView* leftEye = [[UIView alloc] initWithFrame:CGRectMake(faceFeature.rightEyePosition.x-faceWidth*0.15, faceFeature.rightEyePosition.y-faceWidth*0.15, faceWidth*0.3, faceWidth*0.3)];
        // change the background color of the eye view
        [leftEye setBackgroundColor:[[UIColor greenColor] colorWithAlphaComponent:0.3]];
        // set the position of the rightEyeView based on the face
        [leftEye setCenter:faceFeature.rightEyePosition];
        // round the corners
        leftEye.layer.cornerRadius = faceWidth*0.15;
        // add the new view to the view
        [self.view addSubview:leftEye];
    }
}

- (void)markMouth:(CGFloat)faceWidth faceFeature:(CIFaceFeature *)faceFeature
{
    if(faceFeature.hasMouthPosition)
    {
        // create a UIView with a size based on the width of the face
        UIView* mouth = [[UIView alloc] initWithFrame:CGRectMake(faceFeature.mouthPosition.x-faceWidth*0.2, faceFeature.mouthPosition.y-faceWidth*0.2, faceWidth*0.4, faceWidth*0.4)];
        // change the background color for the mouth to green
        [mouth setBackgroundColor:[[UIColor greenColor] colorWithAlphaComponent:0.3]];
        // set the position of the mouthView based on the face
        [mouth setCenter:faceFeature.mouthPosition];
        // round the corners
        mouth.layer.cornerRadius = faceWidth*0.2;
        // add the new view to the view
        [self.view addSubview:mouth];
    }
}
@end
