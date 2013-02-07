//
//  MainViewController.m
//  FaceDetection
//
//  Created by Praveen Jha on 06/02/13.
//  Copyright (c) 2013 JID Marketing. All rights reserved.
//

#import "MainViewController.h"
#import "MyViewController.h"
#import "LiveFeedViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
    [self addActionButtons];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:arc4random() % 100 / 100.0f green:arc4random() % 100 / 100.0f blue:arc4random() % 100 / 100.0f alpha:0.0f];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tryLiveFeedDetection:(id)sender
{
    LiveFeedViewController *lVC = [[LiveFeedViewController alloc] initWithNibName:@"LiveFeedViewController" bundle:nil];
    [self.navigationController pushViewController:lVC animated:YES];
}

-(void)tryLiveFeedRecognition:(id)sender
{
    //TODO:
}

-(void)tryStaticRecognition:(id)sender
{
    //TODO:
}

-(void)tryStaticFaceDetection:(id)sender
{
    MyViewController *viewController = [[MyViewController alloc] initWithNibName:@"StaticPhotoController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void) addActionButtons
{
    [self.view setBackgroundColor:[UIColor greenColor]];

    // Try static face Recognition button
    UIButton *btnStaticDetection = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.origin.x +20, 50, self.view.frame.size.width -40, 40)];
    [btnStaticDetection setTitle:@"Try Static Face Detection" forState:UIControlStateNormal];
    [self.view addSubview:btnStaticDetection];
    [btnStaticDetection setBackgroundColor:[UIColor redColor]];
    [btnStaticDetection addTarget:self action:@selector(tryStaticFaceDetection:) forControlEvents:UIControlEventTouchUpInside];
//    [btnStaticDetection setTransform:CGAffineTransformMakeScale(1, -1)];

    // Try live feed face detection button
    UIButton *btnLiveFeedDetection = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.origin.x +20, 95, self.view.frame.size.width -40, 40)];
    [btnLiveFeedDetection setTitle:@"Try Live Feed Face Detection" forState:UIControlStateNormal];
    [self.view addSubview:btnLiveFeedDetection];
    [btnLiveFeedDetection setBackgroundColor:[UIColor redColor]];
    [btnLiveFeedDetection addTarget:self action:@selector(tryLiveFeedDetection:) forControlEvents:UIControlEventTouchUpInside];
//    [btnLiveFeedDetection setTransform:CGAffineTransformMakeScale(1, -1)];

    // Try live feed face Recognition button
    UIButton *btnLiveFeedRecognition = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.origin.x +20, 140, self.view.frame.size.width -40, 40)];
    [btnLiveFeedRecognition setTitle:@"Try Live Feed Face Recognition" forState:UIControlStateNormal];
    [self.view addSubview:btnLiveFeedRecognition];
    [btnLiveFeedRecognition setBackgroundColor:[UIColor redColor]];
    [btnLiveFeedRecognition addTarget:self action:@selector(tryLiveFeedRecognition:) forControlEvents:UIControlEventTouchUpInside];
//    [btnLiveFeedRecognition setTransform:CGAffineTransformMakeScale(1, -1)];

    // Try static face Recognition button
    UIButton *btnRecognition = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.origin.x +20, 185, self.view.frame.size.width -40, 40)];
    [btnRecognition setTitle:@"Try Static Face Recognition" forState:UIControlStateNormal];
    [self.view addSubview:btnRecognition];
    [btnRecognition setBackgroundColor:[UIColor redColor]];
    [btnRecognition addTarget:self action:@selector(tryStaticRecognition:) forControlEvents:UIControlEventTouchUpInside];
//    [btnRecognition setTransform:CGAffineTransformMakeScale(1, -1)];

}

@end
