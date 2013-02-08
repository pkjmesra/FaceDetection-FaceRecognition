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
#import "MyViewController.h"

@interface MyViewController ()

//@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIToolbar *myToolbar;

@property (nonatomic, retain) OverlayViewController *overlayViewController;

@property (nonatomic, retain) NSMutableArray *capturedImages;

// toolbar buttons
- (IBAction)photoLibraryAction:(id)sender;
- (IBAction)cameraAction:(id)sender;

@end

@implementation MyViewController


#pragma mark -
#pragma mark View Controller

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.overlayViewController =
        [[OverlayViewController alloc] initWithNibName:@"OverlayViewController" bundle:nil];

    // as a delegate we will be notified when pictures are taken and when to dismiss the image picker
    self.overlayViewController.delegate = self;
    
    self.capturedImages = [NSMutableArray array];

    NSMutableArray *toolbarItems = [NSMutableArray arrayWithCapacity:self.myToolbar.items.count];
    [toolbarItems addObjectsFromArray:self.myToolbar.items];

    [self.myToolbar setTransform:CGAffineTransformMakeScale(1, -1)];
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        // camera is not on this device, don't show the camera button
        [toolbarItems removeObjectAtIndex:2];
        [self.myToolbar setItems:toolbarItems animated:NO];
    }
    [self addBackButton];
}

- (void)viewDidUnload
{
//    self.imageView = nil;
    self.myToolbar = nil;
    
    self.overlayViewController = nil;
    self.capturedImages = nil;
}

#pragma mark -
#pragma mark Toolbar Actions

- (void)showImagePicker:(UIImagePickerControllerSourceType)sourceType
{
//    if (self.imageView.isAnimating)
//        [self.imageView stopAnimating];

    if (self.capturedImages.count > 0)
        [self.capturedImages removeAllObjects];
    
    if ([UIImagePickerController isSourceTypeAvailable:sourceType])
    {
        [self.overlayViewController setupImagePicker:sourceType];
        [self presentModalViewController:self.overlayViewController.imagePickerController animated:YES];
    }
}

- (IBAction)photoLibraryAction:(id)sender
{   
	[self showImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (IBAction)cameraAction:(id)sender
{
    [self showImagePicker:UIImagePickerControllerSourceTypeCamera];
}

-(void)doneLiveFeed:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void) addBackButton
{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.origin.x +20, self.view.frame.size.height - 60, 70, 40)];
    [btn setTitle:@"Done" forState:UIControlStateNormal];
    [btn setTag:10000];
    [self.view addSubview:btn];
    [self.view setBackgroundColor:[UIColor greenColor]];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(doneLiveFeed:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTransform:CGAffineTransformMakeScale(1, -1)];
    [self.view bringSubviewToFront:btn];
}


#pragma mark -
#pragma mark OverlayViewControllerDelegate

// as a delegate we are being told a picture was taken
- (void)didTakePicture:(UIImage *)picture
{
    [self.capturedImages addObject:picture];
}

// as a delegate we are told to finished with the camera
- (void)didFinishWithCamera
{
    [self dismissModalViewControllerAnimated:NO];
    
    if ([self.capturedImages count] > 0)
    {
        if ([self.capturedImages count] == 1)
        {
            // we took a single shot
//            [self.imageView setImage:[self.capturedImages objectAtIndex:0]];
            UIImage *img = [self.capturedImages objectAtIndex:0];
            img = [img scaleProportionalToSize:CGSizeMake(420, 320)];
            [self startFaceDetectionWithImage:img];
            [self.capturedImages removeAllObjects];
            // Execute the method used to markFaces in background
//            [self performSelectorInBackground:@selector(detectAndMarkFace:) withObject:self.imageView];

            // flip image on y-axis to match coordinate system used by core image
//            [self.imageView setTransform:CGAffineTransformMakeScale(1, -1)];

            // flip the entire view to make everything right side up
//            [self.view setTransform:CGAffineTransformMakeScale(1, -1)];
        }
        else
        {
            // we took multiple shots, use the list of images for animation
//            self.imageView.animationImages = self.capturedImages;

            if (self.capturedImages.count > 0)
                // we are done with the image list until next time
                [self.capturedImages removeAllObjects];  
            
//            self.imageView.animationDuration = 5.0;    // show each captured photo for 5 seconds
//            self.imageView.animationRepeatCount = 0;   // animate forever (show all photos)
//            [self.imageView startAnimating];
        }
    }
}

@end