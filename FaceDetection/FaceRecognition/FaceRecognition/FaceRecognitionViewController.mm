//
//  ViewController.m
//  FaceRecognition
//

#import "opencv2/opencv.hpp"
#import "FaceRecognitionViewController.h"
#import "facerec.hpp"

@interface FaceRecognitionViewController ()

@end

@implementation FaceRecognitionViewController

- (IplImage *)CreateIplImageFromUIImage:(UIImage *)image
{
    // Getting CGImage from UIImage
    CGImageRef imageRef = image.CGImage;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // Creating temporal IplImage for drawing
    IplImage *iplimage = cvCreateImage(cvSize(image.size.width,image.size.height), IPL_DEPTH_8U, 4);
    
    // Creating CGContext for temporal IplImage
    CGContextRef contextRef = CGBitmapContextCreate(iplimage->imageData, iplimage->width, iplimage->height,
                                                    iplimage->depth, iplimage->widthStep,
                                                    colorSpace, kCGImageAlphaPremultipliedLast|kCGBitmapByteOrderDefault);
    // Drawing CGImage to CGContext
    CGContextDrawImage(contextRef, CGRectMake(0, 0, image.size.width, image.size.height), imageRef);
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpace);
    
    // Creating result IplImage
    IplImage *ret = cvCreateImage(cvGetSize(iplimage), IPL_DEPTH_8U, 3);
    cvCvtColor(iplimage, ret, CV_RGBA2BGR);
    cvReleaseImage(&iplimage);
    
    return ret;
}

-(void)tryMatchFaceWithTrainingUserSet:(int) numberOfSubjects matchAgainst:(NSString*)targetImagePath
{
    self.mode = Recognition;

    // load images
    vector<Mat> images;
    vector<int> labels;
    
//    int numberOfSubjects = 1;
    int numberPhotosPerSubject = 7;

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *baseDir = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSString *trainingSetDir = [baseDir stringByAppendingPathComponent:@"TrainingSetUser1"];
//    NSString *recognitionSetDir = [baseDir stringByAppendingPathComponent:@"RecognitionSetUser2"];

    for (int i=1; i<=numberOfSubjects; i++) {
        for (int j=1; j<=numberPhotosPerSubject; j++) {
            // create grayscale images
            Mat src = [self CreateIplImageFromUIImage:[UIImage imageWithContentsOfFile:[trainingSetDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%d_%d.jpg", i, j]]]];
            Mat dst;
            cv::cvtColor(src, dst, CV_BGR2GRAY);
//            cv::resize(src, dst, dst.size());

            images.push_back(dst);
            labels.push_back(i);
        }
    }

    NSLog(@"Number of subjects are:%d", numberOfSubjects);
    // get test instances
    Mat testSample = [self CreateIplImageFromUIImage:[UIImage imageWithContentsOfFile:targetImagePath]];//images[images.size() -1];
    Mat testSampleFinal;
    cv::cvtColor(testSample, testSampleFinal, CV_BGR2GRAY);

    int testLabel = labels[0];

//    cv::resize(src, dst, dst.size());

    // ... and delete last element
//    images.pop_back();
//    labels.pop_back();

    // build the Fisherfaces model
    Fisherfaces model(images, labels);
    
    // test model
    int predicted = model.predict(testSampleFinal);
    cout << "predicted index of match from training set = " << predicted << endl;

    cout << "actual index of match from training set = " << testLabel << endl;

    if (predicted >0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"A match was found!"
                                                            message:[NSString stringWithFormat:@"Match found in %d (th)", predicted]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Dismiss"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
