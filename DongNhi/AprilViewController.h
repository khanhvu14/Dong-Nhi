//
//  AprilViewController.h
//  DongNhi
//
//  Created by Vu Duy Khanh on 4/17/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHTCollectionViewWaterfallLayout.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "PlayingMusicView.h"


@interface AprilViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CHTCollectionViewDelegateWaterfallLayout, PlayingMusicViewDelegate>
{
    UICollectionView *gallery;
}
@property (nonatomic, retain) AVAudioPlayer *audioPlayer;

@end
