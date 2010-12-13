//
//  ExampleViewController.h
//  Leaves
//
//  Created by Tom Brow on 4/18/10.
//  Copyright 2010 Tom Brow. All rights reserved.
//

#import "LeavesViewController.h"
#import <UIKit/UIKit.h>
#import "UIViewController-Extended.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>

@interface BookViewController : LeavesViewController <AVAudioPlayerDelegate> {
	
	int bookNumber, bookVolume;
	NSMutableArray *images;
	
	BOOL playBtnPositionIsRight, showSound;
	UIButton *btnPlay;
	UIButton *leftPlayButton;
	UIButton *activeButtonPlayed;
	
	AVAudioPlayer* soundPlay;
	NSString *pathToMusicFile;
	
@private
		UIViewControllerAnimationTransition transitionType;
}

@property int bookNumber;
@property int bookVolume;
@property BOOL playBtnPositionIsRight, showSound;
@property (nonatomic, retain) UIButton *btnPlay;
@property (nonatomic, retain) UIButton *leftPlayButton;
@property (nonatomic, retain) UIButton *activeButtonPlayed;
@property (nonatomic) UIViewControllerAnimationTransition transitionType;

- (id)initWithBook:(int)bookNumber ofVolume:(int)bookVolume;
- (void)playSound:(id)sender;
- (void)exitBook;
- (void)clearPlayButtonAttributesForButton:(UIButton *)aButton;

@end
