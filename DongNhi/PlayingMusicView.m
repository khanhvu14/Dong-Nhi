//
//  PlayingMusicView.m
//  DongNhi
//
//  Created by Vu Duy Khanh on 4/23/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "PlayingMusicView.h"

@implementation PlayingMusicView

static id sharePlaying;

@synthesize playPauseButton, prevButton, nextButon, nextSongUrl, currentSongUrl, prevSongUrl, audioPlayer, progressView, isPlay;

+ (id)sharePlaying
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharePlaying = [[self alloc] init];
    });
    return sharePlaying;
}

- (void) viewDidLoad{
    [super viewDidLoad];
   
    //prev button
    self.prevButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 60/2, 40, 20)];
    [self.prevButton setTitle:@"<<" forState:UIControlStateNormal];
    [self.prevButton addTarget:self action:@selector(prevSong:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.prevButton];
    
    
    // play button
    self.playPauseButton = [[UIButton alloc] initWithFrame:CGRectMake(55, 60/2, 40, 20)];
    [self.playPauseButton setTitle:@"Pa" forState:UIControlStateNormal];
    [self.playPauseButton addTarget:self action:@selector(togglePlayAndPause:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.playPauseButton];
    
    // next Button
    
    self.nextButon = [[UIButton alloc] initWithFrame:CGRectMake(100, 60/2, 40, 20)];
    [self.nextButon setTitle:@">>" forState:UIControlStateNormal];
    [self.nextButon addTarget:self action:@selector(nextSong:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextButon];
    
    // slider duration
    self.progressDuration = [[UISlider alloc] initWithFrame:CGRectMake(150, 60/2, 150, 20)];
    
    
    [self.progressDuration addTarget:self action:@selector(playingSliding:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.progressDuration];
}
- (id) initAudioPlayerWithUrl:(NSURL *)url andSongInfo:(NSMutableDictionary *)songInfo{
    self = [super init];
    if (self) {
        [self preparePlayWithUrl:url andSongInfo:songInfo];
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
        // [self.audioPlayer play];
        
    }
    return self;
}

- (IBAction)playingSliding:(UISlider *)sender {
    self.audioPlayer.currentTime = sender.value * [self.audioPlayer duration];
}

- (void)updateTime:(NSTimer *)timer {

    float progr = [self.audioPlayer currentTime]/[self.audioPlayer duration];
    
    self.progressDuration.value = progr;
}

- (void) preparePlayWithUrl:(NSURL *)url andSongInfo:(NSMutableDictionary *) songInfo{
    NSError *error;
    AVAudioPlayer *_audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    [_audioPlayer setNumberOfLoops:-1];
    
//    [songInfo setObject:[NSNumber numberWithDouble:_audioPlayer.duration]  forKey:MPMediaItemPropertyPlaybackDuration];
//    [songInfo setObject:[NSNumber numberWithInt:10] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
    [self loadNowPlayingInfo:songInfo];
    [_audioPlayer prepareToPlay];
    self.progressDuration.maximumValue = _audioPlayer.duration;
    self.progressDuration.value = 0.0f;
    self.progressDuration.minimumValue = 0.0f;
    self.audioPlayer = _audioPlayer;
}
- (IBAction) nextSong:(UIButton *)sender{
    [self.delegate didChangeSongInfoWithAction:@"next"];
}

- (IBAction) prevSong:(UIButton *)sender{
    [self.delegate didChangeSongInfoWithAction:@"prev"];
    
}

- (IBAction) togglePlayAndPause:(id)sender{
    [self togglePlayPause];
}

- (void) loadNowPlayingInfo:(NSMutableDictionary *)songInfo{
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songInfo];
}


- (void)viewDidAppear:(BOOL)animated {
    
    //Once the view has loaded then we can register to begin recieving controls and we can become the first responder
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    //End recieving events
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
}

- (void)playAudio {
    //Play the audio and set the button to represent the audio is playing
    [self.audioPlayer play];
    
}

- (void)pauseAudio {
    //Pause the audio and set the button to represent the audio is paused
    [self.audioPlayer pause];
}

- (void)togglePlayPause {
    //Toggle if the music is playing or paused

    if (!self.audioPlayer.playing) {
        [self playAudio];
        
        [self.playPauseButton setTitle:@"Pa" forState:UIControlStateNormal];
        
    } else if (self.audioPlayer.playing) {
        [self pauseAudio];
        [self.playPauseButton setTitle:@"Pl" forState:UIControlStateNormal];
    }
}

//Make sure we can recieve remote control events
- (BOOL)canBecomeFirstResponder {
    return YES;
}


- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    //if it is a remote control event handle it correctly
    
    if (event.type == UIEventTypeRemoteControl) {
        if (event.subtype == UIEventSubtypeRemoteControlPlay) {
            [self playAudio];
        } else if (event.subtype == UIEventSubtypeRemoteControlPause) {
            [self pauseAudio];
        } else if (event.subtype == UIEventSubtypeRemoteControlTogglePlayPause) {
            [self togglePlayPause];
        }else if(event.subtype == UIEventSubtypeRemoteControlNextTrack){
            [self.delegate didChangeSongInfoWithAction:@"next"];
        }else if(event.subtype == UIEventSubtypeRemoteControlPreviousTrack){
            [self.delegate didChangeSongInfoWithAction:@"prev"];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
