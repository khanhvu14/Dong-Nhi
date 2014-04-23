//
//  AprilViewController.m
//  DongNhi
//
//  Created by Vu Duy Khanh on 4/17/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "AprilViewController.h"
#import "GalleryCell.h"
#import "GalleryFlowLargeImage.h"
#import "GalleryFlowSmallImage.h"
#import "AprilPhotosViewController.h"
#import "AprilAppDelegate.h"

@interface AprilViewController ()

@property (nonatomic, strong) GalleryFlowLargeImage *largeLayout;
@property (nonatomic, strong) GalleryFlowSmallImage *smallLayout;
@property (nonatomic, strong) CHTCollectionViewWaterfallLayout *chtLayOut;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSMutableArray *cellSizes;
@end

@implementation AprilViewController


- (void)viewDidLoad
{
    self.largeLayout = [[GalleryFlowLargeImage alloc] init];
    self.smallLayout = [[GalleryFlowSmallImage alloc] init];
    self.chtLayOut = [[CHTCollectionViewWaterfallLayout alloc] init];
    
    self.chtLayOut.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.chtLayOut.minimumColumnSpacing = 1;
    self.chtLayOut.minimumInteritemSpacing = 1;
    
    
    gallery=[[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:self.chtLayOut];
    [gallery setDataSource:self];
    [gallery setDelegate:self];
    
    [gallery registerClass:[GalleryCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [gallery setBackgroundColor:[UIColor redColor]];
    
    [self.view addSubview:gallery];
    
    // test
    UISwipeGestureRecognizer *leftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handletap:)];
    leftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftGesture];
    
    UISwipeGestureRecognizer *rightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handletap:)];
    rightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightGesture];
    
    
    
    NSURL *audioFileLocationURL = [[NSBundle mainBundle] URLForResource:@"No-Promises-Shayne-Ward" withExtension:@"mp3"];
    
    NSMutableDictionary *albumInfo = [[NSMutableDictionary alloc] init];
    MPMediaItemArtwork *artWork = [[MPMediaItemArtwork alloc] initWithImage:[UIImage imageNamed:@"Shayne+Ward+++PNG"]];
    
    
    [albumInfo setObject:@"No Promises" forKey:MPMediaItemPropertyTitle];
    [albumInfo setObject:@"Shayne Ward" forKey:MPMediaItemPropertyArtist];
    [albumInfo setObject:@"No Promises" forKey:MPMediaItemPropertyAlbumTitle];
    [albumInfo setObject:artWork forKey:MPMediaItemPropertyArtwork];
    
    PlayingMusicView *playingMusic = [PlayingMusicView sharePlaying];
    
    [playingMusic preparePlayWithUrl:audioFileLocationURL andSongInfo:albumInfo];
    playingMusic.delegate = self;
    // [playingMusic.audioPlayer play];

}

- (void) didChangeSongInfoWithAction:(NSString *)action{
    if([action isEqualToString:@"next"]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"action next" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"action prev" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
}


- (void) handletap:(UIGestureRecognizer *)gesture{
    if (gallery.collectionViewLayout == self.chtLayOut)
    {
        [self.largeLayout invalidateLayout];
        [gallery setCollectionViewLayout:self.largeLayout animated:YES];
    }
    else
    {
        [self.smallLayout invalidateLayout];
        [gallery setCollectionViewLayout:self.chtLayOut animated:YES];
    }

}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 19;
}



- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GalleryCell *cell = (GalleryCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    [cell setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", indexPath.item % 4]]];
    
    return cell;
}

- (BOOL) collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    AprilPhotosViewController *photos = [[AprilPhotosViewController alloc] init];
    [self.navigationController pushViewController:photos animated:YES];
    
    return YES;
}

- (NSMutableArray *)cellSizes {
    if (!_cellSizes) {
        _cellSizes = [NSMutableArray array];
        for (NSInteger i = 0; i < 19; i++) {
            CGSize size = CGSizeMake(arc4random() % 50 + 50, arc4random() % 50 + 50);
            _cellSizes[i] = [NSValue valueWithCGSize:size];
        }
    }
    return _cellSizes;
}


#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // if([collectionViewLayout isKindOfClass:[CHTCollectionViewWaterfallLayout class]]){
        return [self.cellSizes[indexPath.item] CGSizeValue];
    //}
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
