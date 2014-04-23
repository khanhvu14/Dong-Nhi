//
//  AprilPhotosViewController.m
//  DongNhi
//
//  Created by Vu Duy Khanh on 4/18/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "AprilPhotosViewController.h"
#import "AprilAppDelegate.h"
const int kGalleryImageWidth = 320;
const int kGallerySpaceBetweenImage = 0;


@interface AprilPhotosViewController (){
    
    CGFloat scrollSize;
    NSDate *starTime;
    BOOL isHide;
}

@end

@implementation AprilPhotosViewController

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
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    
    CGRect innerScrollFrame = self.mainScrollView.bounds;
    
    for (NSInteger i = 0; i < 3; i++) {
        UIImageView *imageForZooming = [[UIImageView alloc] initWithFrame:self.view.frame];
        imageForZooming.image = [UIImage
                                 imageNamed:[NSString stringWithFormat:@"%d.jpg", i%4]];
        imageForZooming.tag = 100;
        [imageForZooming setContentMode:UIViewContentModeScaleToFill];
        
        /* trasition */
        CATransition *transition = [CATransition animation];
        transition.type = kCATransitionFade; // there are other types but this is the nicest
        transition.duration = 0.34; // set the duration that you like
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [imageForZooming.layer addAnimation:transition forKey:nil];
        
        UIScrollView *pageScrollView = [[UIScrollView alloc]
                                        initWithFrame:innerScrollFrame];
                [pageScrollView setContentMode:UIViewContentModeScaleAspectFit];
        pageScrollView.minimumZoomScale = 1.0f;
        pageScrollView.maximumZoomScale = 5.0f;
        pageScrollView.zoomScale = 1.0f;
        pageScrollView.contentSize = imageForZooming.bounds.size;
        pageScrollView.delegate = self;
        pageScrollView.showsHorizontalScrollIndicator = NO;
        pageScrollView.showsVerticalScrollIndicator = NO;
        [pageScrollView addSubview:imageForZooming];
        
        [self.mainScrollView addSubview:pageScrollView];
        
        innerScrollFrame.origin.x += innerScrollFrame.size.width;
        
    }
    scrollSize = innerScrollFrame.origin.x;
    self.mainScrollView.contentSize = CGSizeMake(innerScrollFrame.origin.x, self.mainScrollView.bounds.size.height);
    
    [self.view addSubview:self.mainScrollView];
    
    isHide = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideOutOfView)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void) hideOutOfView{
    AprilAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    CGRect mainFrame = [[UIScreen mainScreen] applicationFrame];
    CGRect layoutFrame = self.navigationController.view.frame;
    CGRect statiCViewFrame = appDelegate.playIngController.view.frame;
    if(isHide){
        

        layoutFrame.size.height = mainFrame.size.height + 20;
        statiCViewFrame.origin.y = mainFrame.size.height + 20;
        
        [UIView animateWithDuration:0.5
                              delay:.3
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             self.navigationController.view.frame = layoutFrame;
                             appDelegate.playIngController.view.frame = statiCViewFrame;
                             [[self navigationController] setNavigationBarHidden:YES animated:NO];
                         }
                         completion:^(BOOL finished){
                         }];
        
    }else{
        
        layoutFrame.size.height = mainFrame.size.height - 60 + 20;
        statiCViewFrame.origin.y = mainFrame.size.height - 60 + 20;
        
        [UIView animateWithDuration:0.5
                              delay:.3
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             self.navigationController.view.frame = layoutFrame;
                             appDelegate.playIngController.view.frame = statiCViewFrame;
                             [[self navigationController] setNavigationBarHidden:NO animated:NO];
                         }
                         completion:^(BOOL finished){
                         }];
    }
    isHide = !isHide;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void) dissmissView{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


- (UIScrollView *) scrollView {
    CGFloat currentOffset = self.mainScrollView.contentOffset.x;
    NSLog(@"%f", currentOffset);
    NSLog(@"content size %f", self.mainScrollView.contentSize.width);
    if(currentOffset >= self.mainScrollView.contentSize.width){
        [self.mainScrollView setContentOffset:CGPointMake(0, self.mainScrollView.bounds.size.height) animated:YES];
    }else{
        [self.mainScrollView setContentOffset:CGPointMake(currentOffset, self.mainScrollView.bounds.size.height) animated:YES];
    }
    return self.mainScrollView;
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [scrollView viewWithTag:100];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
