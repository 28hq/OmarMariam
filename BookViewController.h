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
	
	int bookNumber;
	NSMutableArray *images;
	
	BOOL playBtnPositionIsRight, showSound;
	UIButton *btnPlay;
	
	AVAudioPlayer* soundPlay;
	NSString *pathToMusicFile;
	
@private
		UIViewControllerAnimationTransition transitionType;
}

@property int bookNumber;
@property BOOL playBtnPositionIsRight, showSound;
@property (nonatomic, retain) UIButton *btnPlay;
@property (nonatomic) UIViewControllerAnimationTransition transitionType;

- (id)initWithBookNumber:(int)bookNumber ;
- (void)playSound:(id)sender;

@end
