//
//  AprilAppDelegate.h
//  DongNhi
//
//  Created by Vu Duy Khanh on 4/17/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "PlayingMusicView.h"

@interface AprilAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navigationController;

@property (strong, nonatomic) PlayingMusicView *playIngController;

@end
