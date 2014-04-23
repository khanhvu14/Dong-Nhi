//
//  PlayingMusicView.h
//  DongNhi
//
//  Created by Vu Duy Khanh on 4/23/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>


@class PlayingMusicView;

@protocol PlayingMusicViewDelegate;

@interface PlayingMusicView : UIViewController

@property (nonatomic, strong) IBOutlet UIButton *playPauseButton;

@property (nonatomic, strong) IBOutlet UIButton *nextButon;

@property (nonatomic, strong) IBOutlet UIButton *prevButton;

@property (nonatomic, strong) IBOutlet UIProgressView *progressView;

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@property (nonatomic, strong) IBOutlet UISlider *progressDuration;

@property (nonatomic, strong) NSURL *currentSongUrl;
@property (nonatomic, strong) NSURL *nextSongUrl;
@property (nonatomic, strong) NSURL *prevSongUrl;

@property BOOL isPlay;
- (id) initAudioPlayerWithUrl:(NSURL *)url andSongInfo:(NSMutableDictionary *)songInfo;
- (void) preparePlayWithUrl:(NSURL *)url andSongInfo:(NSMutableDictionary *) songInfo;
- (IBAction) togglePlayAndPause:(id)sender;
- (IBAction) nextSong:(id)sender;
- (IBAction) prevSong:(id)sender;
- (void) loadNowPlayingInfo:(NSMutableDictionary *) songInfo;
+ (id)sharePlaying;
- (void) playAudio;
- (void) pauseAudio;

@property (strong, nonatomic) id <PlayingMusicViewDelegate> delegate;
@end

@protocol PlayingMusicViewDelegate <NSObject>

@optional
- (void) didChangeSongInfoWithAction:(NSString *) action;

@end