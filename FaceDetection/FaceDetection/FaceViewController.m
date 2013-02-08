//
//  FaceViewController.m
//  FaceDetection
//
/**///////////////////////////////////////////////////////////////////////////////////////
    //
    //  IMPORTANT: READ BEFORE DOWNLOADING, COPYING, INSTALLING OR USING.
    //
    //  By downloading, copying, installing or using the software you agree to this license.
    //  If you do not agree to this license, do not download, install,
    //  copy or use the software.
    //
    //
    //                        License Agreement
    //                For Open Source Codebase that follows
    //
    // Copyright (C) 2011, Praveen K Jha, Praveen K Jha., all rights reserved.
    // Third party copyrights are property of their respective owners.
    //
    // Redistribution and use in source and binary forms, with or without modification,
    // are permitted provided that the following conditions are met:
    //
    //   * Redistribution's of source code must retain the above copyright notice,
    //     this list of conditions and the following disclaimer.
    //
    //   * Redistribution's in binary form must reproduce the above copyright notice,
    //     this list of conditions and the following disclaimer in the documentation
    //     and/or other materials provided with the distribution.
    //
    //   * The name of the company may not be used to endorse or promote products
    //     derived from this software without specific prior written permission.
    //
    // This software is provided by the copyright holders and contributors "as is" and
    // any express or implied warranties, including, but not limited to, the implied
    // warranties of merchantability and fitness for a particular purpose are disclaimed.
    // In no event shall the owning company or contributors be liable for any direct,
    // indirect, incidental, special, exemplary, or consequential damages
    // (including, but not limited to, procurement of substitute goods or services;
    // loss of use, data, or profits; or business interruption) however caused
    // and on any theory of liability, whether in contract, strict liability,
    // or tort (including negligence or otherwise) arising in any way out of
    // the use of this software, even if advised of the possibility of such damage.
    //
    //**/


#import "FaceViewController.h"

@interface FaceViewController ()
{
    UIActivityIndicatorView *_activity;
}
@end

@implementation FaceViewController
@synthesize imageView=_imageView;
@synthesize activity=_activity;

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
    UIImage *img = [[UIImage imageNamed:@"Priyanka.jpg"] scaleProportionalToSize:CGSizeMake(420, 320)];
    UIActivityIndicatorView *v = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [v setFrame:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/2, 40, 40)];
    self.activity = v;
    [self.view addSubview:self.activity];

    [self startFaceDetectionWithImage:img];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view setBackgroundColor:[UIColor greenColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)detectAndMarkFace:(UIImageView *)facePicture
{
    [self.view addSubview:self.activity];
    [self.activity startAnimating];
    // draw a CI image with the previously loaded face detection picture
    CIImage* image = [CIImage imageWithCGImage:facePicture.image.CGImage];

    // Remove all existing image views
//    NSArray *arr = [self.view subviews];
//    for (int i=arr.count-1; i>=0; i--) {
//        UIView *v = [arr objectAtIndex:i];
//        if ([v isKindOfClass:[UIImageView class]] && v.tag <=0)
//            [v removeFromSuperview];
//    }
    // create a face detector - since speed is not an issue we'll use a high accuracy
    // detector
    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:nil options:[NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy]];

    // create an array containing all the detected faces from the detector
    NSArray* features = [detector featuresInImage:image];

    // we'll iterate through every detected face.  CIFaceFeature provides us
    // with the width for the entire face, and the coordinates of each eye
    // and the mouth if detected.  Also provided are BOOL's for the eye's and
    // mouth so we can check if they already exist.
    for(CIFaceFeature* faceFeature in features)
    {
        NSLog(@"faceFeature:%@",faceFeature);
        // get the width of the face
        CGFloat faceWidth = faceFeature.bounds.size.width;

        // create a UIView using the bounds of the face
        UIView* faceView = [[UIView alloc] initWithFrame:faceFeature.bounds];

        // add a border around the newly created UIView
        faceView.layer.borderWidth = 1;
        faceView.layer.borderColor = [[UIColor redColor] CGColor];

        // add the new view to create a box around the face
        faceView.tag = 9995;
        [self.view addSubview:faceView];

        [self markLeftEye:faceWidth faceFeature:faceFeature];

        [self markRightEye:faceWidth faceFeature:faceFeature];

        [self markMouth:faceWidth faceFeature:faceFeature];
    }
    [self.activity stopAnimating];
}

-(void)startFaceDetectionWithImage:(UIImage *)someImage
{
    // Remove previously added left, right,mouth and rect view
    [[self.view viewWithTag:9995] removeFromSuperview];
    [[self.view viewWithTag:9996] removeFromSuperview];
    [[self.view viewWithTag:9997] removeFromSuperview];
    [[self.view viewWithTag:9998] removeFromSuperview];
    [[self.view viewWithTag:9999] removeFromSuperview];
    [self.activity removeFromSuperview];
    self.imageView =nil;
    
    // Load the picture for face detection
    if (!self.imageView)
    {
        someImage = someImage?someImage:[UIImage imageNamed:@"Priyanka.jpg"];
        UIImageView* image = [[UIImageView alloc] initWithImage:someImage];
        image.tag =9999;
        self.imageView = image;
        // Draw the face detection image
        [self.view addSubview:self.imageView];
        [self.imageView addSubview:self.activity];
        [self.view sendSubviewToBack:self.imageView];
    }
    else
        someImage = someImage?someImage:[UIImage imageNamed:@"Priyanka.jpg"];
    
    [self.imageView setImage:someImage];
    // Remove previously added left, right,mouth and rect view
    [[self.view viewWithTag:9995] removeFromSuperview];
    [[self.view viewWithTag:9996] removeFromSuperview];
    [[self.view viewWithTag:9997] removeFromSuperview];
    [[self.view viewWithTag:9998] removeFromSuperview];

    // flip image on y-axis to match coordinate system used by core image
    [self.imageView setTransform:CGAffineTransformMakeScale(1, -1)];

    // flip the entire view to make everything right side up
    [self.view setTransform:CGAffineTransformMakeScale(1, -1)];

    // Execute the method used to markFaces in background
    [self performSelectorInBackground:@selector(detectAndMarkFace:) withObject:self.imageView];
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
        leftEyeView.tag = 9998;
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
        leftEye.tag = 9997;
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
        mouth.tag = 9996;
        // add the new view to the view
        [self.view addSubview:mouth];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
