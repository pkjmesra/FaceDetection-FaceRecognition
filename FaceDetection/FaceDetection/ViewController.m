//
//  ViewController.m
//  FaceDetection
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
    // Copyright (C) 2011, Praveen K Jha, Research2Development Inc., all rights reserved.
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

#import "LiveFeedViewController.h"

#import "ViewController.h"

@implementation ViewController

-(void)detectAndMarkFace:(UIImageView *)facePicture
{
    // draw a CI image with the previously loaded face detection picture
    CIImage* image = [CIImage imageWithCGImage:facePicture.image.CGImage];

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
        // get the width of the face
        CGFloat faceWidth = faceFeature.bounds.size.width;

        // create a UIView using the bounds of the face
        UIView* faceView = [[UIView alloc] initWithFrame:faceFeature.bounds];

        // add a border around the newly created UIView
        faceView.layer.borderWidth = 1;
        faceView.layer.borderColor = [[UIColor redColor] CGColor];

        // add the new view to create a box around the face
        [self.view addSubview:faceView];

        [self markLeftEye:faceWidth faceFeature:faceFeature];

        [self markRightEye:faceWidth faceFeature:faceFeature];

        [self markMouth:faceWidth faceFeature:faceFeature];
    }
}

-(void)startFaceDetection
{
    // Load the picture for face detection
    UIImageView* image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Priyanka.jpg"]];
    // Draw the face detection image
    [self.view addSubview:image];

    // Execute the method used to markFaces in background
    [self performSelectorInBackground:@selector(detectAndMarkFace:) withObject:image];

    // flip image on y-axis to match coordinate system used by core image
    [image setTransform:CGAffineTransformMakeScale(1, -1)];

    // flip the entire view to make everything right side up
    [self.view setTransform:CGAffineTransformMakeScale(1, -1)];


}

-(void)tryLiveFeed:(id)sender
{
    LiveFeedViewController *lVC = [[LiveFeedViewController alloc] initWithNibName:@"LiveFeedViewController" bundle:nil];
    [self presentModalViewController:lVC animated:YES];
}

-(void) addLiveFeedButton
{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.origin.x +20, self.view.frame.size.height - 60, 70, 40)];
    [btn setTitle:@"Try Live" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [self.view setBackgroundColor:[UIColor greenColor]];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(tryLiveFeed:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTransform:CGAffineTransformMakeScale(1, -1)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self startFaceDetection];
    [self addLiveFeedButton];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
