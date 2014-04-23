//
//  AprilCustomViewController.m
//  DongNhi
//
//  Created by Vu Duy Khanh on 4/22/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "AprilCustomViewController.h"

@interface AprilCustomViewController ()

@end

@implementation AprilCustomViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
    
}


- (id)initWithViewController:(UIViewController*)viewController staticView:(UIView*)staticView;
{
    self = [super init];
    if (self) {

        CGRect navigationControllerFrame = self.view.bounds;
        navigationControllerFrame.size.height -= 60;
        viewController.view.frame = navigationControllerFrame;
        
        
        CGRect bottomViewFrame = CGRectMake(0, self.view.bounds.size.height-60, self.view.bounds.size.width, 60);
        staticView.frame = bottomViewFrame;
        
        
        viewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        staticView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        
        
        [self.view addSubview:viewController.view];
        [self.view addSubview:staticView];
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
